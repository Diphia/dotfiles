if [[ $OSTYPE == linux* ]]
then
    HOME=/home/$USER
elif [[ $OSTYPE == darwin* ]]
then
    HOME=/Users/$USER
fi

alias vi='vim'
alias pc='proxychains4'
alias v="f -e vim"
alias grep="grep -E --color"
alias ssh="TERM=xterm-256color ssh"
alias e='e(){emacsclient $1&;};e'
alias hg="history | grep "
alias h="history | percol"
alias cdp="cd \$(ls|percol)"
alias vip="vi \$(ls|percol)"
alias cal="cal --monday"
alias k="kubectl"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gd="git diff"

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar xjvf'

export PATH="/home/diphia/.local/bin:$PATH"
export EDITOR=vim
export VISUAL=vim
