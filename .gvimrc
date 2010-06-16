" Filename:     .gvimrc
" Description:  GVim configuration file
" Author:       Gregor Uhlenheuer
" Last Change:  Fri 04 Jun 2010 10:40:24 PM CEST

" font name and size
"set guifont=Monospace\ 9
"set guifont=Terminus\ 10
set guifont=DejaVu\ Sans\ Mono\ 11

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

set guioptions-=T   " no toolbar
set guioptions-=r   " no right scrollbar
set guioptions-=L   " no left scrollbar
