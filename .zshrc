if [[ $OSTYPE == linux* ]]
then
    HOME=/home/$USER
elif [[ $OSTYPE == darwin* ]]
then
    HOME=/Users/$USER
fi

ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_TITLE="true"

alias vi='vim'
alias pc='proxychains4'
alias grep="grep -E --color"
alias ssh="TERM=xterm-256color ssh"
alias e='e(){emacsclient -t $1;};e'
alias hg="history | grep "
alias h="history | percol"
alias cdp="cd \$(ls|percol)"
alias vip="vi \$(ls|percol)"
alias k="kubectl"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gd="git diff"
alias gp="git push"

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar xjvf'

export PATH="$HOME/.local/bin:$PATH"
export EDITOR=vim
export VISUAL=vim

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Configure zsh-autosuggestions to use right arrow key to accept suggestion
bindkey '^[[C' forward-char  # Right arrow key accepts suggestion

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%F{cyan}%1~%f%F{red}${vcs_info_msg_0_}%f %F{green}$%f '

eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh