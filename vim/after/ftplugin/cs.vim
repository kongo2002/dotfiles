" Vim filetype file
" Filename:     cs.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Fri 16 May 2014 10:56:53 PM CEST

" enable syntax based folding
setl foldmethod=syntax

" disable list mode
setl nolist

" set default tabstop to 4
setl tabstop=4

" build C# specific tags file
map <buffer> <F12> :sil !ctags -R --c-kinds=+lp --fields=+iaS --extra=+q --language-force=C\# .<CR>

" asynchronously build using vim-dispatch
nnoremap <buffer> <F5> :OmniSharpBuildAsync<CR>

" various mappings of OmniSharp
nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
nnoremap <buffer> <leader>fi :OmniSharpFindImplementation<CR>
nnoremap <buffer> <leader>ft :OmniSharpFindType<CR>
nnoremap <buffer> <leader>fs :OmniSharpFindSymbol<CR>
nnoremap <buffer> <leader>fu :OmniSharpFindUsages<CR>
nnoremap <buffer> <leader>fm :OmniSharpFindMembers<CR>
nnoremap <buffer> <leader>fx :OmniSharpFixIssue<CR>
nnoremap <buffer> <leader>fl :OmniSharpTypeLookup<CR>
nnoremap <buffer> <leader>fd :OmniSharpDocumentation<CR>

" reload solution (useful after switching branches)
nnoremap <buffer> <leader>rl :OmniSharpReloadSolution<CR>
