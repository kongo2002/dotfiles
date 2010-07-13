" Filename:     .vimrc
" Description:  Vim configuration file
" Author:       Gregor Uhlenheuer
" Last Change:  Tue 13 Jul 2010 09:40:26 PM CEST

set nocompatible

" MACHINE SPECIFICS ----------------------------------------------------{{{1

" machines at work should behave more 'mswin'-like
if has('win32') || has('win64')
    if hostname() != 'UHLI'
        source $VIMRUNTIME/mswin.vim
        behave mswin
    endif
endif

" GLOBAL SETTINGS ------------------------------------------------------{{{1

" unlet g:colors_name to prevent multiple loading of the
" same colorscheme when resourcing .vimrc
sil! unlet g:colors_name

" extend runtime path with plugin directory
sil! call pathogen#runtime_prepend_subdirectories($HOME.'/.vim_plugins')

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
set softtabstop=4
set smarttab

" turn on highlight search
set hlsearch

" ignore case in search when no uppercase search
set incsearch
set ignorecase
set smartcase

" always activate autoindent
set autoindent

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

" start with no folds closed
set foldlevelstart=99

" display line numbers
set number

" line numbers as narrow as possible
set numberwidth=1

" switch buffers without saving
set hidden

" vertical diffsplit by default
set diffopt+=vertical

" do not consider octal numbers for C-a/C-x
set nrformats-=octal

" number of screen lines around cursor
set scrolloff=5

" turn off syntax coloring of long lines
set synmaxcol=1024

" do not redraw screen when executing macros
set lazyredraw

" turn on wildmenu completion
set wildmenu

" give following files lower priority
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.lo

" disable some filetypes for completion
set wildignore=*.o,*.obj,*.dll,*.pyc

" turn on mouse in all modes
if has('mouse')
    set mouse=a
endif

" show cursor position all the time
set ruler

" indicates fast terminal connection
set ttyfast

" timeout settings
set timeout
set nottimeout
set timeoutlen=1000
set ttimeoutlen=50

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

" show command
set showcmd

" use ack for grepping
set grepprg=ack\ -H\ --nocolor\ --nogroup\ --column
set grepformat=%f:%l:%c:%m,%f

" STATUSLINE SETTINGS --------------------------------------------------{{{1

" display statusline even if there is only one window
set laststatus=2

" filename, flags
let &statusline='%<%f #%n %m%*%r%h%w'

" fileformat, encoding
let &statusline.='[%{&ff}]%y[%{(&fenc==""?&enc:&fenc)}]'

" show paste if enabled
let &statusline.='%{&paste?"[paste]":""}'

" current space.vim command
let &statusline.='%{SSpace()}'

" syntastic plugin
if exists('*SyntasticStatuslineFlag')
    let &statusline.='%#warningmsg#'
    let &statusline.='%{SyntasticStatuslineFlag()}'
    let &statusline.='%*'
endif

" number of long lines
let g:num_long_lines = ''

let &statusline.='%#warningmsg#'
let &statusline.='%{exists("actual_curbuf") ?'
            \ . 'NumLongLines(0, actual_curbuf) : ""}'
let &statusline.='%*'

" display search matches
let &statusline.='%=%{exists("actual_curbuf") ?'
            \ . 'SearchMatches(actual_curbuf) : ""}'

" line, column, percentage
let &statusline.='%10(%l,%v%) %P'

" MAPPINGS -------------------------------------------------------------{{{1

" set mapleader from backslash to comma
let mapleader=','

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
noremap + <C-w>w

" yank to end of line
nnoremap Y y$

" use Q for formatting
noremap Q gq

" easier navigation on wrapped lines
nnoremap j gj
nnoremap k gk

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
nmap <silent> <Leader>p :setl paste! paste?<CR>

" toggle wrap
nmap <silent> <Leader>w :setl wrap! wrap?<CR>

" toggle list
nmap <silent> <Leader>nl :setl list! list?<CR>

" toggle relative numbers if installed (custom build)
if exists('+relativenumber')
    nmap <silent> <Leader>rn :if &rnu <Bar> set nornu nu <Bar>
                \ else <Bar> set rnu nonu <Bar> endif<CR>
endif

" toggle margincolumn if installed (custom build)
if exists('+margincolumn')
    " set margincolumn to textwidth
    set margincolumn=-1
endif

" print current syntax item
nmap <silent> <Leader>si :echo SyntaxItem()<CR>

" Quickfix navigation
nmap <silent> gc :cnext<CR>
nmap <silent> gC :cprev<CR>

