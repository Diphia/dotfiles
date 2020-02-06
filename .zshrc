export ZSH="/home/diphia/.oh-my-zsh"

ZSH_THEME="kafeitu"

DISABLE_AUTO_TITLE="true"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

eval "$(fasd --init auto)"

alias vi='vim'
alias pc='proxychains'
alias v="f -e vim"
alias grep="grep -E --color"
alias ch="cheat"

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar xjvf'

bindkey '^l' autosuggest-accept
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6b6b6b,bg=bold,underline"
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=bold,underline"

export PATH="/home/diphia/.local/bin:$PATH"
