" Filename:     .vimrc
" Description:  Vim configuration file
" Author:       Gregor Uhlenheuer
" Last Change:  Mon 24 Feb 2020 10:39:49 PM CET

if !has('nvim')
    set nocompatible
endif

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

" enable 24-bit colors (if possible)
if has('termguicolors') && index(['xterm-256color', 'xterm-kitty'], expand('$TERM')) >= 0
    set termguicolors
endif

" extend runtime path with plugin directory
sil! call pathogen#runtime_prepend_subdirectories($HOME.'/.plugins')

" reset any global filetype actions
filetype off

filetype on
filetype plugin on
filetype indent on

syntax on

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

" set relative numbers as well
if exists('+relativenumber')
    set relativenumber
endif

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
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.lo

" disable some filetypes for completion
" blocking possibly large directories that usually are
" not of interest will speed up plugins like Command-T
set wildignore+=*.o,*.obj,*.dll,*.pyc
set wildignore+=*.gif,*.jpg,*.jpeg,*.png
set wildignore+=movies/**,pictures/**,music/**
set wildignore+=*.class,*.jar
set wildignore+=*.beam
set wildignore+=*.hi,*.p_hi,*.p_o,*.dyn_hi,*.dyn_o
set wildignore+=*.pdb,*.mdb

" turn on mouse in all modes
if has('mouse')
    set mouse=a
endif

" show cursor position all the time
set ruler

" indicates fast terminal connection (if necessary)
if !has('nvim')
    set ttyfast
endif

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

" store swap files in the same directory
set directory=~/.vim/backup,~/tmp,/tmp,.

" no backup
set nobackup

" hide intro screen
set shortmess+=I

" show command
set showcmd

" use ag or ack for grepping
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column\ --ignore\ tags
    set grepformat=%f:%l:%c%m
else
    " use ack for grepping otherwise
    set grepprg=ack\ -H\ --nocolor\ --nogroup\ --column
    set grepformat=%f:%l:%c:%m,%f
endif

" STATUSLINE SETTINGS --------------------------------------------------{{{1

" display statusline even if there is only one window
set laststatus=2

" NOTE: the `statusline` settings below are usually overwritten when
" you have vim-airline installed. However I will keep it in here so
" we have a somewhat decent statusline in case you don't have additional
" plugins installed.

" filename, flags
let &statusline='%f %<#%n %m%*%r%h%w'

" fileformat, encoding
let &statusline.='[%{&ff}]%y[%{(&fenc==""?&enc:&fenc)}]'

" show paste if enabled
let &statusline.='%{&paste?"[paste]":""}'

" current space.vim command
let &statusline.='%{SSpace()}'

" syntastic plugin
let &statusline.='%#warningmsg#'
let &statusline.='%{SSyntastic()}'
let &statusline.='%*'

" git branch and commit
let &statusline.='%{SFugitive()}'

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
let maplocalleader=','

" bind escape key
imap jj <Esc>

" easily add empty newlines
nmap <expr> <Return> InsertNewline(1)
nmap <expr> <S-Return> InsertNewline(0)

" redraw screen and remove search highlights
nnoremap <silent> <C-l> :noh<CR><C-l>

" change window
noremap + <C-w>w

" yank to end of line
nnoremap Y y$

" use Q for formatting
noremap Q gq

" break the undo sequence before deleting the whole line
inoremap <C-u> <C-g>u<C-u>

" easier navigation on wrapped lines
nnoremap j gj
nnoremap k gk

" move to middle of current line
nmap <expr> gM (strlen(getline("."))/2)."<Bar>"

" easier navigation in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-n> <Up>
cnoremap <C-p> <Down>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>

" bind K to grep
nnoremap K :grep! "\b<cword>\b"<CR>:cw<CR>

" use vimgrep without autocommands being invoked
nmap <Leader>nv :noautocmd vim /

" toggle paste mode
nmap <silent> <Leader>p :setl paste! paste?<CR>

" toggle wrap
nmap <silent> <Leader>w :setl wrap! wrap?<CR>

" toggle list
nmap <silent> <Leader>nl :setl list! list?<CR>

" toggle spell checking
nmap <silent> <Leader>ns :setl spell! spell?<CR>

" toggle relative numbers if installed
if exists('+relativenumber')
    nmap <silent> <Leader>rn :if &rnu <Bar> set nornu nu <Bar>
                \ else <Bar> set rnu nonu <Bar> endif<CR>
endif

" toggle colorcolumn if installed
if exists('+colorcolumn')
    " set colorcolumn to textwidth + 1
    set colorcolumn=+1
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
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

" NERDTree mapping
map <F1> :NERDTreeToggle<CR>

" TagBar mapping
map <F3> :TagbarToggle<CR>

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
nmap <silent> <Leader>cd :cd %:h<CR>

" search recursively in current dir for word under cursor
map <F4> :execute 'noautocmd vim /' . expand('<cword>') . '/j **'
            \ <Bar> copen <CR>

" search recursively for highlighted string
vmap <Leader>v y:noautocmd vimgrep /<C-r>"/ **/*.

