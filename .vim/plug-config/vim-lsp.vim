let g:asyncomplete_enable_for_all = 0
let g:asyncomplete_auto_popup = 0
" Enables echo of diagnostic error for the current line to status.
let g:lsp_diagnostics_echo_cursor = 1
" Enables signs for diagnostics.
let g:lsp_signs_enabled = 1
" Enables highlighting of diagnostics.
let g:lsp_textprop_enabled = 1
" color setting is in ~/.vim/rc/color.vim

command LSDiagnostics LspDocumentDiagnostics
command LSFormat LspDocumentFormat
command LSHover LspHover
command LSDef LspDefinition
command LSTDef LspTypeDefinition
command LSSig LspSignatureHelp

augroup vimlsp
  autocmd!
  autocmd BufRead,BufNewFile *.nim set filetype=nim
  autocmd FileType python,go,vim,nim,git,snippet call asyncomplete#enable_for_buffer()
augroup END

augroup vimlsp
  autocmd!
  if executable('pyls')
    " pip install python-language-server
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'whitelist': ['python'],
          \ })
    autocmd FileType python setlocal omnifunc=lsp#complete
  endif

  if executable('gopls')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
          \ 'whitelist': ['go'],
          \ })
    autocmd BufWritePre *.go LspDocumentFormatSync
    autocmd FileType go setlocal omnifunc=lsp#complete
  endif

  if executable('clangd')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {server_info->['clangd', '-background-index']},
          \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
          \ })
    autocmd FileType c      setlocal omnifunc=lsp#complete
    autocmd FileType cpp    setlocal omnifunc=lsp#complete
    autocmd FileType objc   setlocal omnifunc=lsp#complete
    autocmd FileType objcpp setlocal omnifunc=lsp#complete
  endif
augroup END
