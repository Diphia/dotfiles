#!/bin/bash
# dotfiles_setup.sh
# diphia@2019
# This script is used to create the soft links which point to the authentic config file locations

username="diphia"

ln -si ~/dotfiles/.vimrc ~/.vimrc


ln -si ~/dotfiles/.tmux.conf ~/.tmux.conf


if [ ! -d "/home/${username}/.config/vifm/" ]
then
	mkdir ~/.config/vifm/	
fi
ln -si ~/dotfiles/vifmrc ~/.config/vifm/vifmrc


if [ ! -d "/home/${username}/.ssh/" ]
then
	mkdir ~/.ssh
fi
ln -si ~/dotfiles/ssh_config ~/.ssh/config


ln -si ~/dotfiles/.zshrc ~/.zshrc


if [ ! -d "/home/${username}/.config/i3/" ]
then
	mkdir ~/.config/i3/	
fi
ln -si ~/dotfiles/i3_config ~/.config/i3/config


if [ ! -d "/home/${username}/.config/i3status/" ]
then
	mkdir ~/.config/i3status/	
fi
ln -si ~/dotfiles/i3status_config ~/.config/i3status/config


if [ ! -d "/home/${username}/.vim/autoload/" ]
then
	mkdir ~/.vim/autoload/	
fi
ln -si ~/dotfiles/plug.vim ~/.vim/autoload/plug.vim


ln -si ~/scripts/newpost.sh /usr/bin/newpost
