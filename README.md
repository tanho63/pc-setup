# Windows 10 PC Setup

Documenting a from-scratch installation and configuration of Windows 10 for a data scientist/developer primarily using R, SQL, and day-to-day computing. 

## Hardware

A home-built PC with this [parts list](https://ca.pcpartpicker.com/list/ZNdTt8).

## Windows 10 Installation

Create a Windows 10 USB stick via [this Microsoft tool](https://support.microsoft.com/en-us/windows/create-installation-media-for-windows-99a58364-8c02-206f-aa6f-40c3b507420d). 

Boot the USB installation media, format the drive (I'm using the NVME drive) and run through the installation. 

## Windows 10 Setup and Updates

Set up local account, skipping through all the dialogues (choosing not to send Microsoft your data, not using Cortana, not using location services etc). 

Open Windows Update and download/install updates. Reboot.

## Install/update hardware drivers

A new install means you need to update a bunch of drivers for the various hardware components so that my PC is running optimally. 

The CPU/GPU in my case are AMD Ryzen 3600X and AMD Radeon 5600XT - that means installing the latest from [AMD](https://www.amd.com/en/support). 

I'm also going to install the driver for the bluetooth/wifi card (TP-Link Archer TX3000E)

## Install Chocolatey and Firefox

Chocolatey is a package manager that helps install software and packages from the command line, so that you're not navigating through boxes. 
