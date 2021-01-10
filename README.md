# Windows 10 PC Setup

Documenting a from-scratch installation and configuration of Windows 10 for a data scientist/developer primarily using R, SQL, and day-to-day computing. 

## Hardware

A home-built PC with this [parts list](https://ca.pcpartpicker.com/list/ZNdTt8).

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

![](blob:https://imgur.com/002c993e-b892-4a6c-96be-8351a798b743)

Clicking the gesture button is play/pause, gesture left/right is volume down/up, and gesture up/down is maximize/switch windows. 

![](https://i.imgur.com/i2mwciv.png)

I abandoned left and right scroll in favour of mapping the ctrl-c and ctrl-v shortcuts to it - this lets me copy-paste a selection without moving my hand off the mouse!


## Install Chocolatey

Chocolatey is a package manager that helps install software and packages from the command line, so that you're not navigating through boxes. 

I press Start, type powershell, right click to run it as administrator, and then copy-paste this line from chocolatey's install page into the terminal prompt

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

While that's installing, I get busy getting rid of Microsoft Clutter (TM) from my machine - uninstalling every possible tile from the start menu, getting rid of cortana and search bars from my taskbar. If I need to search, I can press start and then just type whatever I'm searching for on my PC. If I need web search, I pull up a browser and search there. 

## Install STUFF

Chocolatey is pretty awesome and will let me install a whole whack of programs and packages on my machine with just a terminal command. 

```
choco install -y firefox slack discord spotify vlc inkscape sharex gimp libreoffice 7zip.install git.install r rtools python3 jdk8 jre8 adobeair dotnetfx putty malwarebytes vscode foxitreader
```

