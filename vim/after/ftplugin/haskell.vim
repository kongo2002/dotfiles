" Vim 'after filetype' plugin file
" Language:     Haskell
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>
" Last Change:  Thu 19 Jun 2014 10:23:46 PM CEST

if executable('hasktags') == 1
    map <buffer> <F12> :!hasktags -c .<CR><CR>
endif

if executable('hothasktags') == 1
    " haskell specific keyword settings
    " especially useful for 'hothasktags'
    setl iskeyword=a-z,A-Z,_,.,39

    map <buffer> <F12> :!hothasktags `find . -iname "*.hs"` > tags<CR><CR>
endif
