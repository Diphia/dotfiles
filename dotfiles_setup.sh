#!/bin/bash
# diphia@2019
# This script is used to create the soft links which point to the authentic config file locations

ln -si ~/dotfiles/.vimrc ~/.vimrc
ln -si ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -si ~/dotfiles/vifmrc ~/.config/vifm/vifmrc
ln -si ~/dotfiles/ssh_config ~/.ssh/config
ln -si ~/dotfiles/.zshrc ~/.zshrc
ln -si ~/dotfiles/i3_config ~/.config/i3/config
ln -si ~/dotfiles/i3status_config ~/.config/i3status/config
