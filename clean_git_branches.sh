#!/bin/bash

# Git Repository Maintenance Script
# Purpose: Scan all git repositories in home directory and clean up stale branches
# that have been deleted on the remote server (i.e. PR merged)

# Save the current directory to return to it when the script exits
ORIGINAL_DIR=$(pwd)

# Set up a trap to ensure we return to the original directory
# even if the script is interrupted (EXIT, INT for Ctrl+C, TERM for kill)
trap 'cd "$ORIGINAL_DIR"' EXIT INT TERM

# Function to get current timestamp
get_timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

# Initialize counters and lists
# Note: We use temp files to track counts because the while loop runs in a subshell
TEMP_TOTAL=$(mktemp)
TEMP_SUCCESS=$(mktemp)
TEMP_FAILED=$(mktemp)
echo "0" > "$TEMP_TOTAL"
echo "0" > "$TEMP_SUCCESS"
: > "$TEMP_FAILED"  # Create empty file for failed repos list

# Clean up temp files on exit
trap 'rm -f "$TEMP_TOTAL" "$TEMP_SUCCESS" "$TEMP_FAILED"; cd "$ORIGINAL_DIR"' EXIT INT TERM

# Start the scanning process
echo "[$(get_timestamp)] [info] Scanning for git repositories in $HOME..."
echo "[$(get_timestamp)] [info] (Skipping hidden directories)"
echo "========================================="

# Find all .git directories in the home folder, excluding hidden directories
# -not -path '*/.*/*' excludes any path containing a hidden directory
# 2>/dev/null suppresses permission denied errors
find "$HOME" -maxdepth 10 -type d -name ".git" -not -path '*/.*/*' 2>/dev/null | while read gitdir; do
    # Get the parent directory of .git (the actual repository folder)
    repo_dir=$(dirname "$gitdir")

    # Additional check: Skip if the repository itself is in a hidden folder
    # This catches cases where the repo folder itself starts with a dot
    if [[ "$(basename "$repo_dir")" == .* ]]; then
        continue
    fi

    # Skip submodules and nested .git directories (like .git/modules/*)
    if [[ "$repo_dir" == *"/.git/"* ]]; then
        continue
    fi

    # Increment total repository counter
    current_total=$(cat "$TEMP_TOTAL")
    ((current_total++))
    echo "$current_total" > "$TEMP_TOTAL"

    # Display which repository we're processing
    echo ""
    echo "[$(get_timestamp)] [info] [$current_total] Processing: $repo_dir"
    echo "---"

    # Try to change to the repository directory
    if ! cd "$repo_dir" 2>/dev/null; then
        echo "[$(get_timestamp)] [error] Failed to enter directory"
        # Add to failed repos list
        echo "$repo_dir" >> "$TEMP_FAILED"
        continue
    fi

    # Initialize success flag for this repository
    repo_success=true

    # Fetch updates from remote and prune deleted remote branches
    # -p flag removes any remote-tracking references that no longer exist on the remote
    echo "[$(get_timestamp)] [info] Fetching and pruning remote branches..."
    if git fetch -p 2>/dev/null; then
        fetch_result=0
        echo "[$(get_timestamp)] [success] Fetch completed"
    else
        fetch_result=$?
        repo_success=false
        echo "[$(get_timestamp)] [warn] Fetch failed with code $fetch_result"
    fi

    # Find and delete local branches whose remote counterparts are gone
    # This happens when branches are merged and deleted on the remote (e.g., GitHub/GitLab)
    deleted_count=0
    echo "[$(get_timestamp)] [info] Checking for stale local branches..."

    # Get list of branches that are tracking deleted remote branches
    stale_branches=$(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | \
                     awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}')

    if [[ -n "$stale_branches" ]]; then
        # Delete each stale branch
        for branch in $(echo "$stale_branches"); do
            echo "[$(get_timestamp)] [warn] Deleting stale branch: $branch"
            if git branch -D "$branch" 2>/dev/null; then
                ((deleted_count++))
            else
                echo "[$(get_timestamp)] [error] Failed to delete branch: $branch"
                repo_success=false
            fi
        done

        if [[ $deleted_count -gt 0 ]]; then
            echo "[$(get_timestamp)] [success] Deleted $deleted_count stale branch(es)"
        fi
    else
        echo "[$(get_timestamp)] [success] No stale branches found"
    fi

    # Run git garbage collection to optimize the repository
    echo "[$(get_timestamp)] [info] Running garbage collection..."
    if git gc --auto 2>/dev/null; then
        echo "[$(get_timestamp)] [success] Garbage collection completed"
    else
        repo_success=false
        echo "[$(get_timestamp)] [warn] Garbage collection failed"
    fi

    # Update success counter if all operations succeeded
    if [[ "$repo_success" == true ]]; then
        current_success=$(cat "$TEMP_SUCCESS")
        ((current_success++))
        echo "$current_success" > "$TEMP_SUCCESS"
        echo "[$(get_timestamp)] [success] Repository maintenance completed successfully"
    else
        # Add to failed repos list
        echo "$repo_dir" >> "$TEMP_FAILED"
        echo "[$(get_timestamp)] [warn] Repository maintenance completed with warnings"
    fi
done

# Read final counts from temp files
total_repos=$(cat "$TEMP_TOTAL")
successful_repos=$(cat "$TEMP_SUCCESS")

# Display summary
echo ""
echo "========================================="
echo "[$(get_timestamp)] [info] Repository maintenance complete!"
echo "[$(get_timestamp)] [info] Total repositories processed: $total_repos"
echo "[$(get_timestamp)] [info] Successful updates: $successful_repos"

# Calculate and display repositories with issues if any
if [[ $total_repos -gt $successful_repos ]]; then
    failed_repos=$((total_repos - successful_repos))
    echo "[$(get_timestamp)] [warn] Repositories with issues: $failed_repos"

    # List all failed repositories
    if [[ -s "$TEMP_FAILED" ]]; then
        echo ""
        echo "[$(get_timestamp)] [warn] The following repositories had issues:"
        while IFS= read -r failed_repo; do
            echo "[$(get_timestamp)] [error] $failed_repo"
        done < "$TEMP_FAILED"
    fi
fi

# Return to original directory (trap will handle this, but being explicit)
cd "$ORIGINAL_DIR"
echo ""
echo "[$(get_timestamp)] [success] Returned to: $(pwd)"
