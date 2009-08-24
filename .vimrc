set makeprg=g++\ -Wall\ -o\ %<\ %
set grepprg=grep\ -nH\ $*

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
" fileformat, encoding
set statusline+=\ [%{&ff}]\ %y\ [%{(&fenc==\"\"?&enc:&fenc)}]
"
" line, column, percentage
set statusline+=%=%10(%l,%v%)\ %P

" folding method: markers
set fdm=marker

" display line numbers
set number

" switch buffers without saving
set hidden

" number of screen lines around cursor
set scrolloff=5

" toggle taglist plugin
map <F3> :TlistToggle<CR>

" bind escape key
imap ;; <Esc>

" hide search highlight
map # :noh<CR>

" change window
map + <C-w>w

" window movement
map <C-j> <C-w>+
map <C-k> <C-w>-
map <C-h> <C-w><
map <C-l> <C-w>>

" search and replace
map <F4> :%s///gc<Left><Left><Left><Left>

filetype plugin on
filetype indent on

set encoding=utf-8

colorscheme jellybeans

let tlist_AutoMod_settings='AutoMod;p:procedure;f:function;s:subroutine'

let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi = 'evince'

au FileType python map <F6> :!python %<CR>
au FileType perl map <F6> :!perl %<CR>
au FileType html,xhtml map <F6> :!firefox %<CR>
au FileType tex map <F6> :w<CR>\ll\lv
