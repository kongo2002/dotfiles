" Vim filetype file
" Filename:     cpp.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Wed 30 Jan 2019 06:16:30 PM CET

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
