if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet if if ".st."condition".et." then<CR>begin<CR>".st.et."<CR>end<CR> ".st.et
exec "Snippet ifelse if ".st."condition".et." then<CR>begin<CR>".st.et."<CR>end<CR>else<CR>begin<CR>".st.et."<CR>end<CR> ".st.et
exec "Snippet while while ".st."condition".et." do<CR>begin<CR>".st.et."<CR>end<CR> ".st.et
exec "Snippet startproc /*******************************************************************************<CR>Name: ".st."name".et."\t\tTyp: Procedure\t{{{1<CR><CR>Beschreibung:\t".st."comment".et."<CR>*******************************************************************************/<CR>begin ".st."name".et." arriving procedure<CR><CR>".st.et."<CR><CR>end\t/* }}}1 */<CR>"
exec "Snippet startsub /*******************************************************************************<CR>Name: ".st."name".et."\t\tTyp: Subroutine\t {{{1<CR><CR>Beschreibung:\t".st."comment".et."<CR>*******************************************************************************/<CR>begin ".st."name".et." procedure<CR><CR>".st.et."<CR><CR>end\t/* }}}1 */<CR>"
exec "Snippet startfunc /*******************************************************************************<CR>Name: ".st."name".et."\t\tTyp: Function\t{{{1<CR><CR>Parameter: ".st."parameters".et."<CR>Rueckgabe: ".st."return".et."<CR><CR>Beschreibung:\t".st."comment".et."<CR>*******************************************************************************/<CR>begin ".st."name".et." function<CR><CR>".st.et."<CR><CR>end\t/* }}}1 */<CR>"
