" NERD COMMENTER
let g:NERDCreateDefaultMappings = 0
" let g:NERDAltDelims_c = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
" TODO 複数のファイルタイプを行ったり来たりするときスペースの数がおかしくなる
augroup spacedelim
  autocmd!
  autocmd FileType * let NERDSpaceDelims = 1
  autocmd FileType python let NERDSpaceDelims = 0
augroup END
nmap <Leader>cc <Plug>NERDCommenterToggle
vmap <Leader>cc <Plug>NERDCommenterToggle
nmap <Leader>ca <Plug>NERDCommenterAppend
vmap <Leader>cs <Plug>NERDCommenterSexy
