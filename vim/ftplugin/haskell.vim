" Vim filetype file
" Filename:     haskell.vim
" Maintainer:   Gregor Uhlenheuer
" Last Change:  Fri 29 Nov 2013 09:31:48 PM CET

" activate omni completion via neco-ghc
setl omnifunc=necoghc#omnifunc

" custom tab settings
setl expandtab
setl shiftwidth=2
setl softtabstop=2

" default to 80 character lines
setl textwidth=80
