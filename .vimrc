" Filename:     .vimrc
" Description:  Vim configuration file
" Author:       Gregor Uhlenheuer
" Last Change:  Mi 23 Dez 2009 00:07:35 CET

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

" interoperate with the X clipboard (* register)
set clipboard=unnamed

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

" vertical diffsplit by default
set diffopt+=vertical

" number of screen lines around cursor
set scrolloff=5

" turn off syntax coloring of long lines
set synmaxcol=1024

" do not redraw screen when executing macros
set lazyredraw

" turn on wildmenu completion
set wildmenu

" disable some filetypes for completion
set wildignore=*.o,*.obj,*.dll

" turn on mouse in all modes
if has('mouse')
    set mouse=a
endif

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
set statusline+=[%{&ff}]%y[%{(&fenc==\"\"?&enc:&fenc)}]

" current space.vim command
set statusline+=%{SSpace()}

" syntastic plugin
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" current syntax group
"set statusline+=%{SyntaxItem()}

" display search matches
set statusline+=%=%{SearchMatches(actual_curbuf)}

" line, column, percentage
set statusline+=%10(%l,%v%)\ %P

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
nmap <silent> <M-b> :bnext<CR>

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

" build ctags in current directory
map <F12> :!ctags -R .<CR><CR>

" maps Control-Space to omnicompletion
if has('gui_running')
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" PLUGIN SETTINGS -------------------------------------------------{{{1

" extend runtime path with plugin directory
sil! cal pathogen#runtime_prepend_subdirectories($HOME.'/.vim_plugins')

" SNIPMATE --------------------------------------------------------{{{2

let g:snips_author='Gregor Uhlenheuer'

" TAGLIST ---------------------------------------------------------{{{2

let Tlist_Exit_OnlyWindow = 1
let tlist_AutoMod_settings='AutoMod;p:procedure;f:function;s:subroutine'

" NERDTREE --------------------------------------------------------{{{2

let NERDTreeQuitOnOpen = 1

" SPACE-VIM -------------------------------------------------------{{{2

" disable select mode mappings due to problems with snipmate
let g:space_disable_select_mode = 1

" TIMESTAMP -------------------------------------------------------{{{2

let g:timestamp_rep='%c'

" TO_HTML ---------------------------------------------------------{{{2

let html_number_lines = 0 " don't show line numbers
let html_use_css = 1      " don't use inline stylesheets
let html_no_pre = 1       " don't enclose in <pre> tags

" OMNICPPCOMPLETE -------------------------------------------------{{{2

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = [ "std" ]

" FILETYPE SPECIFICS ----------------------------------------------{{{1

" AUTOCOMMANDS ----------------------------------------------------{{{2

if has('autocmd')
    au FileType python map <buffer> <F6> :!python %<CR>
    au FileType perl map <buffer> <F6> :!perl %<CR>
    au FileType html,xhtml map <buffer> <F6> :!firefox %<CR>
    au FileType crontab setlocal backupcopy=yes
    au BufWrite *.bib call custom#PrepareBib()
    au BufWrite *.tex call custom#PrepareTex()
    au BufReadPost * call LastCurPos()
endif

" C / C++ ---------------------------------------------------------{{{2

let g:c_syntax_for_h = 1

" LATEX -----------------------------------------------------------{{{2

let g:tex_fold_enabled = 1    " enable syntax folding
let g:tex_ignore_makefile = 1 " do not search for 'Makefile'

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

" OS SPECIFICS ----------------------------------------------------{{{1

if has('win32')
    set guifont=Lucida_Console:h8:cDEFAULT
    set lines=80
    set columns=90

    let Tlist_Ctags_Cmd='D:\ctags57\ctags.exe'
endif

" CUSTOM FUNCTIONS ------------------------------------------------{{{1

" SSpace() - get current movement for space.vim plugin ------------{{{2
function! SSpace()
    if exists("*GetSpaceMovement") && GetSpaceMovement() != ""
        return "[" . GetSpaceMovement() . "]"
    else
        return ""
    endif
endfunction

" SyntaxItem() - get syntax highlight group under cursor ----------{{{2
function! SyntaxItem()
    let synGrp=synIDattr(synID(line("."), col("."), 1), "name")
    if synGrp != ""
        return " [" . synGrp . "]"
    else
        return ""
    endif
endfunction

" DivHtml() - implement a custom TOhtml function ------------------{{{2
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

" LastCurPos() - jump to last cursor position ---------------------{{{2
function! LastCurPos()
    if line("'\"") > 0 && line ("'\"") <= line("$")
        exe "normal g'\""
    endif
endfunction

" SearchMatches() - get number of search matches ------------------{{{2
function! SearchMatches(nr)
    if bufnr('') != a:nr
        return ''
    endif
    try
        if getreg('/') == '' | return '' | endif
        if line('$') > 5000 | return '' | endif

        let [buf, lnum, cnum, off] = getpos('.')
        let [l, c] = searchpos(@/, 'cnbW')
        if lnum != l || cnum != c | return '' | endif

        let above = 1
        let below = 0

        while 1
            let [l, c] = searchpos(@/, 'bW')
            if l == 0 && c == 0 | break | endif

            let above += 1
            if above + below > 100
                call setpos('.', [buf, lnum, cnum, off])
                return ''
            endif
        endwhile

        call setpos('.', [buf, lnum, cnum, off])

        while 1
            let [l, c] = searchpos(@/, 'W')
            if l == 0 && c == 0 | break | endif

            let below += 1
            if above + below > 100
                call setpos('.', [buf, lnum, cnum, off])
                return ''
            endif
        endwhile

        call setpos('.', [buf, lnum, cnum, off])

        return above . '/' . (above + below)

    catch /.*/
        return ''
    endtry
endfunction
