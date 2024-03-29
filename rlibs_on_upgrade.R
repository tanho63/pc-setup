#' Script from Sebastian Carl (https://twitter.com/mrcaseb)

### BEFORE UPGRADE
mypkgs <- pak::pkg_list()
saveRDS(mypkgs, "mypkgs.rds")

### NOW UPGRADE R
### Tan: I like choco/powershell here, and may as well upgrade rstudio at same time
## choco install -y r r.studio r.tools

### AFTER UPGRADE
mypkgs <- readRDS("mypkgs.rds")
inst <- mypkgs$package[mypkgs$repository %in% c("CRAN", "RSPM")]
install.packages(inst, type = "binary")

### Most packages should be back let's check what we have now
now <- pak::pkg_list()

### Are there packages missing (because they were'nt installed from CRAN)
missing <- mypkgs[!mypkgs$package %in% now$package, ]

### If pkgs were installed from github we can create the name/repo vector here
add <- paste0(missing$remoteusername, "/", missing$remoterepo)
add <- add[!add %in% "NA/NA"]

### Now install the github pkgs
pak::pak(add)

### After Github installation there shouldn't be much left (most likely pkgs)
### that were installed locally. Check what is missing and think about how to
### install them
now <- pak::pkg_list()
missing <- mypkgs[!mypkgs$package %in% now$package, ]
