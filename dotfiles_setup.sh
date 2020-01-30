#!/bin/bash
# dotfiles_setup.sh
# diphia@2019
# This script is used to create the soft links which point to the authentic config file locations

username="diphia"

os=`uname -s`
if [ ${os} == "Linux" ]
then
	echo "OS:Linux"
	dotfiles_loc="/home/${username}/dotfiles"
	user_main_dir="/home/${username}"
elif [ ${os} == "Darwin" ]
then
	echo "OS:macOS"
	dotfiles_loc="/Users/${username}/dotfiles"
	user_main_dir="/Users/${username}"
fi

cat << EOF
Please select dotfiles you want to sync:
a) .tmux.config
b) vifm
c) .ssh/config
d) .zshrc
e) i3wm
f) i3status
g) vim
h) proxychains
z) download and link some personal scripts to /usr/bin
ALL) doing ALL the things above
EOF

echo -n "-> "
read input

if [[ ${input} == *a* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing Tmux config"
	ln -si ${dotfiles_loc}/.tmux.conf ${user_main_dir}/.tmux.conf
fi  

if [[ ${input} == *b* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing vifm config"
	ln -si ${dotfiles_loc}/vifm/ ${user_main_dir}/.config/
fi  

if [[ ${input} == *c* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing ssh config"
	if [ ! -d "${user_main_dir}/.ssh/" ]
	then
		mkdir ${user_main_dir}/.ssh
	fi
	ln -si ${dotfiles_loc}/ssh_config ${user_main_dir}/.ssh/config
fi

if [[ ${input} == *d* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing .zshrc"
	ln -si ${dotfiles_loc}/.zshrc ${user_main_dir}/.zshrc
fi

if [[ ${input} == *e* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing i3wm config"
	if [ ! -d "${user_main_dir}/.config/i3/" ]
	then
		mkdir ${user_main_dir}/.config/i3/	
	fi
	ln -si ${dotfiles_loc}/i3_config ${user_main_dir}/.config/i3/config
fi


if [[ ${input} == *f* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing i3status config"
	if [ ! -d "${user_main_dir}/.config/i3status/" ]
	then
		mkdir ${user_main_dir}/.config/i3status/	
	fi
	ln -si ${dotfiles_loc}/i3status_config ${user_main_dir}/.config/i3status/config
fi


if [[ ${input} == *g* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing vim config"
	ln -si ${dotfiles_loc}/vim/.vimrc ${user_main_dir}/.vimrc
	if [ ! -d "${user_main_dir}/.vim/autoload/" ]
	then
		mkdir ${user_main_dir}/.vim/autoload/	
	fi
	ln -si ${dotfiles_loc}/vim/plug.vim ${user_main_dir}/.vim/autoload/plug.vim
	ln -si ${dotfiles_loc}/vim/UltiSnips ${user_main_dir}/.vim
fi

if [[ ${input} == *h* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing proxychains"
    ln -si ${dotfiles_loc}/proxychains.conf /etc/proxychains.conf
fi


if [[ ${input} == *z* ]] || [[ ${input} == "ALL" ]]
then
	echo "Cloning Scripts"
    git clone ${user_main_dir}/scripts
	echo "Linking Scripts"
	ln -si ${user_main_dir}/scripts/newpost.sh /usr/bin/newpost
	ln -si ${user_main_dir}/scripts/nc_receive.sh /usr/bin/nc_receive
	ln -si ${user_main_dir}/scripts/push_blog_to_server.sh /usr/bin/push_blog_to_server
fi
