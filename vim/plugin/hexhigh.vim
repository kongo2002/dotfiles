" plugin to highlight hex colors (gvim only)
" File:         hexhigh.vim
" Maintainer:   Gregor Uhlenheuer
" Last Change:  Sa 30 Jan 2010 17:19:03 CET

if exists('g:loaded_hexhigh') || !has('gui_running')
    finish
endif
let g:loaded_hexhigh = 1

function! s:HexHigh()

    if !exists('b:Hex_colored')
        let b:Hex_colored = 0
    endif
    if !exists('b:Hex_colors')
        let b:Hex_colors = {}
    endif

    if b:Hex_colored == 0
        let l:hex_group = 4
        let l:line_nr = 1

        " search file for hex color codes
        while l:line_nr <= line('$')
            let l:hex_line_match = 1
            let l:line = getline(l:line_nr)

            " check for multiple matches in one line
            while match(l:line, '#\x\{6}\|#\x\{3}', 0, l:hex_line_match) != -1
                let l:hex_match = matchstr(l:line, '#\x\{6}\|#\x\{3}', 0,
                            \ l:hex_line_match)
                let l:hex_match = toupper(l:hex_match)
                if !has_key(b:Hex_colors, l:hex_match)
                    exe 'let b:Hex_colors["'.l:hex_match.'"] = '.l:hex_group
                    let l:hex_group += 1
                endif
                let l:hex_line_match += 1
            endwhile

            let l:line_nr += 1
        endwhile

        " highlight all found colors
        for hcolor in keys(b:Hex_colors)
            let l:name = strpart(hcolor, 1)
            let l:color = s:GetHex(hcolor)
            exe 'hi HexCol'.l:name.' guifg='.l:color.' gui=reverse'
            exe 'let l:m = matchadd("HexCol'.l:name.'", "'.s:GetMatch(hcolor).'", 15)'
            let b:Hex_colors[hcolor] = l:m
        endfor

        let b:Hex_colored = 1
        echo 'hexhigh'
    else
        " remove all defined color matches
        for hcolor in keys(b:Hex_colors)
            let l:name = strpart(hcolor, 1)
            let l:id = get(b:Hex_colors, hcolor)
            exe 'hi clear HexCol' . l:name
            call matchdelete(l:id)
        endfor

        let b:Hex_colors = {}
        let b:Hex_colored = 0
        echo 'nohexhigh'
    endif

endfunction

function! s:GetHex(hexcode)
    if strlen(a:hexcode) == 7
        return a:hexcode
    endif
    return substitute(a:hexcode, '\x', '\U&&', 'g')
endfunction

function! s:GetMatch(hexcode)
    return substitute(a:hexcode, '[a-fA-F]', '[\L&\U&]', 'g')
endfunction

command! HexHighToggle call s:HexHigh()
noremap <Leader><F4> :HexHighToggle<CR>