" Buffer navigation
nmap <silent> <Leader>bd :bdelete<CR>
nmap <silent> gb :bnext<CR>
nmap <silent> gB :bprev<CR>
nmap <silent> <A-right> :bnext<CR>
nmap <silent> <A-left> :bprev<CR>

" NERDTree mapping
map <F1> :NERDTreeToggle<CR>

" TagList mapping
map <F3> :TlistToggle<CR>

" FuzzyFinder mappings
nmap <Leader>fb :FufBuffer<CR>
nmap <Leader>fd :FufDir<CR>
nmap <Leader>ff :FufFile<CR>

" FSwitch mappings
nmap <silent> <Leader>of :FSHere<CR>
nmap <silent> <Leader>ol :FSRight<CR>
nmap <silent> <Leader>oL :FSSplitRight<CR>
nmap <silent> <Leader>oh :FSLeft<CR>
nmap <silent> <Leader>oH :FSSplitLeft<CR>
nmap <silent> <Leader>ok :FSAbove<CR>
nmap <silent> <Leader>oK :FSSplitAbove<CR>
nmap <silent> <Leader>oj :FSBelow<CR>
nmap <silent> <Leader>oJ :FSSplitBelow<CR>

" close current window
nmap <silent> <Leader>cl :close<CR>

" cd to the directory containing the file in the buffer
nmap <silent> <Leader>cd :lcd %:h<CR>

" search recursively in current dir for word under cursor
map <F4> :execute 'vimgrep /' . expand('<cword>') . '/j **'
            \ <Bar> copen <CR>

" toggle matching of long lines
map <F11> :call ToggleLongLines()<CR>

" build ctags in current directory
map <F12> :!ctags -R .<CR><CR>

" maps Control-Space to omnicompletion
if has('gui_running')
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" PLUGIN SETTINGS ------------------------------------------------------{{{1

" BUILT-INS ------------------------------------------------------------{{{2

" disable some built-in plugins
let g:loaded_gzip = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_spellfile_plugin = 1

" FSWITCH --------------------------------------------------------------{{{2

if has('autocmd')
    augroup fswitch_au
        au!
        au BufRead,BufNewFile *.h let b:fswitchdst = 'c,C,cc,cpp'
        au BufRead,BufNewFile *.h let b:fswitchlocs = 'reg:/include/src/,'
                   \ . 'reg:/include.*/src/,./'

        au BufRead,BufNewFile *.c let b:fswitchdst  = 'h'
        au BufRead,BufNewFile *.c let b:fswitchlocs = 'reg:/src/include/,'
                   \ . 'reg:|src|include/**|,./'

        au BufRead,BufNewFile *.cc let b:fswitchdst  = 'h'
        au BufRead,BufNewFile *.cc let b:fswitchlocs = 'reg:/src/include/,'
                    \ . 'reg:|src|include/**|,./'

        au BufRead,BufNewFile *.cpp let b:fswitchdst  = 'h'
        au BufRead,BufNewFile *.cpp let b:fswitchlocs = 'reg:/src/include/,'
                    \ . 'reg:|src|include/**|,./'
    augroup END
endif

" BUFLINE --------------------------------------------------------------{{{2

let g:bufline_loaded = 1

" GIST -----------------------------------------------------------------{{{2

let g:gist_detect_filetype = 1

" SURROUND -------------------------------------------------------------{{{2

let g:surround_indent = 1

" SYNTASTIC ------------------------------------------------------------{{{2

let g:syntastic_enable_signs = 1

" SNIPMATE -------------------------------------------------------------{{{2

let g:snips_author='Gregor Uhlenheuer'

" insert mode completion for snippets
inoremap <C-l> <C-r>=CompleteSnippets()<CR>

" TAGLIST --------------------------------------------------------------{{{2

let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let tlist_automod_settings='automod;p:procedure;f:function;s:subroutine'
let tlist_tex_settings='tex;c:chapter;s:section;l:label;r:ref'

" NERDCOMMENTER --------------------------------------------------------{{{2

let NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1

nmap <Leader>cc <Plug>NERDCommenterComment
vmap <Leader>cc <Plug>NERDCommenterComment
nmap <Leader>cn <Plug>NERDCommenterNest
vmap <Leader>cn <Plug>NERDCommenterNest
nmap <Leader>cm <Plug>NERDCommenterMinimal
vmap <Leader>cm <Plug>NERDCommenterMinimal
nmap <Leader>cs <Plug>NERDCommenterSexy
vmap <Leader>cs <Plug>NERDCommenterSexy
nmap <Leader>cA <Plug>NERDCommenterAppend
vmap <Leader>cA <Plug>NERDCommenterAppend
nmap <Leader>cu <Plug>NERDCommenterUncomment
vmap <Leader>cu <Plug>NERDCommenterUncomment

