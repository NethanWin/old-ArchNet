#!/bin/bash

# Checking if is running in Repo Folder
if [[ "$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]')" =~ ^scripts$ ]]; then
    echo "You are running this in ArchNet Folder."
    echo "Please use ./archnet.sh instead"
    exit
fi

# Installing git

echo "Installing git."
pacman -Sy --noconfirm --needed git glibc

echo "Cloning the ArchNet Project"
git clone https://github.com/NethanWin/ArchNet

echo "Executing ArchNet Script"

cd $HOME/ArchNet

chmod +x archnet.sh
./archnet.sh