" substitute the highlighted string
vmap <Leader>s y:%s/<C-r>"/

" toggle matching of long lines
map <F11> :call ToggleLongLines()<CR>

" build ctags in current directory
map <F12> :!ctags -R .<CR><CR>

" invoke sudo afterwards using 'tee'
com! SudoW exe 'silent w !sudo tee % >/dev/null' | :edit!

" maps Control-Space to omnicompletion
if has('gui_running')
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" PLUGIN SETTINGS ------------------------------------------------------{{{1

let g:loaded_dict = 1

" BUILT-INS ------------------------------------------------------------{{{2

" disable some built-in plugins
let g:loaded_getscriptPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_spellfile_plugin = 0

" FSWITCH --------------------------------------------------------------{{{2

if has('autocmd')
    augroup fswitch_au
        au!
        au BufRead,BufNewFile *.h let b:fswitchdst = 'c,C,cc,cpp'
        au BufRead,BufNewFile *.h let b:fswitchlocs = 'reg:/include/src/,'
                   \ . 'reg:/include.*/src/,./'

        au BufRead,BufNewFile *.hpp,*.hh let b:fswitchdst = 'cc,cpp'
        au BufRead,BufNewFile *.hpp,*.hh let b:fswitchlocs = 'reg:/include/src/,'
                   \ . 'reg:/include.*/src/,./'

        au BufRead,BufNewFile *.c let b:fswitchdst  = 'h'
        au BufRead,BufNewFile *.c let b:fswitchlocs = 'reg:/src/include/,'
                   \ . 'reg:|src|include/**|,./'

        au BufRead,BufNewFile *.cc let b:fswitchdst  = 'h,hh'
        au BufRead,BufNewFile *.cc let b:fswitchlocs = 'reg:/src/include/,'
                    \ . 'reg:|src|include/**|,./'

        au BufRead,BufNewFile *.cpp let b:fswitchdst  = 'h,hpp'
        au BufRead,BufNewFile *.cpp let b:fswitchlocs = 'reg:/src/include/,'
                    \ . 'reg:|src|include/**|,./'
    augroup END
endif

" FZF ------------------------------------------------------------------{{{2

if has('nvim')
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

" GIST -----------------------------------------------------------------{{{2

let g:gist_detect_filetype = 1

" SURROUND -------------------------------------------------------------{{{2

let g:surround_indent = 1

" SYNTASTIC ------------------------------------------------------------{{{2

let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_c_config_file = '.config'
let g:syntastic_cpp_compiler_options = '-std=c++0x'
let g:syntastic_cpp_config_file = '.config'
let g:syntastic_cs_checkers = ['syntax', 'issues']

let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['scala'] }

" SYNTASTIC - PYTHON OPTIONS -------------------------------------------{{{3

