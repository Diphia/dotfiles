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
ZSHRC_LOCAL="${HOME}/.zshrc.local"
if [ -f ${ZSHRC} ]
then
    rm ${ZSHRC}
fi
if [ ! -f ${ZSHRC_LOCAL} ]
then
    touch ${ZSHRC_LOCAL}
fi
echo -e "source ${DOTFILES}/.zshrc\nsource ${ZSHRC_LOCAL}" > ${ZSHRC}
#(echo "source ${DOTFILES}/.zshrc" && cat ${ZSHRC}) > ${TMP} && mv ${TMP} ${ZSHRC}
echo "Finished: ${HOME}/.zshrc"

# .tmux.conf
TMUXCONF="${HOME}/.tmux.conf"
TMUXCONF_LOCAL="${HOME}/.tmux.conf.local"
if [ -f ${TMUXCONF} ]
then
    rm ${TMUXCONF}
fi
if [ ! -f ${TMUXCONF_LOCAL} ]
then
    touch ${TMUXCONF_LOCAL}
fi
echo -e "source ${DOTFILES}/.tmux.conf\nsource ${TMUXCONF_LOCAL}" > ${TMUXCONF}
echo "Finished: ${HOME}/.tmux.conf"

# .vifm/vifmrc
VIFMRC="${HOME}/.vifm/vifmrc"
VIFMRC_LOCAL="${HOME}/.vifm/vifmrc.local"
if [ ! -d ${HOME}/.vifm ]
then
    mkdir ${HOME}/.vifm
fi
if [ -f ${VIFMRC} ]
then
    rm ${VIFMRC}
fi
if [ ! -f ${VIFMRC_LOCAL} ]
then
    touch ${VIFMRC_LOCAL}
fi
echo -e "source ${DOTFILES}/vifmrc\nsource ${VIFMRC_LOCAL}" > ${VIFMRC}
echo "Finished: ${HOME}/.vifm/vifmrc"

