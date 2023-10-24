#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

apt update
apt upgrade -y
apt install nala -y

nala fetch

username=$(id -u -n 1000)
builddir=$(pwd)

# Installing Essential Programs 
nala install make git kitty rofi picom thunar nitrogen lxpolkit x11-xserver-utils unzip wget pulseaudio pavucontrol -y


# Installing dependencies for DWM
nala install build-essential libx11-dev libxft-dev libxinerama-dev libfreetype6-dev libfontconfig1-dev

# Cloning DWM and DMENU
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu

# Building both of them
cd dwm
make clean install
cd ..
cd dmenu 
make clean install
cd ..

