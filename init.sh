#!/bin/bash
# init.sh
# diphia@2020
# This script is used to auto install pkgs for newly deployed system

USER = "diphia"
PKG_MANAGER = "apt install"
#PKG_MANAGER = "pacman -S"

HOME = "/home/${USER}"
DOTFILES = "${HOME}/dotfiles"

echo ${PKG_MANAGER}

# Git
echo "installing Git..."
nohup ${PKG_MANAGER} git
if [[ $? != 0 ]]
then
    echo "git installation failed"
fi

# Clone dotfiles and scripts
git clone https://github.com/Diphia/dotfiles.git ${HOME}
git clone https://github.com/Diphia/scripts.git ${HOME}

# SSH
echo "installing SSH..."
nohup ${PKG_MANAGER} openssh-server
if [[ $? != 0 ]]
then
    echo "SSH installation failed"
fi
rm -r ${HOME}/.ssh
mkdir ${HOME}/.ssh

# ZSH & oh-my-zsh
echo "installing ZSH..."
nohup ${PKG_MANAGER} zsh
if [[ $? != 0 ]]
then
    echo "ZSH installation failed"
fi
sudo chsh -s /bin/zsh
echo "installing oh-my-zsh..."
nohup git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
rm ${HOME}/.zshrc
touch ${HOME}/.zshrc
echo "source ${DOTFILES/.zshrc}" >> ${HOME}/.zshrc

# Tmux
echo "installing Tmux..."
nohup ${PKG_MANAGER} tmux
if [[ $? != 0 ]]
then
    echo "Tmux installation failed"
fi
rm ${HOME}/.tmux.conf
touch ${HOME}/.tmux.conf
echo "source ${DOTFILES}/.tmux.conf" >> ${HOME}/.tmux.conf

# Vifm
echo "installing Vifm..."
nohup ${PKG_MANAGER} vifm
if [[ $? != 0 ]]
then
    echo "Tmux installation failed"
fi
rm -r ${HOME}/.vifm
mkdir ${HOME}/.vifm
touch ${HOME}/.vifm/vifmrc
echo "source ${DOTFILES}/vifm/vifmrc" >> ${HOME}/.vifm/vifmrc

# Proxychains
echo "Installing Proxychains..."
nohup ${PKG_MANAGER} proxychains
if [[ $? != 0 ]]
then
    echo "Proxychains installation failed"
fi

# Vim
echo "Installing Vim..."
nohup ${PKG_MANAGER} vim
if [[ $? != 0 ]]
then
    echo "Vim installation failed"
fi
rm ${HOME}/.vimrc
touch ${HOME}/.vimrc
cat "source ${DOTFILES}/vim/.vimrc" >> ${HOME}/.vimrc
rm -r ${HOME}/.vim
mkdir ${HOME}/.vim
ln -s ${DOTFILES}/vim/UltiSnips ${HOME}/.vim/UltiSnips
ln -s ${DOTFILES}/vim/view ${HOME}/.vim/view

# Mosh
echo "Installing Mosh"
nohup ${PKG_MANAGER} mosh
if [[ $? != 0 ]]
then
    echo "Mosh installation failed"
fi
