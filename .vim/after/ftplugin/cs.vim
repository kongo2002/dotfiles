" Vim filetype file
" Filename:     cs.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Fri 20 Apr 2012 10:22:18 PM CEST

" enable syntax based folding
setl foldmethod=syntax

" disable list mode
setl nolist

" set default tabstop to 4
setl tabstop=4

" build C# specific tags file
map <buffer> <F12> :sil !ctags -R --c-kinds=+lp --fields=+iaS --extra=+q --language-force=C\# .<CR>

