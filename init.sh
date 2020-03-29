#!/bin/bash
# init.sh
# diphia@2020
# This script is used to auto install pkgs for newly deployed system

USER="diphia"
PKG_MANAGER="apt install --assume-yes"
#PKG_MANAGER="pacman -S --noconfirm"

HOME="/home/${USER}"
DOTFILES="${HOME}/dotfiles"

echo ${PKG_MANAGER}

# Permission
sudo chmod 777 ${HOME}

# Git
echo "installing Git..."
sudo nohup ${PKG_MANAGER} git
if [[ $? != 0 ]]
then
    echo "git installation failed"
fi

# Curl
echo "installing Curl..."
sudo nohup ${PKG_MANAGER} curl
if [[ $? != 0 ]]
then
    echo "curl installation failed"
fi

#build-essential
echo "installing build-essential..."
sudo nohup ${PKG_MANAGER} build-essential
if [[ $? != 0 ]]
then
    echo "build-essential installation failed"
fi

# NodeJS, npm
echo "installing nodejs..."
sudo nohup ${PKG_MANAGER} nodejs
if [[ $? != 0 ]]
then
    echo "nodejs installation failed"
fi
echo "installing npm..."
sudo nohup ${PKG_MANAGER} npm
if [[ $? != 0 ]]
then
    echo "npm installation failed"
fi

# Clone dotfiles and scripts
echo "cloning dotfiles..."
sudo nohup git clone https://github.com/Diphia/dotfiles.git ${HOME}/dotfiles
echo "cloning scripts..."
sudo nohup git clone https://github.com/Diphia/scripts.git ${HOME}/scripts

# SSH
echo "installing SSH..."
sudo nohup ${PKG_MANAGER} openssh-server
if [[ $? != 0 ]]
then
    echo "SSH installation failed"
fi
rm -r ${HOME}/.ssh
mkdir ${HOME}/.ssh

# ZSH & oh-my-zsh
echo "installing ZSH..."
sudo nohup ${PKG_MANAGER} zsh
if [[ $? != 0 ]]
then
    echo "ZSH installation failed"
fi
sudo chsh -s /bin/zsh ${USER}
echo "installing oh-my-zsh..."
nohup git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
rm ${HOME}/.zshrc
touch ${HOME}/.zshrc
echo "source ${DOTFILES}/.zshrc" >> ${HOME}/.zshrc

# Fasd
echo "installing Fasd..."
cd ${HOME}
sudo git clone https://github.com/clvv/fasd.git
make install
if [[ $? != 0 ]]
then
    echo "Fasd installation failed"
fi


# Tmux
echo "installing Tmux..."
sudo nohup ${PKG_MANAGER} tmux
if [[ $? != 0 ]]
then
    echo "Tmux installation failed"
fi
rm ${HOME}/.tmux.conf
touch ${HOME}/.tmux.conf
echo "source ${DOTFILES}/.tmux.conf" >> ${HOME}/.tmux.conf

# Vifm
echo "installing Vifm..."
sudo nohup ${PKG_MANAGER} vifm
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
sudo nohup ${PKG_MANAGER} proxychains
if [[ $? != 0 ]]
then
    echo "Proxychains installation failed"
fi

# Vim
echo "Installing Vim..."
sudo nohup ${PKG_MANAGER} vim
if [[ $? != 0 ]]
then
    echo "Vim installation failed"
fi
rm ${HOME}/.vimrc
touch ${HOME}/.vimrc
echo "source ${DOTFILES}/vim/.vimrc" >> ${HOME}/.vimrc
rm -r ${HOME}/.vim
mkdir ${HOME}/.vim
curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ${DOTFILES}/vim/UltiSnips ${HOME}/.vim/UltiSnips
#ln -s ${DOTFILES}/vim/view ${HOME}/.vim/view

# Mosh
echo "Installing Mosh"
sudo nohup ${PKG_MANAGER} mosh
if [[ $? != 0 ]]
then
    echo "Mosh installation failed"
fi

