" Vim script file
" Description:  fetch gentoo package information from gentoo-portage.com
" Author:       Gregor Uhlenheuer
" Filename:     gentoo-info.vim
" Last Change:  Sat 01 May 2010 01:07:03 PM CEST

let g:gentoo_portdir = '/usr/portage'

" list manipulation functions {{{

function! s:removeTill(lines, pattern) " {{{
    let l:index = 0
    for line in a:lines
        if line =~ a:pattern
            call remove(a:lines, 0, l:index)
            break
        endif
        let l:index += 1
    endfor
    return a:lines
endfunction
" }}}

function! s:removeFrom(lines, pattern) " {{{
    let l:index = 0
    for line in a:lines
        if line =~ a:pattern
            call remove(a:lines, l:index, -1)
            break
        endif
        let l:index += 1
    endfor
    return a:lines
endfunction
" }}}

" }}}

function! s:getPortageTree() " {{{
    let l:cat_file = g:gentoo_portdir . '/profiles/categories'
    if filereadable(l:cat_file)
        let s:categories = readfile(g:gentoo_portdir.'/profiles/categories')
    endif
    let s:packages = []
    for category in s:categories
        let l:pack = []
        let l:dir = g:gentoo_portdir.'/'.category
        let l:pack = split(system('find '.l:dir.' -maxdepth 1 -type d'), '\n')
        call remove(l:pack, 0)
        call extend(s:packages, l:pack)
    endfor
    call map(s:packages, 'substitute(v:val, "^.*\\/\\(\\S\\+\\)", "\\1", "")')
    call sort(s:packages)
    let s:portage_loaded = 1
endfunction
" }}}

function! s:getPackage(name) " {{{
    if a:name != ''
        if a:name =~'\S\+\/\S\+'
            return a:name
        endif
        if !exists('s:portage_loaded')
            call s:getPortageTree()
        endif
        for category in s:categories
            if isdirectory(join([g:gentoo_portdir, category, a:name], '/'))
                return category . '/' . a:name
            endif
        endfor
    endif
    return ''
endfunction
" }}}

function! s:fetchInfo(package, mode) " {{{
    let l:mode = (a:mode == 'info') ? '' : '/' . a:mode
    let l:url = 'http://gentoo-portage.com/' . a:package . l:mode
    let l:cmd = 'curl -s -f -S ' . l:url
    return s:cleanUpResult(split(system(l:cmd), '\n'), a:package, a:mode)
endfunction
" }}}

function! s:cleanUpResult(lines, package, mode) " {{{
    if len(a:lines) > 0
        let l:lines = a:lines
        let l:package = substitute(a:package, '.*\/', '', '')

        if a:mode == 'info'
            let l:lines = s:removeTill(l:lines, 'id="contentInner"')
            let l:lines = s:removeFrom(l:lines, 'id="packagetabs"')
        else
            let l:lines = s:removeTill(l:lines, 'id="packagetabs"')
            let l:lines = s:removeFrom(l:lines, 'id="footerContainer"')
            call remove(l:lines, 0, 6)
        endif

        call map(l:lines, 'substitute(v:val, "<br\\/>", "@@", "g")')
        call map(l:lines, 'substitute(v:val, "<[^>]*>", "", "g")')
        call filter(l:lines, 'v:val !~ ''View.*Download''')
        call filter(l:lines, 'v:val !~ ''^\s*$''')
        call filter(l:lines, 'v:val !~ ''Reverse\s\+''')
        call filter(l:lines, 'v:val !~ ''^\s*Screenshots\s*$''')
        call map(l:lines, 'substitute(v:val, "^\\s\\+", "", "")')
        call map(l:lines, 'substitute(v:val, "^\\(Global\\|Local\\)", "\\t\\1", "")')
        call map(l:lines, 'substitute(v:val, "^".l:package, "@@&", "")')

        let l:lines = s:formatHTML(l:lines)
    endif
    return l:lines
endfunction
" }}}

function! s:formatHTML(lines) " {{{
    let l:lines = a:lines

    call map(l:lines, 'substitute(v:val, "&nbsp;", " ", "g")')
    call map(l:lines, 'substitute(v:val, "&lt;", "<", "g")')
    call map(l:lines, 'substitute(v:val, "&gt;", ">", "g")')
    call map(l:lines, 'substitute(v:val, "&amp;", "&", "g")')
    call map(l:lines, 'substitute(v:val, "&copy;", "©", "g")')
    call map(l:lines, 'substitute(v:val, "&reg;", "®", "g")')
    call map(l:lines, 'substitute(v:val, "&quot;", "\"", "g")')

    return l:lines