" NERDTREE -------------------------------------------------------------{{{2

let NERDTreeQuitOnOpen = 1

" SPACE-VIM ------------------------------------------------------------{{{2

" disable select mode mappings due to problems with snipmate
let g:space_disable_select_mode = 1

" TIMESTAMP ------------------------------------------------------------{{{2

let g:timestamp_rep='%c'

" TO_HTML --------------------------------------------------------------{{{2

let html_number_lines = 0 " don't show line numbers
"let html_use_css = 1     " don't use inline stylesheets
"let html_no_pre = 1      " don't enclose in <pre> tags

" OMNICPPCOMPLETE ------------------------------------------------------{{{2

let OmniCpp_SelectFirstItem = 2
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = [ "std" ]

" FILETYPE SPECIFICS ---------------------------------------------------{{{1

" AUTOCOMMANDS ---------------------------------------------------------{{{2

if has('autocmd')
    augroup custom_au
        au!
        au FileType python map <buffer> <F6> :!python %<CR>
        au FileType perl map <buffer> <F6> :!perl %<CR>
        au FileType html,xhtml map <buffer> <F6> :!firefox %<CR>
        au FileType crontab setlocal backupcopy=yes
        au FileType text setlocal textwidth=78
        au BufWrite *.bib call custom#PrepareBib()
        au BufWrite *.tex call custom#PrepareTex()
        au BufReadPost * call LastCurPos()
        au BufWritePost .vimrc,_vimrc so %
        au BufWritePost .Xdefaults sil !xrdb %
        au BufRead,BufNewFile *.e{build,class} let is_bash=1|setf sh
        au BufRead,BufNewFile *.e{build,class} setl ts=4 sw=4 noet
        au BufEnter,CursorHold,BufWritePost * call NumLongLines(1)
        au BufWritePre * call RemoveTrailingWhitespace()
    augroup END
endif

" C / C++ --------------------------------------------------------------{{{2

let g:c_syntax_for_h = 1

" PYTHON ---------------------------------------------------------------{{{2

let g:python_highlight_all = 1

" LATEX ----------------------------------------------------------------{{{2

let g:tex_flavor = 'tex'      " set default filetype to LaTeX
let g:tex_fold_enabled = 1    " enable syntax folding
let g:tex_ignore_makefile = 1 " do not search for 'Makefile'

" TERM SPECIFICS -------------------------------------------------------{{{1

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

" OS SPECIFICS ---------------------------------------------------------{{{1

if has('win32') || has('win64')
    set guifont=Lucida_Console:h8:cDEFAULT
    set lines=80
    set columns=90

    let Tlist_Ctags_Cmd='D:\ctags57\ctags.exe'
endif

" CUSTOM FUNCTIONS -----------------------------------------------------{{{1

" VSetSearch - visual search mappings ----------------------------------{{{2
function! VSetSearch()
    let tmp = @@
    normal! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    call histadd('/', substitute(@/, '[?/]',
                \ '\="\\%d".char2nr(submatch(0))', 'g'))
    let @@ = tmp
endfunction

vnoremap * :<C-u>call VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call VSetSearch()<CR>??<CR>

" DiffOrig - compare current buffer with original ----------------------{{{2
if !exists(':DiffOrig')
    com! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

" SSpace() - get current movement for space.vim plugin -----------------{{{2
function! SSpace()
    if exists("*GetSpaceMovement") && GetSpaceMovement() != ""
        return "[" . GetSpaceMovement() . "]"
    else
        return ""
    endif
endfunction

" SyntaxItem() - get syntax highlight group under cursor ---------------{{{2
function! SyntaxItem()
    let synGrp=synIDattr(synID(line("."), col("."), 1), "name")
    if synGrp != ""
        return "[" . synGrp . "]"
    else
        return ""
    endif
endfunction

" DivHtml() - implement a custom TOhtml function -----------------------{{{2
function! DivHtml() range
    exec a:firstline . "," . a:lastline . "TOhtml"
    g/<\/head/normal! $dgg
    %s/^<body.*$/<pre>/
    g/<\/body>$/normal! 0dG
    silent %s/<br>//g
    call append(line('$'), '</pre>')
endfunction

