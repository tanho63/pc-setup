# Linux Laptop Adventures

This page will document setting up my new Framework Laptop with Ubuntu 21.04 🎉 (KDE)

I'm extremely excited about [Framework](https://frame.work/) and the idea of a modern, repairable, modular laptop - the ethos is awesome! I think it's a great opportunity to embrace the independence and also go with a Linux install instead of Windows - if this goes well enough I'll probably start dualbooting Windows/Linux on my main desktop also 🤓

I'll live stream this on Twitch: [https://twitch.tv/tanho_](https://twitch.tv/tanho_) and possibly post a recording afterwards. 

## Parts/Specs

Framework DIY edition

- CPU/iGPU: Intel i7-1165G7
- RAM: 1x16GB DDR4-3200 
- SSD: 500GBWD_BLACK SN750
- WiFi: Intel AX210 (no vPro)
- Expansion cards: 2x USB-A, 2x USB-C
- Power Adapter

Total cost: $1688.50 CAD before tax, $1908.01 CAD after tax

## Hardware Setup

Guide here: https://guides.frame.work/Guide/Framework+Laptop+DIY+Edition+Quick+Start+Guide/57

Guide was great - the wifi module was a tad finicky but getting out some tweezers helped me hold the antenna cables in a consistent position/angle, and then it worked pretty smoothly from there!

## Linux distro: Kubuntu 21.04

Going with [Kubuntu 21.04](http://cdimage.ubuntu.com/kubuntu/releases/hirsute/release/): 

- Ubuntu 21.04 looks like the most compatible version of Ubuntu at the moment per Framework Community forums, because 21.10 is slightly too bleeding edge to make for a smooth install for a first-time Linux desktop user. May upgrade afterwards if Framework Community reviews improve. 
- KDE looks most-similar to Windows, is (reportedly) very configurable, and comes with some decent looking (if somewhat silly-named - Dolphin? Konsole? really?) utilities, and has really nice reviews. 

I might enjoy this enough to try Manjaro/Arch someday but I'll give this a go first to get my feet wet. I'm no stranger to Linux `servers` so I think I'll be comfortable navigating desktop and terminal modes.

## OS install

Straightforward enough with Ubuntu 21.04 install guides from framework https://community.frame.work/t/ubuntu-21-04-on-the-framework-laptop/2722

## Fingerprint reader setup

Fingerprint install was frustrating, eventually did the (admittedly dumb) "trust a user on the internet" thing and just installed from https://github.com/cfsmp3/linux_framework_laptop/tree/master/fingerprint_reader, which mostly worked. I did have to disable log-on-with-fingerprint and now it's mostly useful within sudo, which is also fine by me.

## Mouse configs
Logitech Triathlon mouse drivers - inistalled [logiops](https://github.com/PixlOne/logiops) with `sudo snap install logiops` and then configured all the gestures myself. Gestures here: [https://github.com/tanho63/pc-setup/blob/main/logiops.cfg] and mostly a holdover from what I use on Windows also. 

## Install R/RStudio

https://cran.rstudio.com/bin/linux/ubuntu/ for the base R installation (but remembered to take r-base-dev also!)

RStudio via https://www.rstudio.com/products/rstudio/#rstudio-desktop was also straightforward enough

## Install R packages
  
```r
  install.packages("pak", repos = "https://r-lib.github.io/p/pak/dev/")
```

<details>
<summary>R packages</summary> 

```r
      pkgs <- c("arrow",
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
        "stringr",
        "stringi",
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
        # github pkgs
        "nflverse/nflfastR",
        "nflverse/nflreadr",
        "ffverse/ffscrapr@dev",
        "ffverse/ffsimulator@dev",
        "ffverse/ffpros@dev",
        "gadenbuie/rsthemes@main",
        "tanho63/tantastic",
        "tanho63/joker",
        "hadley/emo",
        "gadenbuie/xaringanExtra")
 ```
</details>
   
```r
  # loop through and find Linux dependencies
   lapply(pkgs, function(x) pak::pkg_system_requirements(x, sudo = TRUE, os_release = 20.04)) |> 
     unlist() |> 
     unique() |>
     cat(sep = "\n")
  # copy-paste into terminal and execute as sudo
  
  pak::pak(pkgs)
```

## Install fav apps
  
  - Discord
  - Slack
  - Spotify
  - LibreOffice
  - Typora
  - OBS Studio
  - GIMP
  - Inkscape
  - VS Code
  - Zoom
  
  mostly via snap
  
  ```
  sudo snap install discord spotify libreoffice typora obs-studio inkscape code
  sudo snap install slack --classic
  sudo snap install zoom-client --classic
  ```
