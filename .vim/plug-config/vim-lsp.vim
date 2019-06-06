let g:lsp_async_completion = 1
let g:asyncomplete_enable_for_all = 0
let g:asyncomplete_auto_popup = 0

augroup vimlsp
	autocmd FileType python,go,vim,nim,git,snippet call asyncomplete#enable_for_buffer()
augroup END

augroup lsppython
	if executable('pyls')
		" pip install python-language-server
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'pyls',
					\ 'cmd': {server_info->['pyls']},
					\ 'whitelist': ['python'],
					\ })
	endif
augroup END

augroup lspgo
	if executable('golsp')
		autocmd!
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'go-lang',
					\ 'cmd': {server_info->['golsp', '-mode', 'stdio']},
					\ 'whitelist': ['go'],
					\ })
		autocmd FileType go setlocal omnifunc=lsp#complete
	endif
augroup END

augroup lspc
	if executable('clangd')
		autocmd!
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'clangd',
					\ 'cmd': {server_info->['clangd', '-background-index']},
					\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
					\ })
	endif
augroup END

