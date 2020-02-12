#!/bin/bash
# dotfiles_setup.sh
# diphia@2019
# This script is used to create the soft links which point to the authentic config file locations

username="diphia"
scripts_repository="https://github.com/Diphia/scripts.git"

if [ `whoami` != "root" ]
then
    echo "Permission Denied, please run as root"
    exit
fi

os=`uname -s`
if [ ${os} == "Linux" ]
then
	echo "OS:Linux"
	dotfiles_loc="/home/${username}/dotfiles"
	HOME="/home/${username}"
elif [ ${os} == "Darwin" ]
then
	echo "OS:macOS"
	dotfiles_loc="/Users/${username}/dotfiles"
	HOME="/Users/${username}"
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
z) download and link some personal scripts to ~/.local/bin
ALL) doing ALL the things above
EOF

echo -n "-> "
read input

if [[ ${input} == *a* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing Tmux config"
	ln -si ${dotfiles_loc}/.tmux.conf ${HOME}/.tmux.conf
fi  

if [[ ${input} == *b* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing vifm config"
	#ln -si ${dotfiles_loc}/vifm/ ${HOME}/.config/
	ln -si ${dotfiles_loc}/vifm/ ${HOME}/.vifm
fi  

if [[ ${input} == *c* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing ssh config"
	if [ ! -d "${HOME}/.ssh/" ]
	then
		mkdir ${HOME}/.ssh
	fi
	ln -si ${dotfiles_loc}/ssh_config ${HOME}/.ssh/config
fi

if [[ ${input} == *d* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing .zshrc"
    if [[ `grep "source ${HOME}/dotfiles/.zshrc" ${HOME}/.zshrc` ]]
    then
        echo "source command exists, abort adding"
    else
        echo "source ${HOME}/dotfiles/.zshrc" >> ${HOME}/.zshrc
        echo "source command added"
    fi
	#ln -si ${dotfiles_loc}/.zshrc ${HOME}/.zshrc
fi

if [[ ${input} == *e* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing i3wm config"
	if [ ! -d "${HOME}/.config/i3/" ]
	then
		mkdir ${HOME}/.config/i3/	
	fi
	ln -si ${dotfiles_loc}/i3_config ${HOME}/.config/i3/config
fi

if [[ ${input} == *f* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing i3status config"
	if [ ! -d "${HOME}/.config/i3status/" ]
	then
		mkdir ${HOME}/.config/i3status/	
	fi
	ln -si ${dotfiles_loc}/i3status_config ${HOME}/.config/i3status/config
fi


if [[ ${input} == *g* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing vim config"
	ln -si ${dotfiles_loc}/vim/.vimrc ${HOME}/.vimrc
	if [ ! -d "${HOME}/.vim/autoload/" ]
	then
		mkdir ${HOME}/.vim/autoload/	
	fi
	ln -si ${dotfiles_loc}/vim/plug.vim ${HOME}/.vim/autoload/plug.vim
	ln -si ${dotfiles_loc}/vim/UltiSnips ${HOME}/.vim
	ln -si ${dotfiles_loc}/vim/view ${HOME}/.vim
fi

if [[ ${input} == *h* ]] || [[ ${input} == "ALL" ]]
then
	echo "Processing proxychains"
    ln -si ${dotfiles_loc}/proxychains.conf /etc/proxychains.conf
fi


if [[ ${input} == *z* ]] || [[ ${input} == "ALL" ]]
then
    if [ ! -d "${HOME}/scripts/" ]
    then
        echo "Cloning Scripts"
        git clone ${scripts_repository} ${HOME}/scripts
    else
        echo "Directory exists, skip downloading"
    fi
	echo "Linking Scripts"
    if [ ! -d "${HOME}/.local/bin" ]
    then
        mkdir -p ${HOME}/.local/bin/
        echo "${HOME}/.local/bin created" 
    fi
    for i in `ls ${HOME}/scripts`
    do
        bin_name=`echo $i | awk -F '.' '{print $1}'`  # dip the .sh postfix
        #sudo ln -si ${HOME}/scripts/$i /usr/local/bin/${bin_name}
        sudo ln -si ${HOME}/scripts/$i ${HOME}/.local/bin/${bin_name}
        echo "processed compeleted for $i"
    done
fi

