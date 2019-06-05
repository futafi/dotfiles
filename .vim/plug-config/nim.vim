augroup Nim
  autocmd!
  autocmd BufRead,BufNewFile *.nim nnoremap <M-g> :call JumpToDef()<cr>
  autocmd BufRead,BufNewFile *.nim inoremap <M-g> <esc>:call JumpToDef()<cr>i
augroup END

fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

