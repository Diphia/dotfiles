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

echo "installing oh-my-zsh..."
#sudo nohup git clone git://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
#sudo chown -R ${USER} ${HOME}/.oh-my-zsh
#sudo chgrp -R ${USER} ${HOME}/.oh-my-zsh
if [ -f "${HOME}/.zshrc" ]
then
    rm ${HOME}/.zshrc
fi
touch ${HOME}/.zshrc
echo "source ${DOTFILES}/.zshrc" >> ${HOME}/.zshrc

if [ -f "${HOME}/.tmux.conf" ]
then
    rm ${HOME}/.tmux.conf
fi
touch ${HOME}/.tmux.conf
echo "source ${DOTFILES}/.tmux.conf" >> ${HOME}/.tmux.conf

if [ -f "${HOME}/.vimrc" ]
then
    rm ${HOME}/.vimrc
fi
touch ${HOME}/.vimrc
echo "source ${DOTFILES}/vim/.vimrc" >> ${HOME}/.vimrc

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

tic -x -o ~/.terminfo ${DOTFILES}/.xterm-24bit.terminfo

# frp
#ln -s ${HOME}/dotfiles/frps.ini ${HOME}/frps.ini
#ln -s ${HOME}/dotfiles/frpc.ini ${HOME}/frpc.ini