com! -range=% DivHtml <line1>,<line2>call DivHtml()

" LastCurPos() - jump to last cursor position --------------------------{{{2
function! LastCurPos()
    if line("'\"") > 0 && line ("'\"") <= line("$")
        exe "norm! g`\""
    endif
endfunction

" SearchMatches() - get number of search matches -----------------------{{{2
function! SearchMatches(id)
    try
        if a:id != bufnr('')
            return ''
        endif

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

" ToggleLongLines() - toggle matching of long lines --------------------{{{2
function! ToggleLongLines()
    if exists('*matchadd')
        if !exists('w:long_match')
            let len = (&tw <= 0 ? 80 : &tw)
            let w:long_match = matchadd('ErrorMsg', '.\%>'.(len+1).'v', 0)
            echo 'longlines'
        else
            call matchdelete(w:long_match)
            unlet w:long_match
            echo 'nolonglines'
        endif
    endif
endfunction

" NumLongLines() - return number of long lines -------------------------{{{2
function! NumLongLines(update, ...)
    if a:0
        if a:1 != bufnr("")
            return ''
        endif
    endif

    if line('$') > 5000
        return ''
    endif

    if !a:update | return g:num_long_lines | endif
    let l:max = (&tw ? &tw : 80) + 1
    let l:i = 1
    let l:count = 0
    while l:i <= line('$')
        if virtcol([l:i, '$']) > l:max
            let l:count += 1
        endif
        let l:i += 1
    endwhile
    if l:count > 0
        let g:num_long_lines = '['.l:count.']'
    else
        let g:num_long_lines = ''
    endif
endfunction

" FSearch() - search while skipping closed folds -----------------------{{{2
function! FSearch()
    let pat = input("/")
    let start = line(".")
    let cur = start
    let last = line("$")
    while cur <= last
        let fold_end = foldclosedend(cur)
        if fold_end != -1
            let cur = fold_end + 1
        endif
        let txt = getline(cur)
        if txt =~ pat
            let i = stridx(txt, pat)
            call cursor(cur, i+1)
            return
        endif
        let cur += 1
    endwhile
    let cur = 0
    while cur <= start
        let fold_end = foldclosedend(cur)
        if fold_end != -1
            let cur = fold_end + 1
        endif
        let txt = getline(cur)
        if txt =~ pat
            let i = stridx(txt, pat)
            call cursor(cur, i+1)
            return
        endif
        let cur += 1
    endwhile
endfunction

" RemoveTrailingWhitespace() - remove trailing whitespace --------------{{{2
function! RemoveTrailingWhitespace()
    let cur = getpos('.')
    let reg = @/
    %s/\s\+$//e
    let @/ = reg
    call setpos('.', cur)
endfunction

" LoadColorScheme() - try to load an existing colorscheme --------------{{{2
function! LoadColorScheme(highcolor, lowcolor)
    if has('gui_running') || &t_Co == 256 || &t_Co == 88
        let colors = a:highcolor
    else
        let colors = a:lowcolor
    endif
    for name in split(colors, ':')
        try
            exec 'colorscheme' name
            break
        catch /.*/
        endtry
    endfor
endfunction

" Underline() - underline current line with fill char ------------------{{{2
function! Underline(...)
    let char = a:0 ? a:1 : '='
    call append('.', repeat(char, virtcol('$')-1))
endfunction

" GuideCol() - define 'margincolumn' relative to 'textwidth' -----------{{{2
if exists('+margincolumn')
    function! GuideCol(cols)
        let columns = []
        for col in split(a:cols, ',')
            if col =~ '[-+]\d\+'
                call insert(columns, str2nr(col) + &tw)
            else
                call insert(columns, col)
            endif
        endfor
        exe 'set mc=' . join(columns, ',')
    endfunction
    com! -nargs=1 GuideColumn :call GuideCol(<f-args>)
endif

" InsertLineNumbers() - insert line numbers ----------------------------{{{2
function! InsertLineNumbers(first, last)
    let maxlen = strlen(a:last) + 1
    for line_num in range(a:first, a:last)
        let line = getline(line_num)
        if line !~ '^\s*$'
            call setline(line_num, strpart(line_num.repeat(' ', maxlen), 0,
                        \ maxlen) . line)
        else
            call setline(line_num, line_num . line)
        endif
    endfor
endfunction
com! -range=% LineNum :call InsertLineNumbers(<line1>, <line2>)

" COLORSCHEME ----------------------------------------------------------{{{1

call LoadColorScheme('kongo:kongo2:slate', 'slate')
