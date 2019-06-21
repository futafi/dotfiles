" make test commands execute using dispatch.vim
" let test#strategy = "basic"
let test#strategy = "vimterminal"
let test#vim#term_position = "vertical"

augroup vim-test
  autocmd!
  autocmd BufRead,BufNewFile test_* 
        \let test#project_root = expand("%:p:h") . '/..'
augroup END

