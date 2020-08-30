{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

home.packages = [
  pkgs.emacs
  pkgs.zsh-autosuggestions
  pkgs.fasd
  pkgs.proxychains
  pkgs.nodejs
  pkgs.curl
  pkgs.frp
  pkgs.sqlite
  pkgs.python3
  pkgs.wget
  pkgs.tree
  pkgs.htop
  pkgs.neofetch
];

programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [ "git" ];
    oh-my-zsh.theme = "kafeitu";
    shellAliases = {
        vi = "vim";
        pc = "proxychains4";
        grep = "grep -E --color";
        ssh = "TERM=xterm-256color ssh";
    };
    initExtra = ''
        eval "$(fasd --init auto)"
        DISABLE_AUTO_TITLE="true"
        bindkey '^l' autosuggest-accept
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6b6b6b,bg=bold,underline"
        alias -s gz='tar -xzvf'
        alias -s tgz='tar -xzvf'
        alias -s zip='unzip'
        alias -s bz2='tar xjvf'
        export PATH="/home/diphia/.local/bin:$PATH"
        export TERM="xterm-24bit"
    '';
};

programs.tmux = {
  enable = true;
  baseIndex = 1;
  terminal = "xterm-24bit";
  keyMode = "vi";
  extraConfig = ''
    set-option -g status-position top
    set -g terminal-overrides ',xterm-24bit:Tc'
    set-option -g status-left \'\'
    set -g status-style "bg=#262829, fg=#ffffd7"
    set -g status-right "#[bg=#262829] %a %I:%M %p "
    set -g window-status-current-style "bg=red"
    set -g window-status-format "#I:#W"
    set -g window-status-current-format " #I*:#W "
    set -g status-right-length 100
    set -g status-interval 1
    bind h select-pane -L
    bind l select-pane -R
    bind j select-pane -D
    bind k select-pane -U
    bind -r left resize-pane -L 
    bind -r right resize-pane -R 
    bind -r down resize-pane -D 
    bind -r up resize-pane -U 
    set -g escape-time 0
    set -g repeat-time 500
    bind c new-window -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
    bind '"' split-window -c "#{pane_current_path}"
  '';
};

programs.vim = {
  enable = true;
  extraConfig = ''
    set nu
    set rnu
    set showmode
    set showcmd
    syntax on
    set ignorecase
    let mapleader = "\<space>"
    vmap <leader>y :w! /tmp/vitmp<CR>
    nmap <leader>p :r! cat /tmp/vitmp<CR>
    nnoremap <C-j> <C-d>
    nnoremap <C-k> <C-u>
    nnoremap <expr> j v:count ? 'j' : 'gj'
    nnoremap <expr> k v:count ? 'k' : 'gk'
    set scrolloff=10
  '';
};

programs.git = {
  enable = true;
  userEmail = "zqygodness@gmail.com";
  userName = "diphia";
};

home.file.".xterm-24bit.terminfo".text = ''
  xterm-24bit|xterm with 24-bit direct color mode,
    use=xterm-256color,
    sitm=\E[3m,
    ritm=\E[23m,
    setb24=\E[48;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
    setf24=\E[38;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
'';

home.file."frpc.ini".text = ''
  [common]
  server_addr = 124.70.186.17
  server_port = 7453

  [ssh]
  type = tcp
  local_ip = 127.0.0.1
  local_port = 22
  remote_port = 6005
'';

home.file."frps.ini".text = ''
  [common]
  bind_port = 7453
'';

# This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
