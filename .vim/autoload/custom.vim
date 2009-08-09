" Author: Gregor Uhlenheuer
" Last Change: Aug 04, 2009

function! custom#Telegram(...) range
    let lnum = a:firstline
    let id = 1
    if lnum > 1
        let line = getline(lnum-1)
        if match(line, '<item\s\+id="\(\d\+\)"') != -1
            let id = substitute(line, '<item\s\+id="\(\d\+\)".*', '\1', '')
            let id += 1
        endif
    endif
    while lnum <= a:lastline
        let line = getline(lnum)
        if a:0 > 0
            let line = substitute(line, '\(.*\)\s\+\(\d\+\)$', '<item id="'.id.'" len="\2" desc="\1"></item>', '')
        else
            let line = substitute(line, '\(.*\)$', '<item id="'.id.'" len="1" desc="\1"></item>', '')
        endif
        call setline(lnum, line)
        let id += 1
        let lnum += 1
    endwhile
endfunction
