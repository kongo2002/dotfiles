" Go filetype file
" Filename:     go.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Mon 04 Dec 2023 10:30:26 PM CET

" go specific tab settings
" sadly gofmt encourages tab-indentation...
setlocal tabstop=2 noet sts=2 sw=2

" some useful command mappings
nnoremap <buffer> <leader>of :GoAlternate<CR>
