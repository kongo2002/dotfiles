" Vim filetype file
" Filename:     c.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Sat 07 Aug 2010 11:38:15 AM CEST

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

" enable prototype completion
call ProtoComplInit()

" OmniCppComplete initialization
call omni#cpp#complete#Init()
