#! /bin/bash

# 2023-11-26: mudkip cleanstart with Ubuntu 22.04
# 
# As an upgrade on previous notes I've documented in this repo, I'm going to try to have 
# this shell script execute everything I want to install on my clean-start for desktop
# Ubuntu. 
# 
# I realize this is kind of like what Nix does. I might explore that in a future iteration. 

set -euxo pipefail
# Start by updating the existing packages
apt-get update -q && apt-get upgrade -q

# Using snap to install all the regular stuff
sudo snap install slack discord spotify vlc obs-studio gimp inkscape firefox chromium steam 

# Shamelessly installing R from rocker scripts because I can
R_HOME=/user/local/lib/R
TZ=Etc/UTC
CRAN=https://p3m.dev/cran/__linux__/jammy/latest
LANG=en_US.UTF-8
TAN_HOME=/home/tan

curl -fsSL https://github.com/rocker-org/rocker-versioned2/raw/master/scripts/install_R_source.sh | bash
curl -fsSL https://github.com/rocker-org/rocker-versioned2/raw/master/scripts/setup_R.sh | bash

sudo apt-get install gdebi
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.09.1-494-amd64.deb
gdebi rstudio-2023.09.1-494-amd64.deb

# Tailscale has been awesome for homelab/vpn
curl -fsSL https://tailscale.com/install.sh | bash

# Starship
curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init bash)"' >> $TAN_HOME/.bashrc
wget -0 $TAN_HOME/.config/starship.toml https://github.com/tanho63/pc-setup/raw/main/starship.toml

# Install logiops for mouse stuff
sudo apt-get install -q build-essential cmake pkg-config libevdev-dev libudev-dev libconfig++-dev libglib2.0-dev
wget -O logiops.tar.gz https://github.com/PixlOne/logiops/archive/main.tar.gz
tar -xvzf logiops.tar.gz
mkdir -p logiops-main/build
cd logiops-main/build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
cd TAN_HOME
wget -O /etc/logid.cfg https://github.com/tanho63/pc-setup/raw/main/logiops.cfg

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