let g:syntastic_python_flake8_args = '--ignore=E501'

" SYNTASTIC - HASKELL OPTIONS ------------------------------------------{{{3

function! s:FindCabalSandbox()
    let sandbox = finddir('.cabal-sandbox', './;')
    let package = glob(sandbox . '/*-packages.conf.d')
    if package != ''
        return ' -g-package-db=' . package
    endif
    return ''
endfunction

let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']
let g:syntastic_haskell_hdevtools_args = '-g-Wall' . <sid>FindCabalSandbox()

" ELM-VIM --------------------------------------------------------------{{{2

let g:elm_format_autosave = 0
let g:elm_setup_keybindings = 0

" VIM-GO ---------------------------------------------------------------{{{2

" general settings
let g:go_autodetect_gopath = 1

" syntax highlighting
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1

" YOUCOMPLETEME --------------------------------------------------------{{{2

let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_whitelist = { 'c' : 1 }

" ULTISNIPS ------------------------------------------------------------{{{2

let g:snips_author = 'Gregor Uhlenheuer'

let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" TAGBAR ---------------------------------------------------------------{{{2

let g:tagbar_compact = 1

let g:tagbar_type_erlang = {
    \ 'ctagstype': 'erlang',
    \ 'sro': ':',
    \ 'kinds': [
        \ 'm:modules',
        \ 'f:functions',
        \ 'r:records',
        \ 't:types',
        \ 'd:macros' ]
    \ }

let g:tagbar_type_automod = {
    \ 'ctagstype' : 'automod',
    \ 'kinds' : [
        \ 'p:procedure',
        \ 'f:function',
        \ 's:subroutine' ],
    \ 'sort' : 0
    \ }

let g:tagbar_type_tex = {
    \ 'ctagstype' : 'tex',
    \ 'kinds' : [
        \ 'c:chapter',
        \ 's:section',
        \ 'l:label',
        \ 'r:ref' ],
    \ 'sort' : 0
    \ }

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" NERDCOMMENTER --------------------------------------------------------{{{2

let NERDSpaceDelims = 1
let NERDCreateDefaultMappings = 0

nmap <Leader>cc <plug>NERDCommenterComment
vmap <Leader>cc <plug>NERDCommenterComment
nmap <Leader>ci <plug>NERDCommenterInvert
vmap <Leader>ci <plug>NERDCommenterInvert
nmap <Leader>cs <plug>NERDCommenterSexy
vmap <Leader>cs <plug>NERDCommenterSexy
nmap <Leader>cA <plug>NERDCommenterAppend
vmap <Leader>cA <plug>NERDCommenterAppend
nmap <Leader>cu <plug>NERDCommenterUncomment
vmap <Leader>cu <plug>NERDCommenterUncomment

" NERDTREE -------------------------------------------------------------{{{2

let NERDTreeQuitOnOpen = 1

" AIRLNE ---------------------------------------------------------------{{{2

" disable whitespace checks
let g:airline#extensions#whitespace#enabled = 0

" activate the extended tabline extension
let g:airline#extensions#tabline#enabled = 1

" tabline displays buffers in a single tab
let g:airline#extensions#tabline#show_buffers = 1

" SPACE-VIM ------------------------------------------------------------{{{2

" disable select mode mappings due to problems with snipmate
let g:space_disable_select_mode = 1

" TIMESTAMP ------------------------------------------------------------{{{2

let g:timestamp_rep='%c'

" TO_HTML --------------------------------------------------------------{{{2

let html_number_lines = 0 " don't show line numbers
"let html_use_css = 1     " don't use inline stylesheets
"let html_no_pre = 1      " don't enclose in <pre> tags

" VIMERL ---------------------------------------------------------------{{{2

let erlang_show_errors = 0
let erlang_skel_replace = 0

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

" DEOPLETE -------------------------------------------------------------{{{2

let g:deoplete#enable_at_startup = 1

" FILETYPE SPECIFICS ---------------------------------------------------{{{1

