" Vim filetype file
" Filename:     c.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Do 11 Feb 2010 23:21:15 CET

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=gcc\ -Wall\ -o\ %<\ %
endif

" build c specific tags file
map <buffer> <F12> :!ctags -R --c-kinds=+lp --fields=+iaS --extra=+q --language-force=C .<CR><CR>
