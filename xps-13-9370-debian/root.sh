#!/bin/bash

# Change the sources list (add bullseye-backports)
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list

username=$(id -u -n 1000)

apt update -y

# Install relevant packages (i.e. window manager, display manager, networking and applets)
apt install -y wget unzip picom i3 polybar sddm rofi kitty neofetch git lxappearance brightnessctl feh fonts-font-awesome ttf-mscorefonts-installer
apt install -y nm-applet blueman pasystray pavucontrol network-manager xfce4-notifyd flatpak arandr

# Replace PipeWire stable version with testing
apt install -y pipewire/bullseye-backports
apt install -y libspa-0.2-bluetooth/bullseye-backports
apt remove -y pulseaudio-module-bluetooth

# Replace PulseAudio with PipeWire / WirePlumber
touch /etc/pipewire/media-session.d/with-pulseaudio
cp /usr/share/doc/pipewire/examples/systemd/user/pipewire-pulse.* /etc/systemd/user/

# Create folder for themes
mkdir -p /usr/share/sddm/themes

# Set SDDM theme
apt install -y --no-install-recommends sddm qml-module-qtquick-layouts qml-module-qtgraphicaleffects qml-module-qtquick-controls2 libqt5svg5
git clone https://github.com/Kangie/sddm-sugar-candy /usr/share/sddm/themes/

# Config userdir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home$username/Pictures
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/.themes/zsh
mkdir -p /home/$username/.i3

# Install Nordic theme for lxappearance
git clone git@github.com:EliverLara/Nordic.git /home/$username/.themes/

# Copy configs and set backgrounds
git clone https://github.com/cavriends/dotfiles
cp -r dotfiles/xps-13-9370-debian/.config/. /home/$username/.config/
cp -r dotfiles/xps-13-9370-debian/.fonts/. /home/$username/.fonts/
cp dotfiles/xps-13-9370-debian/background.jpg /home/$username/Pictures /usr/share/sddm/themes/sddm-sugar-candy/Backgrounds
cp dotfiles/xps-13-9370-debian/sddm.conf /etc/sddm.conf

# Install i3lock-multimonitor
apt install scrot imagemagick i3lock
git clone git@github.com:ShikherVerma/i3lock-multimonitor.git /home/$username/.i3

# Set permissions
chown -R $username:$username /home/$username
