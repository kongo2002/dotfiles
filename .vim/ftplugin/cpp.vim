" Vim filetype file
" Filename:     cpp.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Sun 16 May 2010 02:03:54 PM CEST

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=g++\ -Wall\ -o\ %<\ %
endif

" extend tag files with stdc++ headers
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/sdl

" build c++ specific tags file
map <buffer> <F12> :!ctags -R --c++-kinds=+lp --fields=+iaS --extra=+q --language-force=C++ .<CR><CR>

" enable prototype completion
call ProtoComplInit()
