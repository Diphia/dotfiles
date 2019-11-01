#!/bin/bash
# dotfiles_setup.sh
# diphia@2019
# This script is used to create the soft links which point to the authentic config file locations

username="diphia"


dotfiles_loc="/home/${username}/dotfiles"
user_main_dir="/home/${username}"



ln -si ${dotfiles_loc}/.tmux.conf ${user_main_dir}/.tmux.conf

ln -si ${dotfiles_loc}/vifm/ ${user_main_dir}/.config/vifm


if [ ! -d "${user_main_dir}/.ssh/" ]
then
	mkdir ${user_main_dir}/.ssh
fi
ln -si ${dotfiles_loc}/ssh_config ${user_main_dir}/.ssh/config


ln -si ${dotfiles_loc}/.zshrc ${user_main_dir}/.zshrc


if [ ! -d "${user_main_dir}/.config/i3/" ]
then
	mkdir ${user_main_dir}/.config/i3/	
fi
ln -si ${dotfiles_loc}/i3_config ${user_main_dir}/.config/i3/config


if [ ! -d "${user_main_dir}/.config/i3status/" ]
then
	mkdir ${user_main_dir}/.config/i3status/	
fi
ln -si ${dotfiles_loc}/i3status_config ${user_main_dir}/.config/i3status/config


ln -si ${dotfiles_loc}/vim/.vimrc ${user_main_dir}/.vimrc
if [ ! -d "${user_main_dir}/.vim/autoload/" ]
then
	mkdir ${user_main_dir}/.vim/autoload/	
fi
ln -si ${dotfiles_loc}/vim/plug.vim ${user_main_dir}/.vim/autoload/plug.vim
ln -si ${dotfiles_loc}/vim/UltiSnips ${user_main_dir}/.vim/UltiSnips


ln -si ${user_main_dir}/scripts/newpost.sh /usr/bin/newpost
ln -si ${user_main_dir}/scripts/nc_receive.sh /usr/bin/nc_receive
ln -si ${user_main_dir}/scripts/push_blog_to_server.sh /usr/bin/push_blog_to_server
