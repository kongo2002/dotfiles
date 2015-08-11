XPTemplate priority=personal

XPTvar $BRif ' '
XPTvar $BRel \n
XPTvar $BRloop ' '
XPTvar $BRfun ' '

XPTinclude
    \ _common/personal
    \ java/java

let s:f = g:XPTfuncs()

function! s:f.classname(...)
    return expand('%:t:r')
endfunction

function! s:f.currentDir(...)
    return expand('%:p:h:t')
endfunction

function! s:f.getPackageForFile(...)
    let dir = expand('%:p:h')

    let folders = [
        \ '/src/main/scala',
        \ '/src/test/scala',
        \ '/src/multi-jvm/scala',
        \ '/src/it/scala',
        \ '/test/scala'
    \ ]

    for d in folders
        let idx = match(dir, d)
        if idx != -1
            let subdir = strpart(dir, idx + strlen(d) + 1)
            let package = substitute(subdir, '/', '.', 'g')
            return package
        endif
    endfor

    return ''
endfunction

function! s:f.packageLine(...)
    let pkg = s:f.getPackageForFile()
    if pkg != ''
        return 'package ' . pkg
    endif
    return ''
endfunction

function! s:f.packageWithFile(...)
    let pkg = s:f.getPackageForFile()
    let cls = s:f.classname()
    if pkg != ''
        return pkg . '.' . cls
    endif
    return cls
endfunction

XPT akkaimp hint=basic\ akka\ imports
import akka.actor.{Actor, ActorRef, ActorSystem, Props}

XPT file hint=default\ scala\ file\ header
/*
 * `packageWithFile()^
 *
 * Copyright © `year()^ `$author^ <`$email^>
 */
`packageLine()^
`cursor^
