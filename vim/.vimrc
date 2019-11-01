set number
syntax on

set showmode
set showcmd

filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
"set expandtab
"set softtabstop=4

set scrolloff=10

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
call plug#end()
