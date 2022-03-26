USER="diphia"

if [[ $OSTYPE == linux* ]]
then
    HOME=/home/$USER
elif [[ $OSTYPE == darwin* ]]
then
    HOME=/Users/$USER
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="kafeitu"


eval "$(fasd --init auto)"
plugins=(git)
plugins=(zsh-autosuggestions)

ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_TITLE="true"

source $ZSH/oh-my-zsh.sh

bindkey '^l' autosuggest-accept
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6b6b6b,bg=bold,underline"


alias vi='vim'
alias pc='proxychains4'
alias v="f -e vim"
alias grep="grep -E --color"
alias ch="cheat"
alias ssh="TERM=xterm-256color ssh"
alias e='e(){emacsclient $1&;};e'
alias hg="history | grep "
alias h="history | percol"
alias cdp="cd \$(ls|percol)"
alias vip="vi \$(ls|percol)"
alias cal="cal --monday"

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar xjvf'

export PATH="/home/diphia/.local/bin:$PATH"
export EDITOR=vim
export VISUAL=vim
#export TERM="xterm-24bit"


function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

function pclip() {
    if [[ $OSTYPE == darwin* ]]
    then
        pbcopy $@;
    else
        if [[ -x /usr/bin/xsel ]]; then
            xsel -ib $@;
        else
            if [[ -x /usr/bin/xclip ]]; then
                xclip -selection c $@;
            else
                echo "Neither xsel or xclip is installed"
            fi
        fi
    fi
}

# search the file and pop up dialog, then put the full path in clipboard
function baseff()
{
    local fullpath=$*
    local filename=${fullpath##*/} # remove "/" from the beginning
    filename=${filename##*./} # remove  ".../" from the beginning
    # Only the filename without path is needed
    # filename should be reasonable
    local cli=`find . -not -iwholename '*/vendor/*' -not -iwholename '*/bower_components/*' -not -iwholename '*/node_modules/*' -not -iwholename '*/target/*' -not -iwholename '*.svn*' -not -iwholename '*.git*' -not -iwholename '*.sass-cache*' -not -iwholename '*.hg*' -type f -path '*'${filename}'*' -print | percol`
    # convert relative path to full path
    echo $(cd $(dirname $cli); pwd)/$(basename $cli)
}

function ff()
{
    local cli=`baseff $*`
    #echo ${cli} | sed 's%^'${HOME}'%~%'
    #echo -n ${cli}  | sed 's%^'${HOME}'%~%' | pclip
    echo ${cli}
    echo -n ${cli} | pclip
}
