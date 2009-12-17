" Vim filetype file
" Filename:     cpp.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Do 17 Dez 2009 19:58:22 CET

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=g++\ -Wall\ -o\ %<\ %
endif

" extend tag files with stdc++ headers
set tags+=~/.vim/tags/cpp

" build c++ specific tags file
map <buffer> <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ .<CR><CR>
