"show line numbers and relative line numbers at the same time
set nu
set rnu

syntax on

set showmode
set showcmd

filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

set scrolloff=10

"set shortcuts for switching between tabs
:noremap t1 1gt
:noremap t2 2gt
:noremap t3 3gt
:noremap t4 4gt
:noremap t5 5gt
:noremap t6 6gt
:noremap t7 7gt
:noremap t8 8gt
:noremap t9 9gt
:noremap th :tabp<cr>
:noremap tl :tabn<cr>
:noremap to :tabnew 

"set simple run script shortcuts
:noremap :py :!python % 
:noremap :sh :!sh % 

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
call plug#end()
