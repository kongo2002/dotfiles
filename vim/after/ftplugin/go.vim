" Go filetype file
" Filename:     go.vim
" Author:       Gregor Uhlenheuer

" go specific tab settings
" sadly gofmt encourages tab-indentation...
setlocal tabstop=2 noet sts=2 sw=2

" some useful command mappings
nnoremap <buffer> <leader>of :GoAlt<CR>
