" Vim filetype file
" Filename:     c.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Wed 30 Jan 2019 06:16:07 PM CET

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=gcc\ -Wall\ -o\ %<\ %
endif

" extend tag files with additional headers
set tags+=~/.vim/tags/cairo
set tags+=~/.vim/tags/glib2
set tags+=~/.vim/tags/gtk2
set tags+=~/.vim/tags/pango
set tags+=~/.vim/tags/sdl

" build c specific tags file
map <buffer> <F12> :sil !ctags -R --c-kinds=+lp --fields=+iaS --extra=+q --language-force=C .<CR>

" OmniCppComplete initialization
call omni#cpp#complete#Init()