endfunction
" }}}

function! s:display(lines) " {{{
    split [GentooInfo]
    setl noreadonly modifiable nolist
    call append(0, a:lines)
    sil! %s/@@/\r/ge
    setl nomodified readonly
    nnoremap <buffer> <CR> :bd!<CR>
    call cursor(1, 1)
endfunction
" }}}

function! s:setSyntax(package) " {{{
    let l:pkg = substitute(a:package, '^\S\+\/\(\S\+\).*', '\1', '')
    setl iskeyword+=~
    setl iskeyword+=-

    syntax keyword genIStab alpha amd64 arm hppa ia64 m68k mips ppc ppc64
    syntax keyword genIStab sh sparc sparc-fbsd x86 x86-fbsd ppc-aix
    syntax keyword genIStab x86-freebsd hppa-hpux ia64-hpux x86-interix
    syntax keyword genIStab amd64-linux ia64-linux x86-linux ppc-macos
    syntax keyword genIStab x64-macos x86-macos m68k-mint sparc-solaris
    syntax keyword genIStab sparc64-solaris x64-solaris x86-solaris s390

    syntax keyword genIArch ~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc
    syntax keyword genIArch ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd ~ppc-aix
    syntax keyword genIArch ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix
    syntax keyword genIArch ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos
    syntax keyword genIArch ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris
    syntax keyword genIArch ~sparc64-solaris ~x64-solaris ~x86-solaris ~ppc64
    syntax keyword genIArch ~s390

    syntax keyword genIMask -alpha -amd64 -arm -hppa -ia64 -m68k -mips -ppc
    syntax keyword genIMask -sh -sparc -sparc-fbsd -x86 -x86-fbsd -ppc-aix
    syntax keyword genIMask -x86-freebsd -hppa-hpux -ia64-hpux -x86-interix
    syntax keyword genIMask -amd64-linux -ia64-linux -x86-linux -ppc-macos
    syntax keyword genIMask -x64-macos -x86-macos -m68k-mint -sparc-solaris
    syntax keyword genIMask -sparc64-solaris -x64-solaris -x86-solaris -ppc64
    syntax keyword genIMask -s390

    syntax match genIMask display /Hard\s\+Masked/
    syntax match genIMail display /<[^>]\+@[^>]\+>/
    syntax match genIWWW display /\%(https\?:\/\/\)\?\%(www.\)\?\%([a-zA-Z0-9/_-]\+\.\)*[a-zA-Z0-9/_-]\+\.[a-z]\+\/\?.*/

    exe 'syntax match genIPackage display /.*' . l:pkg . '.*/'

    hi link genIArch Constant
    hi link genIStab PreProc
    hi link genIPackage Statement
    hi link genIMask Identifier
    hi link genIWWW String
    hi link genIMail String
    hi link genIMask Error
    hi link genIUse Type
endfunction
" }}}

function! s:GComplete(A, L, P) " {{{
    let l:arguments = ['info', 'use', 'dep', 'rdep', 'changelog']
    if strpart(a:L, 6) =~ '^\S\+\s\+\w*$'
        return join(l:arguments, "\n")
    endif
    if !exists('s:portage_loaded')
        call s:getPortageTree()
    endif
    return join(s:packages, "\n")
endfunction
" }}}

function! GentooInfo(...) " {{{
    if a:0 < 1
        echohl ErrorMsg
        echo "Usage: GentooInfo <package> [mode]"
        echohl None
        return
    endif
    let l:package = s:getPackage(a:1)
    if l:package == ''
        echohl ErrorMsg
        echo 'Package "' . a:1 . '" not found'
        echohl None
        return
    endif
    if a:0 < 2
        call s:display(s:fetchInfo(l:package, 'info'))
    else
        call s:display(s:fetchInfo(l:package, a:2))
    endif
    call s:setSyntax(l:package)
endfunction
" }}}

com! -complete=custom,s:GComplete -nargs=+ GInfo call GentooInfo(<f-args>)
