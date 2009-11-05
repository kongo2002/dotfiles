" turn on spellchecking
setlocal spell spelllang=de

" show only the first 10 suggestions
setlocal sps=fast,10

" wrap the text after 80 columns
setlocal textwidth=80

" compile and preview
map <buffer> <F6> :w<CR><Leader>ll<Leader>lv

" set spell error color for non-gui vim
if !has("gui_running")
    hi SpellBad ctermfg=0 ctermbg=1
endif
