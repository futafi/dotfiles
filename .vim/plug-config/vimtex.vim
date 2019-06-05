if has("win32unix")
  let g:tex_flavor='latex'
  " let g:vimtex_view_general_viewer = 'SumatraPDF'
  let g:vimtex_view_general_viewer = '/c/Program Files/SumatraPDF/SumatraPDF.exe'
  let g:vimtex_view_automatic = 0
  let g:latex_view_method = 'SumatraPDF'
  let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
  let g:vimtex_quickfix_open_on_warning = 0
  let g:vimtex_imaps_enabled = 0

  let g:vimtex_compiler_latexmk = {
        \ 'backend' : 'jobs',
        \ 'background' : 1,
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 0,
        \ 'executable' : 'docker',
        \ 'options' : [
        \   'run',
        \   '--rm',
        \   '-v',
        \   '/$(PWD):/workdir',
        \   'latex',
        \   'latexmk',
        \ ],
        \}
endif
