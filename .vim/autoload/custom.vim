" Vim script file
" Description:  custom file manipulation scripts
" Author:       Gregor Uhlenheuer
" Last Change:  Fri 30 Apr 2010 01:57:06 PM CEST

" convert lines to xml telegrams {{{
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
endfunction " }}}

" substitute umlaut characters {{{
function! custom#PrepareBib()
    let save_reg = getreg('/')

    silent! %s/ä/\"a/gI
    silent! %s/ö/\"o/gI
    silent! %s/ü/\"u/gI
    silent! %s/Ä/\"A/gI
    silent! %s/Ö/\"O/gI
    silent! %s/Ü/\"U/gI
    silent! %s/ß/\"s/gI

    call setreg('/', save_reg)
endfunction " }}}

" prepare tex files before saving {{{
function! custom#PrepareTex()
    let save_reg = getreg('/')

    silent! %s/\s\+\\cite\)/\~\\cite/ge

    silent! %s/\<z\.B\./z.\~B./geI
    silent! %s/\<u\.a\./u.\~a./geI
    silent! %s/\<o\.a\./o.\~a./geI
    silent! %s/\<i\.A\./i.\~A./geI
    silent! %s/\<i\.d\.R\./i.\~d.\~R./geI

    silent! %s/S\.\s*\(\d\+\%(-\d\+\)\=\)/S.\~\1/geI

    call setreg('/', save_reg)
endfunction " }}}

" remove 'IndexedFaceSets' from VRML files {{{
function! custom#CleanVRML()
    let l:id = 0
    normal! gg
    while search('\<VRMLIndexedFaceSet\>', 'e') > 0
        let l:id += 1
        call search('^\s*DEF\>', 'be')
        normal! f{%
        if search(']', 'n', line('.')) > 0
            call setline(line('.')+1, getline(line('.')+1).']')
        endif
        normal! "_d%
        delete _
    endwhile
    silent! %s/,\_s\+]/\r]/
    silent! g/^\s*$/d
    echo l:id . " IndexedFaceSet's removed"
endfunction " }}}

" remove 'VRML*Sets' from VRML files (after confirmation) {{{
function! custom#AnalyzeVRML()
    normal! gg
    while search('\<VRML\S\+Set\>', 'W') > 0
        let l:type = matchstr(getline('.'), '\<VRML\zs\S\+Set\>')
        let l:hitLine = search('^\s*DEF.*{', 'bn')
        let l:hitName = matchstr(getline(l:hitLine), 'DEF \zs\S\+')
        if input('Delete '.l:hitName.' ['.l:type.'] ? ', 'yes') == 'yes'
            call search('^\s*DEF\>', 'be')
            normal! f{%
            if search(']', 'n', line('.')) > 0
                call setline(line('.')+1, getline(line('.')+1).']')
            endif
            normal! "_d%
            delete _
        endif
    endwhile
    silent! %s/,\_s\+]/\r]/
    silent! g/^\s*$/d
endfunction " }}}

" remove given entity from DXF files {{{
function! s:RemoveEntity(entity)
    let l:handles = []
    call cursor(1, 1)
    while search('^  0\ze\n'.a:entity.'$', 'W') > 0
        let l:handle = matchstr(getline(line('.')+3), '^\S\+$')
        call add(l:handles, l:handle)
        let l:hitLine = search('^  0$', 'n') - 1
        exec '.,'.l:hitLine.'delete _'
    endwhile
    return l:handles
endfunction " }}}

" remove several entities from DXF files (-> s:RemoveEntity()) {{{
function! custom#CleanDXF()
    let l:retList = []
    for entity in ['MTEXT', 'DIMENSION', 'TEXT']
        let l:retList += s:RemoveEntity(entity)
    endfor
    for item in l:retList
        call cursor(1, 1)
        while search('^'.item.'$', 'W') > 0
            exec '-1,.delete _'
        endwhile
    endfor
    echo len(l:retList).' entities deleted'
endfunction " }}}
