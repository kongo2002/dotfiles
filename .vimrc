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

colorscheme slate

let tlist_AutoMod_settings='AutoMod;p:procedure;f:function;s:subroutine'

let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi = 'xdvi'
