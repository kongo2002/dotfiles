" Vim filetype file
" Filename:     tex.vim
" Author:       Gregor Uhlenheuer
" Last Change:  Tue 11 Jan 2011 10:22:08 PM CET

" turn on syntax-based folding
setlocal foldmethod=syntax

" turn on spellchecking
setlocal spell spelllang=de

" set spellfile
if has('win32') || has ('win64')
    set spellfile=~\vimfiles\spell\de.utf-8.add
else
    set spellfile=~/.vim/spell/de.utf-8.add
endif

" show only the first 10 suggestions
setlocal sps=fast,10

" wrap the text after 80 columns
setlocal textwidth=80

" add umlauts to 'iskeyword'
setlocal iskeyword+=ä,ü,ö,Ä,Ü,Ö,ß

" set compiler/make
compiler tex

" compile and preview
map <buffer> <F6> :make %<CR>:!xdvi %:p:r.dvi &<CR>

" increase linespace in GUI
if has('gui_running')
    setlocal linespace=4
endif

" disable automatic indenting for 'surround.vim'
let b:surround_indent = 0

" define custom 'surround' mapping
if &fenc == 'utf-8'
    let b:surround_34 = "„\r“"
else
    let b:surround_34 = "\"`\r\"'"
endif

let b:surround_45 = "\\\1tex: \1{\r}"

" useful abbreviations
ia <buffer> ... \ldots

if &fenc == 'utf-8'
    ia <buffer> "` „
    ia <buffer> "´ “
endif

" s:launchBibtex - search for bibtex usage {{{
function! s:launchBibtex()
    if executable('bibtex') && search('^\s*\\bibliography{[^}]\+}', 'n') != 0
        silent !bibtex "%:p:r"
        if v:shell_error != 0
            call s:warn('bibtex: There were some errors')
        endif
    endif
endfunction

command! -buffer BibTex call s:launchBibtex()
nmap <buffer> <leader>bt :BibTex<CR>
" }}}

" s:viewPdf - view pdf file {{{
function! s:viewPdf()
    if exists('g:tex_pdf_viewer') && g:tex_pdf_viewer != ''
        let s:viewer = g:tex_pdf_viewer
    endif

    if !exists('s:viewer')
        if has('win32') || has('win64')
            if executable('AcroRd32.exe')
                let s:viewer = 'AcroRd32.exe'
            else
                let s:viewer = ''
            endif
        else
            if executable('evince')
                let s:viewer = 'evince'
            elseif executable('xpdf')
                let s:viewer = 'xpdf'
            else
                let s:viewer = ''
            endif
        endif
    endif

    if s:viewer == '' || !executable(s:viewer)
        call s:warn('No pdf viewer found')
        call s:warn('Set g:tex_pdf_viewer accordingly')
        return
    endif

    let pdfname = expand('%:p:r') . '.pdf'
    if filereadable(pdfname)
        exe 'silent !'.s:viewer.' '.pdfname.' &'
    else
        call s:warn('No pdf found')
    endif
endfunction

command! -buffer ViewPdf call s:viewPdf()
nmap <buffer> <leader>lv :ViewPdf<CR>
" }}}

" s:runPdfLatex - run pdflatex {{{
function! s:runPdfLatex()
    if executable('pdflatex')
        silent !pdflatex -shell-escape -interaction=nonstopmode %
        if v:shell_error != 0
            call s:warn('pdflatex: There were some errors')
        endif
    else
        call s:warn('No pdflatex executable found')
    endif
endfunction

command! -buffer RunPdf call s:runPdfLatex()
nmap <buffer> <leader>ll :RunPdf<CR>
" }}}

" s:viewLog - open tex log {{{
function! s:viewLog()
    let logname = expand('%:t:r') . '.log'
    if filereadable(logname)
        exe 'sp' logname
        nnoremap <buffer> <CR> :bd!<CR>
    else
        call s:warn('No logfile found')
    endif
endfunction

command! -buffer ViewTexLog call s:viewLog()
nmap <buffer> <leader>lo :ViewTexLog<CR>
" }}}

" s:viewErrors - open tex errors {{{
function! s:viewErrors()
    let logname = expand('%:t:r') . '.log'
    if filereadable(logname)
        if executable('latex-errorfilter')
            let errors = system('latex-errorfilter ' . logname)
            if errors != ''
                cgete errors
                copen
            endif
        else
            call s:warn('No latex-errorfilter found')
        endif
    else
        call s:warn('No logfile to parse')
    endif
endfunction

command! -buffer ViewTexErrors call s:viewErrors()
nmap <buffer> <leader>le :ViewTexErrors<CR>
" }}}

" s:warn - helper function {{{
function! s:warn(msg)
    echohl WarningMsg
    echom a:msg
    echohl None
endfunction " }}}
