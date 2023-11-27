#! /bin/bash

# 2023-11-26: mudkip cleanstart with Ubuntu 22.04
# 
# As an upgrade on previous notes I've documented in this repo, I'm going to try to have 
# this shell script execute everything I want to install on my clean-start for desktop
# Ubuntu. 
# 
# I realize this is kind of like what Nix does. I might explore that in a future iteration. 

# Start by updating the existing packages
apt-get update -q && apt-get upgrade -q

# Shamelessly installing R from rocker scripts because I can
R_HOME=/user/local/lib/R
TZ=Etc/UTC
CRAN=https://p3m.dev/cran/__linux__/jammy/latest
LANG=en_US.UTF-8
TAN_HOME=/home/tan

curl -fsSL https://github.com/rocker-org/rocker-versioned2/raw/master/scripts/install_R_source.sh | sh
curl -fsSL https://github.com/rocker-org/rocker-versioned2/raw/master/scripts/setup_R.sh | sh

# Using snap to install all the regular stuff
sudo snap install slack discord spotify obs-studio inkscape firefox chromium

# Tailscale has been awesome for homelab/vpn
curl -fsSL https://tailscale.com/install.sh | sh

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

