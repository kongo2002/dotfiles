" Filename:     .vimrc
" Description:  Vim configuration file
" Author:       Gregor Uhlenheuer
" Last Change:  Mo 02 Nov 2009 22:03:07 CET

" GLOBAL SETTINGS -------------------------------------------------{{{1

set nocompatible

filetype on
filetype plugin on
filetype indent on

set encoding=utf-8

" allow backspace in insert mode
set backspace=indent,eol,start

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

" enable modelines
set modeline
set modelines=5

" display statusline even if there is only one window
set laststatus=2

" filename, flags
set statusline=%<%F\ #%n\ %1*%m%*%r%h%w

" fileformat, encoding
set statusline+=\ [%{&ff}]\ %y\ [%{(&fenc==\"\"?&enc:&fenc)}]

" current space.vim command
set statusline+=\ %{SSpace()}

" line, column, percentage
set statusline+=%=%10(%l,%v%)\ %P

" folding method: markers
set fdm=marker

" display line numbers
set number

" line numbers as narrow as possible
set numberwidth=1

" switch buffers without saving
set hidden

" number of screen lines around cursor
set scrolloff=5

" turn off syntax coloring of long lines
set synmaxcol=1024

" do not redraw screen when executing macros
set lazyredraw

" turn on wildmenu completion
set wildmenu

" turn on mouse in all modes
set mouse=a

" indicates fast terminal connection
set ttyfast

" no backup
set nobackup

" modify grep settings
set grepprg=grep\ -nH\ $*

" enable 256 color support
set t_Co=256

colorscheme jellybeans

" MAPPINGS --------------------------------------------------------{{{1

" set mapleader from backslash to comma
let mapleader=','
let g:mapleader=','

" map Ctrl-E to do what , used to do
nnoremap <C-e> ,
vnoremap <C-e> ,

" bind escape key
imap jj <Esc>

" switch 'jump to mark' mapping
nnoremap ' `
nnoremap ` '

" redraw screen and remove search highlights
nnoremap <silent> <C-l> :noh<CR><C-l>

" change window
map + <C-w>w

" yank to end of line
nnoremap Y y$

" map special keys for non-us keyboards
map ü <C-]>
map ö [
map ä ]
map Ö {
map Ä }
map ß \

" easier navigation in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-n> <Up>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>

" toggle paste mode
nmap <silent> <Leader>p :set paste! paste?<CR>

" toggle wrap
nmap <silent> <Leader>w :set wrap! wrap?<CR>

" Quickfix navigation
nmap <silent> gc :cnext<CR>
nmap <silent> gC :cprev<CR>

" Buffer navigation
nmap <silent> gb :bnext<CR>
nmap <silent> gB :bprev<CR>

" TagList mapping
map <F3> :TlistToggle<CR>

" FuzzyFinder mappings
nmap <Leader>fb :FufBuffer<CR>
nmap <Leader>fd :FufDir<CR>
nmap <Leader>ff :FufFile<CR>

" close current window
noremap <Leader>cc :close<CR>

" cd to the directory containing the file in the buffer
nmap <Leader>cd :lcd %:h<CR>

" search recursively in current dir for word under cursor
map <F4> :execute "vimgrep /".expand("<cword>")."/j **"<Bar>copen<CR>

" PLUGIN SETTINGS -------------------------------------------------{{{1

" SNIPMATE --------------------------------------------------------{{{2

let g:snips_author='Gregor Uhlenheuer'

" TAGLIST ---------------------------------------------------------{{{2

let tlist_AutoMod_settings='AutoMod;p:procedure;f:function;s:subroutine'

" NERDTREE --------------------------------------------------------{{{2

let NERDTreeQuitOnOpen=1

" LATEXSUITE ------------------------------------------------------{{{2

let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi = 'evince'

" FILETYPE SPECIFICS ----------------------------------------------{{{1

au FileType python map <buffer> <F6> :!python %<CR>
au FileType perl map <buffer> <F6> :!perl %<CR>
au FileType html,xhtml map <buffer> <F6> :!firefox %<CR>
au FileType tex map <buffer> <F6> :w<CR>\ll\lv
au FileType tex setlocal spell spelllang=de
au FileType AutoMod setlocal foldmethod=syntax
au FileType cpp setlocal makeprg=g++\ -Wall\ -o\ %<\ %
au FileType c setlocal makeprg=gcc\ -Wall\ -o\ %<\ %

" convert special chars in tex files
"au BufWrite *.tex call custom#CleanTex()

" TERM SPECIFICS --------------------------------------------------{{{1

if &term ==? "rxvt-unicode"
    imap OA <Esc>ki
    imap OB <Esc>ji
    imap OC <Esc>li
    imap OD <Esc>hi
endif

" CUSTOM FUNCTIONS ------------------------------------------------{{{1

function! SSpace()
    if exists("*GetSpaceMovement") && GetSpaceMovement() != ""
        return "[" . GetSpaceMovement() . "]"
    else
        return ""
    endif
endfunction
