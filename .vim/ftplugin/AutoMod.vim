" Vim filetype file
" Filename:     AutoMod.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Fr 27 Nov 2009 01:20:23 CET

" enable syntax based folding
setlocal foldmethod=syntax

" use literal tabs
setlocal noexpandtab

" do not show non printable characters
setlocal nolist

" add some AutoMod specific words for matchit.vim
let b:match_words = '\<begin\>:\<end\>,'
                \ . '\%(else\s\+\)\@<!if\>:'
                \ . '\%(\<else\s\+\)\@<=if\>:'
                \ . '\<else\%(\s\+if\)\@!'
