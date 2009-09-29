set makeprg=g++\ -Wall\ -o\ %<\ %
set grepprg=grep\ -nH\ $*

" tabs settings
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

" ignore case in search when no uppercase search
set incsearch
set ignorecase
set smartcase

" highlight current cursorline
set cursorline

" display statusline even if there is only one window
set laststatus=2

" filename, flags
set statusline=%<%F\ #%n\ %1*%m%*%r%h%w
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

" turn off syntax coloring of long lines
set synmaxcol=1024

" do not redraw screen when executing macros
set lazyredraw

" toggle taglist plugin
map <F3> :TlistToggle<CR>

" toggle NERDTree
map <F5> :NERDTreeToggle<CR>

" bind escape key
imap jj <Esc>
imap <S-Space> <Esc>

" search recursively in current dir for word under cursor
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> copen<CR>

" cd to the directory containing the file in the buffer
nmap ,cd :lcd %:h<CR>

" change window
map + <C-w>w

" window movement
map <C-m> <C-w>+
map <C-k> <C-w>-
map <C-h> <C-w><
map <C-l> <C-w>>

" map special keys for non-us keyboards
map ü <C-]>
map ö [
map ä ]
map Ö {
map Ä }
map ß \

" close current window
noremap ,cc :close<CR>

filetype plugin on
filetype indent on

set encoding=utf-8

colorscheme jellybeans

" TagList settings
let tlist_AutoMod_settings='AutoMod;p:procedure;f:function;s:subroutine'

" NERDTree settings
let NERDTreeQuitOnOpen=1

" LatexSuite settings
let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi = 'evince'

au FileType python map <buffer> <F6> :!python %<CR>
au FileType perl map <buffer> <F6> :!perl %<CR>
au FileType html,xhtml map <buffer> <F6> :!firefox %<CR>
au FileType tex map <buffer> <F6> :w<CR>\ll\lv
au FileType tex setlocal spell spelllang=de

" convert special chars in tex files
"au BufWrite *.tex call custom#CleanTex()
