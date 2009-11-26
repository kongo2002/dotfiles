" Filename:     .vimrc
" Description:  Vim configuration file
" Author:       Gregor Uhlenheuer
" Last Change:  Do 26 Nov 2009 16:41:33 CET

" GLOBAL SETTINGS -------------------------------------------------{{{1

set nocompatible

syntax on
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

" turn on highlight search
set hlsearch

" ignore case in search when no uppercase search
set incsearch
set ignorecase
set smartcase

" set reasonable history size
set history=1000

set viminfo='100,<1000,s100,h
"           |    |     |    |
"           |    |     |    +-- Don't restore hlsearch on startup
"           |    |     +------- Exclude registers greater than N Kb
"           |    +------------- Keep N lines for each register
"           +------------------ Keep marks for N files

" highlight current cursorline
set cursorline

" enable modelines
set modeline
set modelines=5

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

" do not timeout on mappings
set notimeout

" timeout on keycodes
set ttimeout
set ttimeoutlen=100

" visually break lines
set wrap

" break lines at sensible place
set linebreak

" hook arrow for wrapped characters
set showbreak=↪

" show certain non-printing characters
set list listchars=

set lcs+=tab:»·
set lcs+=extends:→
set lcs+=precedes:←
set lcs+=nbsp:·
set lcs+=trail:·

" no backup
set nobackup

" hide intro screen
set shortmess+=I

" modify grep settings
set grepprg=grep\ -nH\ $*

" enable 256 color support
set t_Co=256

" set colorscheme
set background=dark

colorscheme jellybeans

" STATUSLINE SETTINGS ---------------------------------------------{{{1

" display statusline even if there is only one window
set laststatus=2

" filename, flags
set statusline=%<%F\ #%n\ %1*%m%*%r%h%w

" fileformat, encoding
set statusline+=\ [%{&ff}]\ %y\ [%{(&fenc==\"\"?&enc:&fenc)}]

" current space.vim command
set statusline+=%{SSpace()}

" current syntax group
set statusline+=%{SyntaxItem()}

" line, column, percentage
set statusline+=%=%10(%l,%v%)\ %P

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

" use Q for formatting
map Q gq

" move to middle of current line
nmap <expr> gM (strlen(getline("."))/2)."<Bar>"

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

" NERDTree mapping
map <F1> :NERDTreeToggle<CR>

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

" extend runtime path with plugin directory
sil! cal pathogen#runtime_prepend_subdirectories($HOME.'/.vim_plugins')

" SNIPMATE --------------------------------------------------------{{{2

let g:snips_author='Gregor Uhlenheuer'

" TAGLIST ---------------------------------------------------------{{{2

let Tlist_AutoMod_settings='AutoMod;p:procedure;f:function;s:subroutine'

" NERDTREE --------------------------------------------------------{{{2

let NERDTreeQuitOnOpen = 1

" TIMESTAMP -------------------------------------------------------{{{2

let g:timestamp_rep='%c'

" TO_HTML ---------------------------------------------------------{{{2

let html_number_lines = 0 " don't show line numbers
let html_use_css = 1      " don't use inline stylesheets
let html_no_pre = 1       " don't enclose in <pre> tags

" FILETYPE SPECIFICS ----------------------------------------------{{{1

" AUTOCOMMANDS ----------------------------------------------------{{{2

au FileType python map <buffer> <F6> :!python %<CR>
au FileType perl map <buffer> <F6> :!perl %<CR>
au FileType html,xhtml map <buffer> <F6> :!firefox %<CR>
au FileType AutoMod setlocal fdm=syntax noet nolist
au FileType crontab setlocal backupcopy=yes

" LATEX -----------------------------------------------------------{{{2

let g:tex_fold_enabled = 1    " enable syntax folding
let g:tex_ignore_makefile = 1 " do not search for 'Makefile'

" AUTOCOMMANDS ----------------------------------------------------{{{1

au BufReadPost * call LastCurPos()

" TERM SPECIFICS --------------------------------------------------{{{1

" fix arrow keys
if &term ==? "rxvt-unicode"
    imap OA <Esc>ki
    imap OB <Esc>ji
    imap OC <Esc>li
    imap OD <Esc>hi
endif

if &term ==? "xterm"
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2
endif

" WINDOWS SPECIFICS -----------------------------------------------{{{1

if has('win32')
    set guifont=Lucida_Console:h8:cDEFAULT
    set lines=80
    set columns=90

    let Tlist_Ctags_Cmd='D:\ctags57\ctags.exe'
endif

" CUSTOM FUNCTIONS ------------------------------------------------{{{1

" get current movement for space.vim plugin -----------------------{{{2
function! SSpace()
    if exists("*GetSpaceMovement") && GetSpaceMovement() != ""
        return " [" . GetSpaceMovement() . "]"
    else
        return ""
    endif
endfunction

" get syntax highlight group under cursor -------------------------{{{2
function! SyntaxItem()
    let synGrp=synIDattr(synID(line("."), col("."), 1), "name")
    if synGrp != ""
        return " [" . synGrp . "]"
    else
        return ""
    endif
endfunction

" implement a custom TOhtml function ------------------------------{{{2
function! DivHtml() range
    exec a:firstline . "," . a:lastline . "TOhtml"
    %g/<style/normal $dgg
    %s/<\/style>\n<\/head>\n//
    %s/body {/.vim_block {/
    %s/<body\(.*\)>/<div class="vim_block"\1>/
    %s/<\/body>\n<\/html>/<\/div>/
    silent %s/<br>//g
endfunction

command -range=% DivHtml <line1>,<line2>call DivHtml()

" jump to last cursor position ------------------------------------{{{2
function! LastCurPos()
    if line("'\"") > 0 && line ("'\"") <= line("$")
        exe "normal g'\""
    endif
endfunction
