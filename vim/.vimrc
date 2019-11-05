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
"set expandtab
"set softtabstop=4

set scrolloff=10

"set shortcuts for switching between tabs
:map t1 1gt
:map t2 2gt
:map t3 3gt
:map t4 4gt
:map t5 5gt
:map t6 6gt
:map t7 7gt
:map t8 8gt
:map t9 9gt
:map th :tabp<cr>
:map tl :tabn<cr>
:map to :tabnew 

"set simple run script shortcuts
:map :py :!python % 
:map :sh :!sh % 

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
call plug#end()
