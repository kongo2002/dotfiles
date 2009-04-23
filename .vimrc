set makeprg=g++\ -Wall\ -o\ %<\ %

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set ignorecase
set smartcase

filetype plugin on
set grepprg=grep\ -nH\ $*

filetype indent on

map <F12> :w!<CR>:!aspell -c %<CR>:e! %<CR>
map <F3> :TlistToggle<CR>

imap ;; <Esc>

set encoding=utf-8
set fileencodings=

colorscheme slate

let tlist_AutoMod_settings='AutoMod;p:procedure;f:function;s:subroutine'
