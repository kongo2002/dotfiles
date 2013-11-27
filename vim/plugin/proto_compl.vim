" File:           proto_compl.vim
" Maintainer:     Gregor Uhlenheuer
" Last Change:    Thu 29 Jul 2010 08:52:34 PM CEST
"
" Description:    a small prototype completion plugin for c/c++ heavily
"                 inspired by code_complete.vim written by Ming Bai
"
" Installation:   - add the following line to your c/cpp ftplugin file:
"
"                   call ProtoComplInit()
"
"                 - or add the following line to your .vimrc:
"
"                   autocmd! FileType c,cpp call ProtoComplInit()
"
" Configuration:  The completion key is defaulted to CTRL-K in insert mode
"                 but you can easily configure it by setting the
"                 'g:proto_compl_key' variable in your .vimrc like this:
"
"                   let g:proto_compl_key = '<CTRL-L>'


if exists('g:loaded_proto_compl') || &cp || version < 700
    finish
endif
let g:loaded_proto_compl = 1

function! ProtoComplInit()
    if !exists('g:proto_compl_key')
        let g:proto_compl_key = '<C-k>'
    endif

    if !exists('s:sig_list')
        let s:sig_list = []
    endif

    exec 'silent! iunmap <buffer> ' . g:proto_compl_key
    exec 'inoremap <buffer> ' . g:proto_compl_key .
                \ ' <C-r>=ProtoComplete()<CR>' .
                \ '<C-r>=ProtoJump()<CR>'

    if !exists('g:proto_no_auto_newline') || g:proto_no_auto_newline == 0
        inoremap <buffer> <expr> ; <SID>DoNewline()
    endif
endfunction

function s:ProtoFunComplete(funn)
    let s:sig_list = []
    let sig_words = []
    let tags = taglist('^' . a:funn . '$')

    if len(tags) > 0

        if exists('g:proto_compl_debug') && g:proto_compl_debug
            for item in tags
                echom string(item)
            endfor
        endif

        " filter unappropriate results
        call filter(tags, 'has_key(v:val, "kind")')
        call filter(tags, 'has_key(v:val, "name")')
        call filter(tags, 'has_key(v:val, "signature")')
        call filter(tags, 'v:val.kind == "p" || v:val.kind == "f"')
        call filter(tags, 'v:val.name == "'.a:funn.'"')
        call filter(tags, 'v:val["signature"] !~ "(\\s*\\(void\\)\\=\\s*)"')

        call map(tags, 's:GSubM(v:val, "signature", "\\(\\s*,\\s*\\)", "´>\\1`<")')
        call map(tags, 's:GSubM(v:val, "signature", ")[^)]\\+$", ")")')
        call map(tags, 's:GSubM(v:val, "signature", "^[^(]\\+(", "(")')
        call map(tags, 's:GSubM(v:val, "signature", "(\\(.*\\))", "`<\\1´>")')

        let bracket = s:ClosBrack() ? '' : ')'

        " populate signature list
        for item in tags
            if item["signature"] != ''
                if index(sig_words, item["signature"]) == -1
                    let sig_words += [item["signature"]]
                    let sig = {}
                    let sig['word'] = item["signature"] . bracket
                    let sig['menu'] = item["filename"]
                    let s:sig_list += [sig]
                endif
            endif
        endfor

        if exists('g:proto_compl_debug') && g:proto_compl_debug
            for item in s:sig_list
                echom item["word"] . ' [' . item["menu"] . ']'
            endfor
        endif

        if s:sig_list == [] | return '' | endif

        if len(s:sig_list) == 1
            return s:sig_list[0]['word']
        else
            call complete(col('.'), s:sig_list)
            return ''
        endif

    endif

    return ''
endfunction

function ProtoJump()
    if len(s:sig_list) > 1
        let s:sig_list = []
        if pumvisible()
            return "\<down>\<up>"
        else
            return "\<C-p>"
        endif
    endif

    if match(getline('.'), '`<.*´>') != -1 || search('`<.\{-}´>') != 0
        norm! 0
        call search('`<', 'c', line('.'))
        norm! v
        call search('´>', 'e', line('.'))

        if &selection == 'exclusive'
            norm! l
        endif
        return "\<C-\>\<C-n>gvo\<C-g>"
    endif

    return ''
endfunction

function! s:DoNewline()
    let l:line = getline('.')[:(col('.')-2)]
    if match(l:line, '([^)]*$') != -1 || synIDattr(synID(line('.'),
                \ col('.')-1, 1), 'name') =~? 'cComment'
        return ";"
    else
        return ";\<CR>"
    endif
endfunction

function! s:ClosBrack()
    let l:line = getline('.')[col('.')-2:]
    if match(l:line, '^\s*(\s*)') != -1
        return 1
    endif
    return 0
endfunction

function! s:GSubM(item, member, pat, sub)
    let a:item[a:member] = substitute(a:item[a:member], a:pat, a:sub, 'g')
    return a:item
endfunction

function! ProtoComplete()
    let l:line = getline('.')[:(col('.')-2)]
    let l:funn = matchstr(l:line, '\w*\ze\s*(\s*$')

    if l:funn != ''
        return s:ProtoFunComplete(l:funn)
    endif
    return ''
endfunction
