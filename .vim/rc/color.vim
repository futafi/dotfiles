" colorscheme desert
colorscheme molokai
" syntax on
syntax on

" vim-lsp color setting.
" To change the style of the highlighting
" `LspErrorHighlight`, `LspWarningHighlight`, `LspInformationHighlight` and
" `LspHintHighlight` highlight groups.
" highlight LspWarningHighlight term=underline cterm=underline gui=underline ctermfg=red guifg=Cyan ctermbg=yellow guibg=green

if g:colors_name == 'molokai'
  highlight Comment            ctermfg=darkcyan
  highlight MatchParen         ctermfg=Black    ctermbg=Cyan
  highlight Todo               ctermfg=233    ctermbg=3     cterm=bold,underline
endif

highlight LspWarningHighlight cterm=underline,bold
highlight LspErrorHighlight                   ctermbg=197
