" let g:asyncomplete_enable_for_all = 0
" let g:asyncomplete_auto_popup = 0
let g:asyncomplete_auto_completeopt = 0
" Enables echo of diagnostic error for the current line to status.
let g:lsp_diagnostics_echo_cursor = 1
" Enables signs for diagnostics.
let g:lsp_signs_enabled = 1
" Enables highlighting of diagnostics.
let g:lsp_textprop_enabled = 1
" auto close indicates
" let g:lsp_preview_autoclose = 0
" preview float
let g:lsp_preview_float = 1
" color setting is in ~/.vim/rc/color.vim

command LSDiagnostics LspDocumentDiagnostics
command LSFormat LspDocumentFormat
command LSHover LspHover
command LSDef LspDefinition
command LSTDef LspTypeDefinition
command LSSig LspSignatureHelp

nmap <SPACE>hh <plug>(lsp-hover)

" augroup vimlsp
  " autocmd!
  " autocmd FileType python,go,vim,nim,git,snippet call asyncomplete#enable_for_buffer()
" augroup END

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  nmap <buffer> gd <plug>(lsp-definition)
endfunction

