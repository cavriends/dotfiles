#!/bin/bash

# Change the sources list (add bullseye-backports)
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list

username=$(id -u -n 1000)
builddir=$(pwd)

apt update

# Install relevant packages (i.e. window manager, display manager, networking and applets)
apt install wget unzip picom i3 polybar sddm rofi kitty neofetch git lxappearance brightnessctl feh fonts-awesome ttf-mscorefonts-installer
apt install nm-applet blueman pasystray pavucontrol network-manager xfce4-notifyd flatpak arandr -y

# Replace PipeWire stable version with testing
apt install pipewire/bullseye-backports -y
apt install libspa-0.2-bluetooth/bullseye-backports -y
apt remove pulseaudio-module-bluetooth -y

# Replace PulseAudi with PipeWire / WirePlumber
touch /etc/pipewire/media-session.d/with-pulseaudio
cp /usr/share/doc/pipewire/examples/systemd/user/pipewire-pulse.* /etc/systemd/user/

mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home$username/Pictures
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/.themes
mkdir -p /home/$username/.i3
mkdir -p /home/$username/.themes/zsh

# Copy configs and set backgrounds
git clone https://github.com/cavriends/dotfiles
cp -R dotfiles/xps-13-9370-debian/.config/* /home/$username/.config/
cp -R dotfiles/xps-13-9370-debian/.fonts/* /home/$username/.fonts/
cp dotfiles/xps-13-9370-debian/background.jpg /home/$username/Pictures /usr/share/sddm/themes/sddm-sugar-candy/Backgrounds
cp dotfiles/xps-13-9370-debian/sddm.conf /etc/sddm.conf

# Install i3lock-multimonitor
apt install scrot imagemagick i3lock
git clone git@github.com:ShikherVerma/i3lock-multimonitor.git /home/$username/.i3/

chown -R $username:$username /home/$username

# Set SDDM theme
apt install --no-install-recommends sddm qml-module-qtquick-layouts qml-module-qtgraphicaleffects qml-module-qtquick-controls2 libqt5svg5
mkdir -p /usr/share/sddm/themes
git clone https://github.com/Kangie/sddm-sugar-candy /usr/share/sddm/themes/
