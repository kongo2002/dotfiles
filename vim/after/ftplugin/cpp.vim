" Vim filetype file
" Filename:     cpp.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Fri 11 May 2018 11:35:12 PM CEST

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=g++\ -Wall\ -o\ %<\ %
endif

" 2-space indentation
setl et sw=2 sts=2

" extend tag files with stdc++ headers
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/sdl

" build c++ specific tags file
map <buffer> <F12> :sil !ctags -R --c++-kinds=+lp --fields=+iaS --extra=+q --language-force=C++ .<CR>

" enable prototype completion
call ProtoComplInit()

" OmniCppComplete initialization
call omni#cpp#complete#Init()

function! s:CallClangFormat()
    let cur = getpos('.')
    sil %!clang-format
    call setpos('.', cur)
endfunction

if executable('clang-format')
    if has('autocmd')
        augroup cpp_custom_au
            au!
            au BufWritePre *.h,*.hpp,*.cpp,*.cc call <sid>CallClangFormat()
        augroup END
    endif
endif
