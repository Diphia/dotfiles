#!/usr/bin/env bash
set -euo pipefail

USER="diphia"

# Set PATH
if [[ $OSTYPE == linux* ]]
then
    HOME=/home/$USER
elif [[ $OSTYPE == darwin* ]]
then
    HOME=/Users/$USER
fi
DOTFILES="${HOME}/dotfiles"

TMP="${HOME}/.init_tmp"

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

# .vimrc
VIMRC="${HOME}/.vimrc"
VIMRC_LOCAL="${HOME}/.vimrc.local"
if [ -f ${VIMRC} ]
then
    rm ${VIMRC}
fi
if [ ! -f ${VIMRC_LOCAL} ]
then
    touch ${VIMRC_LOCAL}
fi
echo -e "source ${DOTFILES}/.vimrc\nsource ${VIMRC_LOCAL}" > ${VIMRC}
echo "Finished: ${HOME}/.vimrc"

# .percol.d/rc.py
PERCOLRC="${HOME}/.percol.d/rc.py"
if [ ! -d ${HOME}/.percol.d ]
then
    mkdir ${HOME}/.percol.d
fi
if [ -f ${PERCOLRC} ]
then
    rm ${PERCOLRC}
fi
ln -s ${HOME}/dotfiles/rc.py ${PERCOLRC}
echo "Finished: ${HOME}/percol.d/rc.py"
