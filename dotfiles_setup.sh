#!/bin/bash
# dotfiles_setup.sh
# diphia@2019
# This script is used to create the soft links which point to the authentic config file locations

username="diphia"

ln -si /home/${username}/dotfiles/.vimrc /home/${username}/.vimrc


ln -si /home/${username}/dotfiles/.tmux.conf /home/${username}/.tmux.conf


if [ ! -d "/home/${username}/.config/vifm/" ]
then
	mkdir /home/${username}/.config/vifm/	
fi
ln -si /home/${username}/dotfiles/vifmrc /home/${username}/.config/vifm/vifmrc


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


if [ ! -d "/home/${username}/.vim/autoload/" ]
then
	mkdir /home/${username}/.vim/autoload/	
fi
ln -si /home/${username}/dotfiles/plug.vim /home/${username}/.vim/autoload/plug.vim


ln -si /home/${username}/scripts/newpost.sh /usr/bin/newpost
ln -si /home/${username}/scripts/nc_receive.sh /usr/bin/nc_receive
