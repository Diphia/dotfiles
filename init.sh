#!/usr/bin/env bash
set -euo pipefail

USER="diphia"

PKG_MGR_CMD="apt install"
#PKG_MGR_CMD="pacman -S"

# confirm of user and package manager
echo -e "
User: ${USER}
Package manager command: ${PKG_MGR_CMD}\n
"
read -r -p "Do you want to continue? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
		;;
    *)
		exit 1
		;;
esac

PACKAGE_LIST="
zsh
vim
emacs
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
echo "Packages to install: ${PACKAGE_LIST}"

# Installation with package manager
sudo ${PKG_MGR_CMD} ${PACKAGE_LIST}

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh-autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
