#! /bin/bash

# 2023-11-26: mudkip cleanstart with Ubuntu 22.04
# 
# As an upgrade on previous notes I've documented in this repo, I'm going to try to have 
# this shell script execute everything I want to install on my clean-start for desktop
# Ubuntu. 
# 
# I realize this is kind of like what Nix does. I might explore that in a future iteration. 

# Start by updating the existing packages
apt-get update -qq && apt-get upgrade -qq

# Using snap to install all the regular stuff
sudo snap install slack discord spotify vlc obs-studio gimp inkscape firefox chromium steam blue-recorder

TAN_HOME=/home/tan
set -euxo pipefail

## Install R
# unhold packages in case any packages are pinned/on-hold 
# (mostly in case I have to rerun this several times and the later hold causes problems)
apt-mark unhold r-base r-base-.
# Instructions mostly from https://cran.rstudio.com/bin/linux/ubuntu/
apt update -qq && apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
apt install --no-install-recommends r-base-dev
# pin apt versions of R stuff so that it doesn't autoupdate
apt-mark hold r-base r-base-. r-recommended

# haven't figured out automatically installing latest RStudio version yet
apt-get install -qq gdebi-core
wget -O $TAN_HOME/rstudio.deb https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.09.1-494-amd64.deb
gdebi $TAN_HOME/rstudio.deb

# Tailscale has been awesome for homelab/vpn
apt-get install -qq libcurl4 curl
curl -fsSL https://tailscale.com/install.sh | bash

# Starship
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init bash)"' >> $TAN_HOME/.bashrc
wget -O $TAN_HOME/.config/starship.toml https://github.com/tanho63/pc-setup/raw/main/starship.toml

# Install logiops for mouse stuff
sudo apt-get install -qq build-essential cmake pkg-config libevdev-dev libudev-dev libconfig++-dev libglib2.0-dev
wget -O logiops.tar.gz https://github.com/PixlOne/logiops/archive/main.tar.gz
tar -xvzf logiops.tar.gz
mkdir -p logiops-main/build
cd logiops-main/build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
make install
cd $TAN_HOME
wget -O /etc/logid.cfg https://github.com/tanho63/pc-setup/raw/main/logiops.cfg

# TODO Investigate if solaar is sufficient/better than logiops?
# Needed it for disabling hi-res mouse scrolling
add-apt-repository ppa:solaar-unifying/stable
apt update -qq
apt install -qq solaar

# disable ubuntu advertising
wget https://github.com/Skyedra/UnspamifyUbuntu/raw/master/fake-ubuntu-advantage-tools/fake-ubuntu-advantage-tools.deb
apt-get install -y fake-ubuntu-advantage-tools.deb
sudo mv /etc/apt/apt.conf.d/20apt-esm-hook.conf /etc/apt/apt.conf.d/20apt-esm-hook.conf.disabled
sudo sed -Ezi.orig \
  -e 's/(def _output_esm_service_status.outstream, have_esm_service, service_type.:\n)/\1    return\n/' \
  -e 's/(def _output_esm_package_alert.*?\n.*?\n.:\n)/\1    return\n/' \
  /usr/lib/update-notifier/apt_check.py
sudo /usr/lib/update-notifier/update-motd-updates-available --force
sudo sed -i 's/^ENABLED=.*/ENABLED=0/' /etc/default/motd-news
rm /var/lib/ubuntu-advantage/messages/motd-esm-announce
