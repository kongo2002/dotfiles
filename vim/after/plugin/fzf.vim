" bind FZF to <leader>t in case it is loaded
if exists(':Files') == 2 && executable('fzf')
    nmap <silent> <leader>t :Files<CR>
    nmap <silent> <leader>g :GFiles<CR>
    nmap <silent> <leader>bb :Buffers<CR>
endif
