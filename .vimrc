set makeprg=g++\ -Wall\ -o\ %<\ %

" tabs settings
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

" ignore case in search when no uppercase search
set ignorecase
set smartcase

" highlight current cursorline
set cursorline

" display statusline even if there is only one window
set laststatus=2

" filename, flags
set statusline=%<%F\ %1*%m%*%r%h%w
"
" fileformat, fileencoding
set statusline+=\ [%{&ff}]\ %y\ [%{&enc}]
"
" line, column, percentage
set statusline+=%=%10(%l,%v%)\ %P

" folding method: markers
set fdm=marker

" display line numbers
set number

filetype plugin on
set grepprg=grep\ -nH\ $*

filetype indent on

map <F3> :TlistToggle<CR>

imap ;; <Esc>

set encoding=utf-8
set fileencodings=

colorscheme jellybeans

let tlist_AutoMod_settings='AutoMod;p:procedure;f:function;s:subroutine'

let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi = 'xdvi'

au FileType python map <F6> :!python %<CR>
au FileType perl map <F6> :!perl %<CR>
au FileType html,xhtml map <F6> :!firefox %<CR>
