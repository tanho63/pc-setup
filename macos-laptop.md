# MacOS

New work laptop, new setup notes! My first ever with MacOS so this may be ... interesting. 

Garrick's notes are what inspired me to start logging in the first place, so it'll be nice to have someone else's to refer to for a change :) 

- [tweet thread](https://www.garrickadenbuie.com/blog/setting-up-a-new-macbook-pro/) 
- [install notes](https://gist.github.com/gadenbuie/a14cab3d075901d8b25cbaf9e1f1fa7d)

I'll also probably broadly follow some of my past notes too.

## Machine info

MacBook Pro (16", 2021) with an Apple M1 Pro chip and 16GB RAM. 

## Update

It comes pre-installed with MacOS Monterey 12.3, so first order of business is updating to 12.5. 

## Installs

- A terminal: https://iterm2.com
- `xcode-select --install` 
- homebrew: https://brew.sh/
- Basics
  - manual install M1 version of R https://cloud.r-project.org/bin/macosx/ 
  - `brew install git gh docker docker-compose svn`
  - `brew install --cask slack discord vscode firefox rstudio docker obsidian`
- Fonts
  - `brew tap homebrew/cask-fonts`
  - `brew install --cask font-ibm-plex font-bai-jamjuree font-jetbrains-mono font-work-sans font-open-sans`
- Utils
  - `brew install --cask flycut kap shottr alt-tab` these are all awesome at their jobs - better copypaste, screen recording, screen capture, and window switching
- Utils from Garrick I'm not yet sure on:
  - `brew install bit-git bat nat tldr node`
  - `brew install --cask Alfred figma`
  
## Assorted config
Mostly stolen from Garrick

> Looking for other things I can tweak while I wait. Hot corners?
> 
> ↗️ Mission Control
> ↘️ Desktop
> ↙️ Application Windows
> ↖️ Put Display to Sleep (and add require password immediately)

Mouse software https://www.logitech.com/en-ca/product/options

Configured shortcuts like my windows guide: https://github.com/tanho63/pc-setup/blob/main/windows-desktop.md#installupdate-hardware
