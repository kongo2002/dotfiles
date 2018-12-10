" bind FZF to <leader>t in case it is loaded
if exists(':FZF') == 2 && executable('fzf')
    nmap <silent> <leader>t :FZF<CR>
endif
