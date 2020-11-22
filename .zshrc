export ZSH="/Users/diphia/.oh-my-zsh"

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

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar xjvf'

export PATH="/home/diphia/.local/bin:$PATH"
#export TERM="xterm-24bit"

