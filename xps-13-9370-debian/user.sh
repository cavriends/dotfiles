#!/bin/bash

# Set PipeWire as default (instructions per https://wiki.debian.org/PipeWire#For_PulseAudio)
systemctl --user daemon-reload
systemctl --user --now disable pulseaudio.service pulseaudio.socket
systemctl --user --now enable pipewire pipewire-pulse

# Ensure PipeWire continues after reboot
systemctl --user mask pulseaudio

# Configure oh-my-zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.themes/zsh/powerlevel10k
echo 'source ~/.themes/zsh/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc