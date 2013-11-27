" Vim filetype file
" Filename:     uzbl.vim
" Maintainer:   Gregor Uhlenheuer
" Last Change:  Tue 13 Apr 2010 02:59:19 PM CEST
"
" Custom configuration:
"
"   Set 'g:uzbl_prefix' to the path prefix uzbl is installed in. The
"   default is set to '/usr/local'
"
"       let g:uzbl_prefix = '/usr/local'
"
"   Set 'g:uzbl_resize_on_diff' if you want the vim window to be
"   resized on a diffsplit:
"
"       let g:uzbl_resize_on_diff = 1
"
" Defined mappings:
"
"   <Leader>uc      Test current config with uzbl-core
"   <Leader>ub      Test current config with uzbl-browser
"   <Leader>ud      Diff current config with default uzbl config

if exists('b:did_ftplugin')
  finish
endif

if !exists('g:uzbl_prefix')
    let g:uzbl_prefix = '/usr/local'
endif

let b:did_ftplugin = 1

" enable syntax based folding
setlocal foldmethod=syntax

" correctly format comments
setlocal formatoptions=croql
setlocal comments=:#
setlocal commentstring=#%s

" config testing map for 'uzbl-core'
if executable('uzbl-core')
    com! -buffer UzblCoreTest !uzbl-core -c %
    nmap <buffer> <Leader>uc :UzblCoreTest<CR>
endif

" config testing map for 'uzbl-browser'
if executable('uzbl-browser')
    com! -buffer UzblBrowserTest !uzbl-browser -c %
    nmap <buffer> <Leader>ub :UzblBrowserTest<CR>
endif

" Compare/Diff current config with the default config file
if !exists('*CompareUzblConfig')
    function! CompareUzblConfig()
        let def_config = g:uzbl_prefix . '/share/uzbl/examples/config/config'

        if filereadable(def_config)
            if exists('g:uzbl_resize_on_diff') && g:uzbl_resize_on_diff
                set columns=160
            endif
            exe 'vert diffsplit ' . def_config
            wincmd p
        else
            echohl WarningMsg
            echom 'Could not find default uzbl config (set g:uzbl_prefix)'
            echohl None
        endif
    endfunction
endif

com! -buffer UzblDiffConf call CompareUzblConfig()
nmap <buffer> <Leader>ud :UzblDiffConf<CR>
