" Author: Gregor Uhlenheuer
" Last Change: Fr 13 Nov 2009 23:41:17 CET

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

function! custom#CleanVRML()
    let l:id = 0
    normal gg
    while search('\<VRMLIndexedFaceSet\>', 'e') > 0
        let l:id += 1
        call search('^\s*DEF\>', 'be')
        normal f{%
        if search(']', 'n', line('.')) > 0
            call setline(line('.')+1, getline(line('.')+1).']')
        endif
        normal "_d%
        delete _
    endwhile
    silent! %s/,\_s\+]/\r]/
    silent! g/^\s*$/d
    echo l:id . " IndexedFaceSet's removed"
endfunction

function! custom#AnalyzeVRML()
    normal gg
    while search('\<VRML\S\+Set\>', 'W') > 0
        let l:type = matchstr(getline('.'), '\<VRML\zs\S\+Set\>')
        let l:hitLine = search('^\s*DEF.*{', 'bn')
        let l:hitName = matchstr(getline(l:hitLine), 'DEF \zs\S\+')
        if input('Delete '.l:hitName.' ['.l:type.'] ? ', 'yes') == 'yes'
            call search('^\s*DEF\>', 'be')
            normal f{%
            if search(']', 'n', line(".")) > 0
                call setline(line('.')+1, getline(line('.')+1).']')
            endif
            normal "_d%
            delete _
        endif
    endwhile
    silent! %s/,\_s\+]/\r]/
    silent! g/^\s*$/d
endfunction

function! custom#DeleteTextInDXF()
    let l:object = 0
    let l:lines = 0
    let l:handles = []
    call cursor(1, 1)
    " delete text objects
    while search('^  0\ze\nM\?TEXT$', '') > 0
        let l:handle = matchstr(getline(line('.')+3), '^\S\+$')
        call add(l:handles, l:handle)
        let l:hitLine = search('^  0$', 'n') - 1
        exec '.,'.l:hitLine.'delete _'
        let l:object += 1
        let l:lines += l:hitLine - line('.')
    endwhile
    " delete dimension objects
    while search('^  0\ze\nDIMENSION$', '') > 0
        let l:handle = matchstr(getline(line('.')+3), '^\S\+$')
        call add(l:handles, l:handle)
        let l:hitLine = search('^  0$', 'n') - 1
        exec '.,'.l:hitLine.'delete _'
        let l:object += 1
        let l:lines += l:hitLine - line('.')
    endwhile
    " delete back references in blocks
    for item in l:handles
        while search('^'.item.'$') > 0
            exec '-1,.delete _'
        endif
    endfor
    echo l:object.' entities deleted ['.l:lines.' lines]'
endfunction
