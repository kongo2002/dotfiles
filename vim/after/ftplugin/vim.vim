" Vim filetype file
" Filename:     vim.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Fri 30 Apr 2010 01:53:32 PM CEST

function! s:MakeFoldMarker(first, last)
    let fline = getline(a:first)
    let lline = getline(a:last)

    if match(fline, '^\s*$') != -1
        let append = '" {{{'
    elseif match(fline, '\%("[^"]\+"\)*[^"]*"[^"]*$') != -1
        let append = ' {{{'
    else
        let append = ' " {{{'
    endif

    call setline(a:first, fline . append)

    if match(lline, '^\s*$') != -1
        let append = '" }}}'
    elseif match(lline, '\%("[^"]\+"\)*[^"]*"[^"]*$') != -1
        let append = ' }}}'
    else
        let append = ' " }}}'
    endif

    call setline(a:last, lline . append)
endfunction

command! -buffer -range=% MakeFold call s:MakeFoldMarker(<line1>, <line2>)
map <buffer> <leader>mf :MakeFold<CR>
