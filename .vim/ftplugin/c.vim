" Vim filetype file
" Filename:     c.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Sun 16 May 2010 02:03:24 PM CEST

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
map <buffer> <F12> :!ctags -R --c-kinds=+lp --fields=+iaS --extra=+q --language-force=C .<CR><CR>

" enable prototype completion
call ProtoComplInit()
