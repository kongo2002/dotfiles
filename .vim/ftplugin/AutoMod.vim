" Vim filetype file
" Filename:     AutoMod.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Fr 27 Nov 2009 00:57:20 CET

" enable syntax based folding
setlocal foldmethod=syntax

" use literal tabs
setlocal noexpandtab

" do not show non printable characters
setlocal nolist

" add some AutoMod specific words for matchit.vim
let b:match_words = '\<begin\>:\<end\>,'
                \ . '\%(else\s\+\)\@<!if\>:'   " if not preceded by else
                \ . '\%(\<else\s\+\)\@<=if\>:' " else followed by if
                \ . '\<else\%(\s\+if\)\@!'     " else not followed by if
