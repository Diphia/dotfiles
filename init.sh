#!/bin/bash
# init.sh
# diphia@2020
# This script is used to auto install pkgs for newly deployed system

USER="diphia"
PKG_MANAGER="apt"
#PKG_MANAGER="pacman"

if [[ ${PKG_MANAGER} == "apt" ]]
then
    PKG_MANAGER_CMD="apt install --assume-yes"
elif [[ ${PKG_MANAGER} == "pacman" ]]
then
    PKG_MANAGER_CMD="pacman -S --noconfirm"
fi

# Set PATH
if [[ ${USER} == "root" ]]
then
    HOME="/root"
else
    HOME="/home/${USER}"
fi
DOTFILES="${HOME}/dotfiles"

echo ${PKG_MANAGER_CMD}

# Permission
sudo chmod 777 ${HOME}

# Python
echo "installing Python..."
sudo nohup ${PKG_MANAGER_CMD} python3
if [[ $? != 0 ]]
then
    echo "python installation failed"
fi

# Git
echo "installing Git..."
sudo nohup ${PKG_MANAGER_CMD} git
if [[ $? != 0 ]]
then
    echo "git installation failed"
fi

# Curl
echo "installing Curl..."
sudo nohup ${PKG_MANAGER_CMD} curl
if [[ $? != 0 ]]
then
    echo "curl installation failed"
fi

#build-essential or make
if [[ ${PKG_MANAGER} == "apt" ]]
then
    echo "installing build-essential..."
    sudo nohup ${PKG_MANAGER_CMD} build-essential
    if [[ $? != 0 ]]
    then
        echo "build-essential installation failed"
    fi
elif [[ ${PKG_MANAGER} == "pacman" ]]
then
    echo "installing make..."
    sudo nohup ${PKG_MANAGER_CMD} make
    if [[ $? != 0 ]]
    then
        echo "make installation failed"
    fi
fi

# NodeJS, npm
echo "installing nodejs..."
sudo nohup ${PKG_MANAGER_CMD} nodejs
if [[ $? != 0 ]]
then
    echo "nodejs installation failed"
fi
echo "installing npm..."
sudo nohup ${PKG_MANAGER_CMD} npm
if [[ $? != 0 ]]
then
    echo "npm installation failed"
fi

# Clone dotfiles and scripts
echo "cloning dotfiles..."
sudo nohup git clone https://github.com/Diphia/dotfiles.git ${HOME}/dotfiles
sudo chown -R ${USER} ${HOME}/dotfiles
sudo chgrp -R ${USER} ${HOME}/dotfiles
echo "cloning scripts..."
sudo nohup git clone https://github.com/Diphia/scripts.git ${HOME}/scripts
sudo chown -R ${USER} ${HOME}/scripts
sudo chgrp -R ${USER} ${HOME}/scripts

# SSH
echo "installing SSH..."
sudo nohup ${PKG_MANAGER_CMD} openssh-server
if [[ $? != 0 ]]
then
    echo "SSH installation failed"
fi
if [ -d "${HOME}/.ssh" ]
then
    rm -r ${HOME}/.ssh
fi
mkdir ${HOME}/.ssh

# ZSH & oh-my-zsh
echo "installing ZSH..."
sudo nohup ${PKG_MANAGER_CMD} zsh
if [[ $? != 0 ]]
then
    echo "ZSH installation failed"
fi
sudo chsh -s /bin/zsh ${USER}
echo "installing oh-my-zsh..."
sudo nohup git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
sudo chown -R ${USER} ${HOME}/.oh-my-zsh
sudo chgrp -R ${USER} ${HOME}/.oh-my-zsh
if [ -f "${HOME}/.zshrc" ]
then
    rm ${HOME}/.zshrc
fi
touch ${HOME}/.zshrc
echo "source ${DOTFILES}/.zshrc" >> ${HOME}/.zshrc

# Fasd
echo "installing Fasd..."
cd ${HOME}
sudo git clone https://github.com/clvv/fasd.git
sudo chown -R ${USER} ${HOME}/fasd
sudo chgrp -R ${USER} ${HOME}/fasd
cd ${HOME}/fasd
sudo make install
if [[ $? != 0 ]]
then
    echo "Fasd installation failed"
fi

# zsh-autosuggestions
echo "installing zsh-autosuggestions..."
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
sudo chown -R ${USER} ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
sudo chgrp -R ${USER} ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
if [[ $? != 0 ]]
then
    echo "zsh-autosuggestions installation failed"
fi

# Tmux
echo "installing Tmux..."
sudo nohup ${PKG_MANAGER_CMD} tmux
if [[ $? != 0 ]]
then
    echo "Tmux installation failed"
fi
if [ -f "${HOME}/.tmux.conf" ]
then
    rm ${HOME}/.tmux.conf
fi
touch ${HOME}/.tmux.conf
echo "source ${DOTFILES}/.tmux.conf" >> ${HOME}/.tmux.conf

# Vifm
echo "installing Vifm..."
sudo nohup ${PKG_MANAGER_CMD} vifm
if [[ $? != 0 ]]
then
    echo "Vifm installation failed"
fi
if [ -d "${HOME}/.vifm" ]
then
    rm -r ${HOME}/.vifm
fi
mkdir ${HOME}/.vifm
touch ${HOME}/.vifm/vifmrc
echo "source ${DOTFILES}/vifm/vifmrc" >> ${HOME}/.vifm/vifmrc

# Proxychains
echo "Installing Proxychains..."
sudo nohup ${PKG_MANAGER_CMD} proxychains
if [[ $? != 0 ]]
then
    echo "Proxychains installation failed"
fi

# Vim
echo "Installing Vim..."
sudo nohup ${PKG_MANAGER_CMD} vim
if [[ $? != 0 ]]
then
    echo "Vim installation failed"
fi
#if [ -f "${HOME}/.vimrc" ]
#then
    #rm ${HOME}/.vimrc
#fi
#touch ${HOME}/.vimrc
#echo "source ${DOTFILES}/vim/.vimrc" >> ${HOME}/.vimrc
#if [ -d "${HOME}/.vim" ]
#then
    #rm -r ${HOME}/.vim
#fi
#mkdir ${HOME}/.vim
#curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#ln -s ${DOTFILES}/vim/UltiSnips ${HOME}/.vim/UltiSnips
#echo "Installing coc-ultisnips"
#npm i coc-ultisnips
#ln -s ${DOTFILES}/vim/view ${HOME}/.vim/view

# Mosh
echo "Installing Mosh"
sudo nohup ${PKG_MANAGER_CMD} mosh
if [[ $? != 0 ]]
then
    echo "Mosh installation failed"
fi

# Emacs
echo "Installing Emacs"
sudo nohup ${PKG_MANAGER_CMD} emacs
if [[ $? != 0 ]]
then
    echo "Emacs installation failed"
fi
if [ -d "${HOME}/.spacemacs.d" ]
then
    rm -r ${HOME}/.spacemacs.d
fi
mkdir ${HOME}/.spacemacs.d
ln -s ${HOME}/dotfiles/init.el ${HOME}/.spacemacs.d/init.el


# Emacs
#echo "Installing Emacs"
#sudo nohup ${PKG_MANAGER_CMD} emacs
#if [[ $? != 0 ]]
#then
    #echo "emacs installation failed"
#fi
#mkdir ${HOME}/.emacs.d
#touch ${HOME}/.emacs.d/init.el
#cat ${DOTFILES}/init.el >> ${HOME}/.emacs.d/init.el

