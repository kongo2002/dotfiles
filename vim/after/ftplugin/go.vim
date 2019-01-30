" Go filetype file
" Filename:     go.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Wed 30 Jan 2019 05:33:09 PM CET

" go specific tab settings
" sadly gofmt encourages tab-indentation...
setlocal tabstop=2 noet sts=2 sw=2

" some useful command mappings
nnoremap <buffer> <leader>d :GoDoc<CR>
nnoremap <buffer> <leader>i :GoInfo<CR>
nnoremap <buffer> <leader>l :GoLint<CR>
