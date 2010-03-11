" Vim filetype file
" Filename:     c.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Fr 12 Mär 2010 00:31:43 CET

" set makeprg to compiler when no Makefile
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=gcc\ -Wall\ -o\ %<\ %
endif

" extend tag files with additional headers
set tags+=~/.vim/tags/cairo
set tags+=~/.vim/tags/glib2
set tags+=~/.vim/tags/gtk2
set tags+=~/.vim/tags/pango

" build c specific tags file
map <buffer> <F12> :!ctags -R --c-kinds=+lp --fields=+iaS --extra=+q --language-force=C .<CR><CR>
