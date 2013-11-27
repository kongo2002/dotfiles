" Vim filetype file
" Filename:     cpp.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Sat 07 Aug 2010 11:38:47 AM CEST

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=g++\ -Wall\ -o\ %<\ %
endif

" extend tag files with stdc++ headers
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/sdl

" build c++ specific tags file
map <buffer> <F12> :sil !ctags -R --c++-kinds=+lp --fields=+iaS --extra=+q --language-force=C++ .<CR>

" enable prototype completion
call ProtoComplInit()

" OmniCppComplete initialization
call omni#cpp#complete#Init()