" AUTOCOMMANDS ---------------------------------------------------------{{{2

if has('autocmd')
    augroup custom_au
        au!
        au FileType python map <buffer> <F6> :!python "%"<CR>
        au FileType perl map <buffer> <F6> :!perl "%"<CR>
        au FileType html,xhtml map <buffer> <F6> :!firefox "%"<CR>
        au FileType crontab setlocal backupcopy=yes
        au FileType text setlocal textwidth=78
        au FileType markdown setlocal textwidth=80
        au FileType cs setlocal omnifunc=OmniSharp#Complete
        au BufWrite *.bib call custom#PrepareBib()
        au BufWrite *.tex call custom#PrepareTex()
        au BufReadPost * call LastCurPos()
        au BufWritePost .vimrc,_vimrc so %
        au BufWritePost .Xdefaults sil !xrdb %
        au BufRead,BufNewFile *.e{build,class} let is_bash=1|setf sh
        au BufRead,BufNewFile *.e{build,class} setl ts=4 sw=4 noet
        au BufRead,BufNewFile haproxy* setl ft=haproxy
        au BufRead,BufNewFile *.cpp,*.CPP setl ft=cpp
        au BufWritePre * call RemoveTrailingWhitespace()
    augroup END
endif

" C / C++ --------------------------------------------------------------{{{2

let g:c_syntax_for_h = 1

" PYTHON ---------------------------------------------------------------{{{2

let g:python_highlight_all = 1

" VALA -----------------------------------------------------------------{{{2

let g:syntastic_vala_modules =
    \ [ 'ggit-1.0'
    \ , 'gio-2.0'
    \ , 'gtk+-3.0'
    \ , 'gd-1.0'
    \ , 'gtksourceview-3.0'
    \ , 'libpeas-1.0'
    \ , 'gee-0.8'
    \ , 'json-glib-1.0'
    \ , 'libsoup-2.4'
    \ , 'webkit2gtk-3.0'
    \ , 'config'
    \ ]

" OMNISHARP ------------------------------------------------------------{{{2

augroup custom_omnisharp
    au!
    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    "autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
augroup END

" LATEX ----------------------------------------------------------------{{{2

let g:tex_flavor = 'tex'      " set default filetype to LaTeX
let g:tex_fold_enabled = 1    " enable syntax folding
let g:tex_ignore_makefile = 1 " do not search for 'Makefile'

" OS SPECIFICS ---------------------------------------------------------{{{1

if has('win32') || has('win64')
    set guifont=Lucida_Console:h8:cDEFAULT
    set lines=80
    set columns=90

    let g:tagbar_ctags_bin = 'c:\bin\ctags58\ctags.exe'
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
    com! DiffOrig vert new | setl bt=nofile | r # | 0d_ | diffthis
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

" SFugitive() - get the current git branch and commit ------------------{{{2
function! SFugitive()
    if exists('*fugitive#statusline')
        return fugitive#statusline()
    endif
    return ""
endfunction

