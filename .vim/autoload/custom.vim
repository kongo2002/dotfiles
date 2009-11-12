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

function! custom#CleanTex()
    silent! %s/ä/\"a/gI
    silent! %s/ö/\"o/gI
    silent! %s/ü/\"u/gI
    silent! %s/Ä/\"A/gI
    silent! %s/Ö/\"O/gI
    silent! %s/Ü/\"U/gI
    silent! %s/ß/\"s/gI
endfunction

function! custom#CleanDXF()
    let id = 0
    normal gg
    while search('\<VRMLIndexedFaceSet\>', 'e') > 0
        let id += 1
        call search('^\s*DEF\>', 'be')
        normal f{%
        if search(']', 'n', line(".")) > 0
            call setline(line('.')+1, getline(line('.')+1).']')
        endif
        normal d%dd
    endwhile
    silent! %s/,\_s\+]/\r]/
    silent! g/^\s*$/d
    echo id . " IndexedFaceSet's removed"
endfunction
