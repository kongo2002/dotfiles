" AutoMod indent file
" Language:     AutoMod
" Maintainer:   Gregor Uhlenheuer
" Last Change:  Mi 23 Dez 2009 19:10:03 CET

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

let b:indent_use_syntax = has("syntax")

setlocal indentexpr=GetAutoModIndent()
setlocal indentkeys+==end,=else,=until,=begin,=order,=choice

if exists("*GetAutoModIndent")
    finish
endif

function s:PrevNonCNum(step)

    let line = v:lnum
    let step = a:step

    if b:indent_use_syntax != 1
        while step > 0 && line > 0
            if prevnonblank(line-1)
                let line = prevnonblank(line-1)
            else
                return getline(1)
            endif
            let step -= 1
        endwhile
    else
        while step > 0 && line > 0
            let jump = 1
            let csynid = synIDattr(synID(line-jump, indent(line-jump)+1, 0), "name")
            while ((line-jump) > 0 && (getline(line-jump) =~ '^\s*$' || csynid =~ "mComment"))
                let jump += 1
                let csynid = synIDattr(synID(line-jump, indent(line-jump)+1, 0), "name")
            endwhile
            let line -= jump
            let step -= 1
        endwhile
    endif

    return line
endfunction

function s:PrevNonCLine(step)

    return getline(s:PrevNonCNum(a:step))

endfunction

function GetAutoModIndent()

    let cline = getline(v:lnum)

    if v:lnum = 1
        return 0
    endif

    let indnt = indent(s:PrevNonCNum(1))

    " function and procedure definition
    if cline =~ '^\s*begin\s*.*\s\(function\|procedure\)\>'
        return 0
    endif

    " comments
    if synIDattr(synID(v:lnum, indnt+1, 0), "name") = "mComment"
        return indnt
    endif

    " if, do, while, for, else
    if s:PrevNonCLine(1) =~ '\(^\s*\(do\|while\|for\|else\)\>\)\|\(\<then\>\)'
        let indnt = indnt + &shiftwidth

        if cline =~ '^\s*begin\>'
            let indnt = indnt - &shiftwidth
        endif

        return indnt
    endif

    " begin
    if s:PrevNonCLine(1) =~ '^\s*begin\>'
        return indnt + &shiftwidth
    endif

    " order/backorder
    if cline =~ '^\s*in\s\+case\>' && s:PrevNonCLine(1) =~ '^\s*order\>'
        return indnt + &shiftwidth
    endif

    " choose/save choice as
    if cline =~ '^\s*save\s\+choice\>' && s:PrevNonCLine(1) =~ '^\s*choose\>'
        return indnt + &shiftwidth
    endif

    " backorder unindent
    if s:PrevNonCLine(1) =~ '^\s*in\s\+case\>'
        let indnt -= &sw
    endif

    " save choice unindent
    if s:PrevNonCLine(1) =~ '^\s*save\s\+choice\>'
        let indnt -= &sw
    endif

    " end unindent
    if cline =~ '^\s*end\>'
        let indnt = indnt - &shiftwidth

        if s:PrevNonCLine(2) =~ '^\s*else\s*$'
            let indnt = indnt - &shiftwidth
        endif

        if s:PrevNonCLine(2) =~ '^\s*if\>.*\<then\>\s*$'
            let indnt -= &sw
        endif

        return indnt
    endif

    " until unindent
    if cline =~ '^\s*until\>' && s:PrevNonCLine(1) !~ '^\s*end\>'
        return indnt - &shiftwidth
    endif

    " else unindent
    if cline =~ '^\s*else\>' && s:PrevNonCLine(1) !~ '^\s*end\>'
        return indnt - &shiftwidth
    endif

    " remaining unindentation
    if s:PrevNonCLine(2) =~ '^\s*else\s*$'
        return indnt - &shiftwidth
    endif

    if s:PrevNonCLine(1) !~ '^\s*begin\>' && s:PrevNonCLine(2) !~ 'begin\s*$'
        if s:PrevNonCLine(2) =~ '\(^\s*\(do\|while\|for\)\>\)\|\(\<then\>\)'
            return indnt - &shiftwidth
        endif
    endif

    return indnt

endfunction
