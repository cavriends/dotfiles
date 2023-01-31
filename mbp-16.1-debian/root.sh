#!/bin/bash

# Change the sources list (add bullseye-backports)
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list

username=$(id -u -n 1000)

apt update -y

# Install relevant packages (i.e. window manager, display manager, networking and applets)
apt install -y wget curl unzip picom i3 polybar sddm rofi kitty neofetch git lxappearance brightnessctl feh fonts-font-awesome ttf-mscorefonts-installer
apt install -y nm-applet blueman pasystray pavucontrol network-manager flatpak arandr redshift redshift-gtk firefox-esr

# Install latest t2-kernel
curl -s --compressed "https://adityagarg8.github.io/t2-ubuntu-repo/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/t2-ubuntu-repo.gpg >/dev/null
curl -s --compressed -o /etc/apt/sources.list.d/t2.list "https://adityagarg8.github.io/t2-ubuntu-repo/t2.list"
apt install t2-kernel-script-debian
update_t2_kernel
apt install apple-t2-audio-config

# Install some build essentials
apt install build-essential libncurses-dev libssl-dev flex bison libelf-dev bc dwarves openssl make cc

# Config userdir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home$username/Pictures
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/.themes/zsh
mkdir -p /home/$username/.i3

# Copy configs and set backgrounds
cp -R dotfiles/mbp-16.1-debian/.config/* /home/$username/.config/
cp -R dotfiles/mbp-16.1-debian/.fonts/* /home/$username/.fonts/
cp dotfiles/mbp-16.1-debian/background.jpg /home/$username/Pictures /usr/share/sddm/themes/sddm-sugar-candy/Backgrounds
cp dotfiles/mbp-16.1-debian/sddm.conf /etc/sddm.conf

# Set permissions
chown -R $username:$username /home/$username
