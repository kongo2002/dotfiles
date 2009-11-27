" Vim filetype file
" Filename:     c.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Do 26 Nov 2009 23:50:26 CET

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=gcc\ -Wall\ -o\ %<\ %
endif
