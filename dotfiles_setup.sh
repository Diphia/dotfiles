#!/bin/bash
# dotfiles_setup.sh
# diphia@2019
# This script is used to create the soft links which point to the authentic config file locations

username="diphia"



ln -si /home/${username}/dotfiles/.tmux.conf /home/${username}/.tmux.conf

ln -si /home/${username}/dotfiles/vifm/ /home/${username}/.config/vifm


if [ ! -d "/home/${username}/.ssh/" ]
then
	mkdir /home/${username}/.ssh
fi
ln -si /home/${username}/dotfiles/ssh_config /home/${username}/.ssh/config


ln -si /home/${username}/dotfiles/.zshrc /home/${username}/.zshrc


if [ ! -d "/home/${username}/.config/i3/" ]
then
	mkdir /home/${username}/.config/i3/	
fi
ln -si /home/${username}/dotfiles/i3_config /home/${username}/.config/i3/config


if [ ! -d "/home/${username}/.config/i3status/" ]
then
	mkdir /home/${username}/.config/i3status/	
fi
ln -si /home/${username}/dotfiles/i3status_config /home/${username}/.config/i3status/config


ln -si /home/${username}/dotfiles/vim/.vimrc /home/${username}/.vimrc
if [ ! -d "/home/${username}/.vim/autoload/" ]
then
	mkdir /home/${username}/.vim/autoload/	
fi
ln -si /home/${username}/dotfiles/vim/plug.vim /home/${username}/.vim/autoload/plug.vim
ln -si /home/${username}/dotfiles/vim/UltiSnips /home/${username}/.vim/UltiSnips


ln -si /home/${username}/scripts/newpost.sh /usr/bin/newpost
ln -si /home/${username}/scripts/nc_receive.sh /usr/bin/nc_receive
