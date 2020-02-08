"show line numbers and relative line numbers at the same time
set nu
set rnu

syntax on

" show mode and command
set showmode
set showcmd

" set indent
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

"easy move in a wrapped line
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

set foldmethod=manual

" auto mkview and loadview
au BufWinLeave * silent mkview
au BufWinEnter * silent loadview

" UltiSnips Trigger
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" vim_plug load
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips',
Plug 'kien/ctrlp.vim'
call plug#end()

