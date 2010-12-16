" Filename:     .gvimrc
" Description:  GVim configuration file
" Author:       Gregor Uhlenheuer
" Last Change:  Sun 31 Oct 2010 07:25:57 PM CET

" font name and size
set guifont=Inconsolata\ Medium\ 12
"set guifont=Monospace\ 9
"set guifont=Terminus\ 12
"set guifont=DejaVu\ Sans\ Mono\ 11

" default window size
set columns=90
set lines=50

" enlarge window when using gvimdiff
if &foldmethod == 'diff'
    set columns=165
endif

" make Shift-Insert work as expected
map! <S-Insert> <C-r>*

" popup on right-click
set mousemodel=popup

set guioptions-=m   " no menu
set guioptions-=T   " no toolbar
set guioptions-=r   " no right scrollbar
set guioptions-=L   " no left scrollbar
