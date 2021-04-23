let g:slime_no_mappings = 1
xmap <c-c><c-c> <Plug>SlimeRegionSend
nmap <c-c><c-c> <Plug>SlimeParagraphSend
let g:slime_target = "vimterminal"
let g:slime_vimterminal_config = {"term_finish": "close", "vertical": 1}

" see ../after/ftplugin/python_slime.vim
