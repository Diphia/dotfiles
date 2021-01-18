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
if [ ! -f ${ZSHRC} ]
then
    touch ${ZSHRC}
fi
(echo "source ${DOTFILES}/.zshrc" && cat ${ZSHRC}) > ${TMP} && mv ${TMP} ${ZSHRC}

# .tmux.conf
TMUXCONF="${HOME}/.tmux.conf"
if [ ! -f ${TMUXCONF} ]
then
    touch ${TMUXCONF}
fi
(echo "source ${DOTFILES}/.tmux.conf" && cat ${TMUXCONF}) > ${TMP} && mv ${TMP} ${TMUXCONF}

# .vifm/vifmrc
VIFMRC="${HOME}/.vifm/vifmrc"
if [ ! -d ${HOME}/.vifm ]
then
    mkdir ${HOME}/.vifm
fi
if [ ! -f ${VIFMRC} ]
then
    touch ${VIFMRC}
fi
(echo "source ${DOTFILES}/vifmrc" && cat ${VIFMRC}) > ${TMP} && mv ${TMP} ${VIFMRC}

# .doom.d
ln -s ${DOTFILES}/.doom.d ${HOME}/.doom.d
