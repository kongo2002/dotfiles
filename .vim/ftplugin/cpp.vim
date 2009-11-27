" Vim filetype file
" Filename:     cpp.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Do 26 Nov 2009 23:50:45 CET

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=g++\ -Wall\ -o\ %<\ %
endif
