" UI

"show line numbers and relative line numbers at the same time
set nu
set rnu

" show mode and command and syntax
set showmode
set showcmd
syntax on

" set indent
filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4


" Operations

" set case insensitive in searching
set ignorecase

" set foldmethod
set foldmethod=manual

" set scrolloff 
set scrolloff=10

"easy move in a wrapped line
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" auto mkview and loadview
au BufWinLeave * silent mkview
au BufWinEnter * silent loadview

" Keys

" Keybinding
let mapleader = "["

" UltiSnips Trigger
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

"fast switch bewteen buffers
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR> 

" toggle paste
set pastetoggle=<leader>p

" Plug

" vim_plug load
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips',
Plug 'kien/ctrlp.vim'
call plug#end()
