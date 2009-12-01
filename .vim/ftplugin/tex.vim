" Vim filetype file
" Filename:     tex.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Di 01 Dez 2009 12:55:53 CET

" turn on syntax-based folding
setlocal foldmethod=syntax

" turn on spellchecking
setlocal spell spelllang=de

" set spellfile
set spellfile=~/.vim/spell/de.utf-8.add

" show only the first 10 suggestions
setlocal sps=fast,10

" wrap the text after 80 columns
setlocal textwidth=80

" set compiler/make
compiler tex

" compile and preview
map <buffer> <F6> :make %<CR>:!xdvi %:p:r.dvi &<CR>

" set spell error color for non-gui vim
if !has("gui_running")
    hi SpellBad ctermfg=0 ctermbg=1
endif
