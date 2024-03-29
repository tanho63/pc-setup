# Windows 10 PC Setup

Documenting a from-scratch installation and configuration of Windows 10 for a data scientist/developer primarily using R, SQL, and day-to-day computing. 

## Hardware

A home-built PC with this [parts list](https://ca.pcpartpicker.com/list/fqnDht).

## Windows 10 Installation

Create a Windows 10 USB stick via [this Microsoft tool](https://support.microsoft.com/en-us/windows/create-installation-media-for-windows-99a58364-8c02-206f-aa6f-40c3b507420d). 

Boot the USB installation media, format the drive (I'm using the NVME drive) and run through the installation. 

## Windows 10 Setup and Updates

Set up local account, skipping through all the dialogues (choosing not to send Microsoft your data, not using Cortana, not using location services etc). 

Open Windows Update and download/install updates. Reboot. Check for updates again. Reboot.

## Install/update hardware

A new install means you need to update a bunch of drivers for the various hardware components so that my PC is running optimally. 

The CPU/GPU in my case are AMD Ryzen 3600X and AMD Radeon 5600XT - that means installing the latest from [AMD](https://www.amd.com/en/support). 

I'm also going to install the driver for the bluetooth/wifi card (TP-Link Archer TX3000E)

Finally, I use a Logitech Triathlon mouse and like to have the configurable shortcuts and gestures, so will install the [appropriate software](https://www.logitech.com/en-ca/product/options).

As an aside, here's my mouse gestures configuration: 

![](https://i.imgur.com/Nw4VZII.png)

Clicking the gesture button is play/pause, gesture left/right is volume down/up, and gesture up/down is maximize/switch windows. 

![](https://i.imgur.com/i2mwciv.png)

I abandoned left and right scroll in favour of mapping the ctrl-c and ctrl-v shortcuts to it - this lets me copy-paste a selection without moving my hand off the mouse!


## Install Chocolatey

[Chocolatey](https://chocolatey.org/install) is a package manager that helps install software and packages from the command line, so that you're not navigating through boxes. 

I press Start, type powershell, right click to run it as administrator, and then copy-paste this line from chocolatey's install page into the terminal prompt

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

While that's installing, I get busy getting rid of Microsoft Clutter (TM) from my machine - uninstalling every possible tile from the start menu, getting rid of cortana and search bars from my taskbar. If I need to search, I can press start and then just type whatever I'm searching for on my PC. If I need web search, I pull up a browser and search there. 

## Install some SWEET STUFF with CHOCOLATEY

Chocolatey is pretty awesome and will let me install a whole whack of programs and packages on my machine with just a terminal command. 

```
choco install -y firefox slack discord spotify vlc inkscape sharex gimp libreoffice-fresh 7zip.install git.install r rtools python3 jdk8 jre8 silverlight dotnetfx vcredist-all putty.install malwarebytes vscode foxitreader pdfcreator ccleaner mysql.workbench steam obs-studio.install zoom docker-cli docker-desktop wsl2 r.studio typora
```

Brief rundown of apps and what they do:

*Daily usage*

- Firefox - cause Edge sucks
- Slack, Discord - communication platforms
- Spotify - music service
- VLC - video player
- inkscape - vector graphics editor
- GIMP - bitmap graphics editor (i.e. photoshop equiv)
- sharex - screen recorder
- libreoffice - free Microsoft Office suite
- 7zip - extracting and compressing zipped files
- malwarebytes - a fixit antivirus tool (less good for active defense)
- Foxit Reader - a PDF reader
- PDF Creator - a PDF printer (i.e. writes PDF)
- CCleaner - cleans registry and hard drive, occasionally useful
- Steam - for games!
- OBS - stream software
- Zoom - video calls
- Typora - simple markdown editor

*Programming & Dependencies*

- git - version control command line software
- R - my baby
- R.studio - my baby's UI
- rtools - helps my baby
- python3 - a dependency, also helpful for some other stuff
- jdk8 and jre8 - Java dev and runtimes, useful dependencies to install now
- silverlight - dependency
- vcredist -dependencies
- .Net 4.7 - useful dependency for various programs
- putty - a tool for connecting to remote servers via SSH
- Visual Studio Code - for the few bits of non-R code that I need to look at and don't want to look at in RStudio
- MySQL Workbench - a GUI for accessing SQL databases
- docker-cli - containers!
- docker-desktop - running the containers!
- wsl2 - Windows Subsystem for Linux 2 - allows Linux based docker to run on windows!

~~I'll need to download and install RStudio separately because I want the latest preview version (all them rainbow bracketses!) but you can also install RStudio via Chocolatey if you prefer the stable version.~~ now install RS via choco, features I wanted (rainbow parens, memory tracking, command palette etc) are now on the public release

## Install Firefox Addons

- ~~LastPass~~ BitWarden, my password manager of choice
- uBlock Origin - adblock!
- Checker Plus for Gmail - an addon that helps me with Gmail

## Install R packages

<details>
  <summary> A long list of packages </summary>

```
install.packages("pak", repos = "https://r-lib.github.io/p/pak/dev/")
r <- getOption("repos")
r["CRAN"] <- "https://packagemanager.rstudio.com/all/latest"
options(repos = r)

c("arrow",
  "beepr",
  "bench",
  "blogdown",
  "bookdown",
  "broom",
  "bs4Dash",
  "checkmate",
  "crul",
  "curl",
  "data.table",
  "datapasta",
  "DBI",
  "dbplyr",
  "devtools",
  "earth",
  "echarts4r",
  "extrafont",
  "foreach",
  "furrr",
  "future",
  "gargle",
  "gert",
  "gfonts",
  "gganimate",
  "ggbeeswarm",
  "gghighlight",
  "ggimage",
  "ggiraph",
  "ggrepel",
  "gh",
  "golem",
  "googledrive",
  "googlesheets4",
  "gt",
  "here",
  "Hmisc",
  "hms",
  "hrbrthemes",
  "httptest",
  "httr",
  "janitor",
  "jsonlite",
  "knitr",
  "learnr",
  "lobstr",
  "magick",
  "magrittr",
  "odbc",
  "parsnip",
  "pkgdown",
  "plotly",
  "praise",
  "profmem",
  "profvis",
  "ps",
  "ragg",
  "rappdirs",
  "Rcpp",
  "reactable",
  "rhub",
  "rlang",
  "rstudioapi",
  "rtweet",
  "rvest",
  "sever",
  "sf",
  "shiny",
  "shinyjs",
  "shinyMobile",
  "shinyWidgets",
  "showtext",
  "skimr",
  "slider",
  "sloop",
  "tensorflow",
  "testthat",
  "tidymodels",
  "tidytext",
  "tidyverse",
  "tinytex",
  "waiter",
  "writexl",
  "xaringan",
  "xgboost",
  "yardstick",
  # these ones from GitHub, not CRAN
  "nflverse/nflfastR",
  "nflverse/nflreadr",
  "ffverse/ffscrapr@dev",
  "ffverse/ffsimulator@dev",
  "ffverse/ffpros@dev",
  "gadenbuie/rsthemes@main",
  "tanho63/tantastic",
  "tanho63/joker",
  "hadley/emo",
  "gadenbuie/xaringanExtra"
) |> pak::pak()

```

  </summary>
  
# Revisions

- 2021-09-15 - now uses choco to install RStudio, since the build of RS I wanted is now available via choco (1.4)
- 2021-09-29 - revisions to choco desktop list and other general
