" NERD COMMENTER
let g:NERDCreateDefaultMappings = 0
" TODO 複数のファイルタイプを行ったり来たりするときスペースの数がおかしくなる
augroup spacedelim
  autocmd!
  autocmd FileType * let NERDSpaceDelims = 1
  autocmd FileType python let NERDSpaceDelims = 0
augroup END
nmap <Leader>cc <Plug>NERDCommenterToggle
vmap <Leader>cc <Plug>NERDCommenterToggle
nmap <Leader>ca <Plug>NERDCommenterAppend

