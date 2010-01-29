" Filename:     .gvimrc
" Description:  GVim configuration file
" Author:       Gregor Uhlenheuer
" Last Change:  Fr 29 Jan 2010 21:44:11 CET

" font name and size
set guifont=Monospace\ 9
"set guifont=Terminus\ 10

" default window size
set columns=90
set lines=60

" enlarge window when using gvimdiff
if &foldmethod == 'diff'
    set columns=165
endif

" make Shift-Insert work as expected
map! <S-Insert> <C-r>*

" popup on right-click
set mousemodel=popup

set guioptions-=T   " no toolbar
set guioptions-=r   " no right scrollbar
set guioptions-=L   " no left scrollbar
