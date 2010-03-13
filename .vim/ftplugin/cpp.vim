" Vim filetype file
" Filename:     cpp.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Sa 13 Mär 2010 02:32:24 CET

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=g++\ -Wall\ -o\ %<\ %
endif

" extend tag files with stdc++ headers
set tags+=~/.vim/tags/cpp

" build c++ specific tags file
map <buffer> <F12> :!ctags -R --c++-kinds=+lp --fields=+iaS --extra=+q --language-force=C++ .<CR><CR>

" enable prototype completion
call ProtoComplInit()
