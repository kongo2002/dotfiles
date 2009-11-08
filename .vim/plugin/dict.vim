" Name:         dict.vim
" Author:       Gregor Uhlenheuer
" Last Change:  So 08 Nov 2009 18:30:21 CET

if exists('g:loaded_dict')
    finish
endif

let g:dict_url = 'http://www.dict.org/bin/Dict?Form=Dict2&Query='
let g:dict_query = '&Strategy=*&Database=*'

function! GetDictEntries(term)
    " get results
    let cmd = "curl -s -f -S '".g:dict_url.a:term.g:dict_query."'"
    let result = split(system(cmd), '\n')

    " put results in a new split window
    split [DictResults]
    resize 10
    setl modifiable
    setl noreadonly
    call append(0, result)

    " clean up
    %s/<\/\?[^>]\+>//g
    %s/^\s*\n\s*\n/\r/e
    g/definitions\? found/normal k$dgg
    g/Questions or comments/normal 2k0dG

    " make it look nice
    call append(0, [ "================================================",
                   \ "Dictionary Results",
                   \ "================================================",
                   \ ""])

    " positive search result
    if search('\d\+ definitions\? found', 'n') != 0
        %s/\(\d\+\s\+definitions\?\)\_.\{-}for\s\+\(\w\+\)/\1 found for "\2"/
        1,4 center 60

    " no search results
    else
        g/No definitions found/normal jdG0f,D
        1,$ center 60
    endif

    " set syntax colors
    syntax match dictTitleSep /=\+/
    syntax match dictTitle /Dictionary Results/
    syntax match dictSearchEngine /^From \zs.*$/
    syntax match dictFound /\%(\d\+\|No\) definitions\? found for .*$/ transparent contains=dictTermFound,dictNumberFound
    syntax match dictTermFound /".*"/ contained
    syntax match dictNumberFound /\d\+/ contained
    syntax match dictListNumber /^\s*\d\+[.:]/
    syntax match dictSrc /^\s*\[.*\]\s*$/
    syntax match dictThes /\d\+ Moby Thesaurus.*:/ transparent contains=dictThesNumber,dictThesTerm
    syntax match dictThesNumber /\d\+/ contained
    syntax match dictThesTerm /".*"/ contained
    syntax match dictCite /--.*\./
    hi link dictTitleSep PreProc
    hi link dictTitle PreProc
    hi link dictSearchEngine Type
    hi link dictNumberFound Constant
    hi link dictTermFound String
    hi link dictListNumber Constant
    hi link dictSrc Comment
    hi link dictCite Comment
    hi link dictThesNumber Constant
    hi link dictThesTerm String

    " set buffer flags
    setl nomodified
    setl nomodifiable
    setl readonly

    " make it close easily
    map <buffer> <Return> :bd!<CR>

endfunction

command! -nargs=1 DictLookup call GetDictEntries("<args>")
nmap <C-k> :call GetDictEntries(expand("<cword>"))<CR>

let g:loaded_dict = 1
