" Vim 'after filetype' plugin file
" Language:     Haskell
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>
" Last Change:  Sat 05 Jan 2013 09:35:06 PM CET

" haskell specific keyword settings
" especially useful for 'hothasktags'
setl iskeyword=a-z,A-Z,_,.,39

map <buffer> <F12> :!hothasktags `find . -iname "*.hs"` > tags<CR><CR>
