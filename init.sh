#!/usr/bin/env bash
set -euo pipefail

USER="diphia"

TMP="${HOME}/.init_tmp"

# Set PATH
if [[ ${USER} == "root" ]]
then
    HOME="/root"
else
    HOME="/home/${USER}"
fi
DOTFILES="${HOME}/dotfiles"

# add code to local file

# .zshrc
ZSHRC="${HOME}/.zshrc"
if [ -f ${ZSHRC} ]
then
    rm ${ZSHRC}
fi
echo "source ${DOTFILES}/.zshrc\nsource ${HOME}/.zshrc.local" > ${ZSHRC}
#(echo "source ${DOTFILES}/.zshrc" && cat ${ZSHRC}) > ${TMP} && mv ${TMP} ${ZSHRC}
echo "Finished: ${HOME}/.zshrc"

# .tmux.conf
TMUXCONF="${HOME}/.tmux.conf"
if [ -f ${TMUXCONF} ]
then
    rm ${TMUXCONF}
fi
echo "source ${DOTFILES}/.tmux.conf\nsource ${HOME}/.tmux.conf.local" > ${TMUXCONF}
echo "Finished: ${HOME}/.tmux.conf"

# .vifm/vifmrc
VIFMRC="${HOME}/.vifm/vifmrc"
if [ ! -d ${HOME}/.vifm ]
then
    mkdir ${HOME}/.vifm
fi
if [ -f ${VIFMRC} ]
then
    rm ${VIFMRC}
fi
echo "source ${DOTFILES}/vifmrc\nsource ${HOME}/.vifm/vifmrc.local" > ${VIFMRC}
echo "Finished: ${HOME}/.vifm/vifmrc"

# .doom.d
ln -s ${DOTFILES}/.doom.d ${HOME}/.doom.d
echo "Finished: ${HOME}/.doom.d"
