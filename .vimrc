set makeprg=g++\ -Wall\ -o\ %<\ %

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set ignorecase
set smartcase

set number

filetype plugin on
set grepprg=grep\ -nH\ $*

filetype indent on

map <F3> :TlistToggle<CR>

imap ;; <Esc>

set encoding=utf-8
set fileencodings=

set fdm=marker

colorscheme jellybeans

let tlist_AutoMod_settings='AutoMod;p:procedure;f:function;s:subroutine'

let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi = 'xdvi'

au FileType python map <F6> :!python %<CR>
au FileType perl map <F6> :!perl %<CR>
au FileType html,xhtml map <F6> :!firefox %<CR>
