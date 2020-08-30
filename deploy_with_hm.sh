#!/bin/bash
# deploy.sh
# diphia@2020
# This script is used to auto install pkgs for newly deployed system

USER="diphia"

# Set PATH
if [[ ${USER} == "root" ]]
then
    HOME="/root"
else
    HOME="/home/${USER}"
fi
DOTFILES="${HOME}/dotfiles"

# Clone dotfiles and scripts
echo "cloning dotfiles..."
sudo nohup git clone https://github.com/Diphia/dotfiles.git ${HOME}/dotfiles
sudo chown -R ${USER} ${HOME}/dotfiles
sudo chgrp -R ${USER} ${HOME}/dotfiles
echo "cloning scripts..."
sudo nohup git clone https://github.com/Diphia/scripts.git ${HOME}/scripts
sudo chown -R ${USER} ${HOME}/scripts
sudo chgrp -R ${USER} ${HOME}/scripts

if [ -d "${HOME}/.emacs.d" ]
then
    rm -rf ${HOME}/.emacs.d
fi
nohup git clone https://github.com/syl20bnr/spacemacs ${HOME}/.emacs.d

if [ -f "${HOME}/.spacemacs" ]
then
    rm ${HOME}/.spacemacs
fi
ln -s ${HOME}/dotfiles/.spacemacs ${HOME}/.spacemacs
ln -s ${HOME}/dotfiles/snippets/ ${HOME}/.emacs.d/private/snippets/

tic -x -o ~/.terminfo ${HOME}/.xterm-24bit.terminfo
