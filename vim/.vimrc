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


" Behaviour

" set case insensitive in searching
set ignorecase

" set foldmethod
set foldmethod=manual

" set scrolloff 
set scrolloff=10

" auto mkview and loadview
au BufWinLeave * silent mkview
au BufWinEnter * silent loadview

" Keys

" Leader Key
let mapleader = "\<space>"

" UltiSnips Trigger
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

" Yank and Paste (Corss-instaces)
vmap <leader>y :w! /tmp/vitmp<CR>                                                                   
nmap <leader>p :r! cat /tmp/vitmp<CR>

" Tabs
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Page Up and Page Down (Half)
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" LeaderF Keymap
let g:Lf_ShortcutF = '<C-P>'
nnoremap <leader>t :LeaderfBufTag<CR>
let g:Lf_CommandMap = {'<C-K>': ['<C-P>'], '<C-J>': ['<C-N>']}

"easy move in a wrapped line
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Plug

" vim_plug load
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips',
Plug 'Yggdroot/LeaderF',{'do':'.\install.bat'}
call plug#end()