" SSyntastic() - get the number of syntax errors found -----------------{{{2
function! SSyntastic()
    if exists('*SyntasticStatuslineFlag')
        return SyntasticStatuslineFlag()
    endif
    return ""
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
        norm! g`"
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
function! s:LoadColorScheme(highcolor, lowcolor)
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
function! s:Underline(chars)
    let chars = empty(a:chars) ? '-' : a:chars
    let len = (virtcol('$') - 1) / len(chars)
    let rem = virtcol('$') - len * len(chars) - 1
    call append('.', repeat(chars, len) . (rem ? strpart(chars, 0, rem) : ''))
endfunction
com! -nargs=? Underline call <SID>Underline(<q-args>)

" GrepOpenBuffers() - search in all open buffers -----------------------{{{2
function! s:GrepOpenBuffers(search, jump)
    call setqflist([])
    let cur = getpos('.')
    silent! exe 'bufdo vimgrepadd /' . a:search . '/ %'
    let matches = len(getqflist())
    if a:jump && matches > 0
        sil! cfirst
    else
        call setpos('.', cur)
    endif
    echo 'BufGrep:' ((matches) ? matches : 'No') 'matches found'
endfunction
com! -nargs=1 -bang BufGrep call <SID>GrepOpenBuffers('<args>', <bang>0)

" InsertLineNumbers() - insert line numbers ----------------------------{{{2
function! s:InsertLineNumbers(first, last)
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
com! -range=% LineNum call <SID>InsertLineNumbers(<line1>, <line2>)

" HighAllOverColumn() - highlight all columns after given column -------{{{2
function! HighAllOverColumn(column)
    if a:column <= 0 | return | endif
    let cc_set = ''
    for col in range(a:column + 1, &columns)
        if col != a:column + 1 | let cc_set .= ',' | endif
        let cc_set .= col
    endfor
    let &cc = cc_set
endfunction

" TextEnableCodeSnip() - highlight nested syntax regions ---------------{{{2
function! TextEnableCodeSnip(ft, start, end, textSnipHl) abort
    let ft=toupper(a:ft)
    let group='textGroup'.ft
    if exists('b:current_syntax')
        let s:current_syntax = b:current_syntax
        unlet b:current_syntax
    endif
    execute 'syntax include @'.group.' syntax/'.a:ft.'.vim'
    try
        execute 'syntax include @'.group.' after/syntax/'.a:ft.'.vim'
    catch
    endtry
    if exists('s:current_syntax')
        let b:current_syntax = s:current_syntax
    else
        unlet b:current_syntax
    endif
    execute 'syntax region textSnip'.ft.'
                \ matchgroup='.a:textSnipHl.'
                \ start="'.a:start.'" end="'.a:end.'"
                \ contains=@'.group
endfunction

" InsertNewline() - insert an empty newline in normal mode -------------{{{2
function! InsertNewline(below)
    if &modifiable && &buftype == ''
        return a:below ? "o\<Esc>" : "O\<Esc>"
    endif
    return "\<CR>"
endfunction

" DiffTwoLines() - Diff the two specified lines ------------------------{{{2
function! DiffTwoLines(line1, line2)
    " split line on parens and comma
    let reg = '[(,)]\s*\zs'
    let text1 = split(getline(a:line1), reg)
    let text2 = split(getline(a:line2), reg)

    new
    sil put =text1
    normal ggdd
    setl buftype=nofile
    setl bufhidden=hide
    setl noswapfile
    diffthis

    vnew
    sil put =text2
    normal ggdd
    setl buftype=nofile
    setl bufhidden=hide
    setl noswapfile
    diffthis
endfunction

com! DiffNextLine call DiffTwoLines('.', line('.')+1)

" CloseOthers() - Close all other buffers than the current one ---------{{{2
function! CloseOthers()
    let n = 1
    let closed = 0
    let buffer = bufnr('%')
    let last_buffer = bufnr('$')

    while n <= last_buffer
        if n != buffer && buflisted(n) && !getbufvar(n, '&modified')
            sil exe 'bdel ' . n
            if !buflisted(n)
                let closed += 1
            endif
        endif
        let n += 1
    endwhile

    if closed > 0
        echomsg closed 'buffers closed'
    endif
endfunction
com! -nargs=0 BOthers call CloseOthers()
nmap <Leader>bo :call CloseOthers()<CR>

" CUSTOM COMMANDS ------------------------------------------------------{{{1

com! MongoRC :e ~/.mongorc.js
com! -range=% Json exe '<line1>,<line2>!python -m json.tool' |
            \ set filetype=javascript
com! -range=% Xml exe '<line1>,<line2>!xmllint --format --recover -' |
            \ set filetype=xml

" COLORSCHEME ----------------------------------------------------------{{{1

call <SID>LoadColorScheme('tender:kongo3:kongo:kongo2:slate', 'slate')
