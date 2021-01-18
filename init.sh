#!/usr/bin/env bash
set -euo pipefail

USER="diphia"

PKG_MANAGER="apt"
#PKG_MANAGER="pacman"

PACKAGE_LIST="
zsh
tmux
vifm
fasd
"

# Set PATH
if [[ ${USER} == "root" ]]
then
    HOME="/root"
else
    HOME="/home/${USER}"
fi
DOTFILES="${HOME}/dotfiles"
echo ${PACKAGE_LIST}

# Installation with package manager
sudo apt install ${PACKAGE_LIST}

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh-autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
