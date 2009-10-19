" AutoMod indent file
" Language:     AutoMod
" Maintainer:   Gregor Uhlenheuer
" Last Change:  2009 05 09

" check for other indent file
if exists("b:did_indent")
    finish
endif

let b:did_indent = 1

setlocal indentexpr=GetAutoModIndent(v:lnum)
setlocal indentkeys+==end,=else,=until,=begin,=order

function! GetAutoModIndent( line_num )

    if a:line_num == 1
        return 0
    endif

    let this_line = getline( a:line_num )

    let prev_line_num = prevnonblank( a:line_num - 1 )
    let prev_line = getline( prev_line_num )
    let indnt = indent( prev_line_num )

    " function and procedure definition
    if this_line =~ '^\s*begin\s*.*\s\(function|procedure\)\>'
        return 0
    endif

    " if
    if prev_line =~ '\(^\s*\(do\|while\|for\|else\)\>\)\|\(\<then\>\)'
        let indnt = indnt + &shiftwidth

        if this_line =~ '^\s*begin\>'
            let indnt = indnt - &shiftwidth
        endif

        return indnt
    endif

    " begin
    if prev_line =~ '^\s*begin\>'
        return indnt + &shiftwidth
    endif

    " order/backorder
    if this_line =~ '^\s*in\s\+case\>' && prev_line =~ '^\s*order\>'
        return indnt + &shiftwidth
    endif

    " unindent
    if this_line =~ '^\s*end\>'
        let indnt = indnt - &shiftwidth

        if getline( prev_line_num-1 ) =~ '^\s*else\s*$'
            let indnt = indnt - &shiftwidth
        endif

        return indnt
    endif

    " backorder unindent
    if prev_line =~ '^\s*in\s\+case\>'
        return indnt - &shiftwidth
    endif

    " until
    if this_line =~ '^\s*until\>' && prev_line !~ '^\s*end\>'
        return indnt - &shiftwidth
    endif

    " else
    if this_line =~ '^\s*else\>' && prev_line !~ '^\s*end\>'
        return indnt - &shiftwidth
    endif

    if this_line !~ '^\s*end\>' && getline( prev_line_num-1 ) =~ '^\s*else\s*$'
        return indnt - &shiftwidth
    endif

    " if (short version)
    if this_line !~ '^\s*\(end\|else\)\>' && prev_line !~ '^\s*begin\>' && getline( prev_line_num-1 ) =~ '\(^\s*\(do\|while\|for\)\>\)\|\(\<then\>\)' && getline( prev_line_num-1 ) !~ 'begin\s*$'
        return indnt - &shiftwidth
    endif

    return indnt

endfunction
