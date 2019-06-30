" バッファ移動
nnoremap <C-k> :bp<CR>
nnoremap <SPACE>k :bp<CR>
nnoremap <C-j> :bn<CR>
nnoremap <SPACE>j :bn<CR>

" 行末、行頭、括弧移動
noremap <C-l> $
noremap <SPACE>l $
noremap <C-h> ^
noremap <SPACE>h ^
noremap <C-p> %
noremap <SPACE>p %

" 折り返し時の行移動
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" 括弧補完たち
inoremap { {}<Left>
inoremap {} {}
inoremap {<ENTER> {}<Left><CR><ESC><S-=><S-=><S-o>x<C-h>
inoremap ( ()<Left>
inoremap () ()
inoremap (<ENTER> ()<Left><CR><ESC><S-=><S-=><S-o>x<C-h>
inoremap ' ''<LEFT>
inoremap '<SPACE> '<SPACE>
inoremap " ""<LEFT>
inoremap "<SPACE> "<SPACE>
" レジスタ
nnoremap ] "
vnoremap ] "

" 行末までヤンク
nnoremap Y y$


" " コンパイルと実行
" コンパイルと実行
augroup F5Run
  autocmd!
  autocmd FileType python          nnoremap <F5> :w<CR>:!clear;python %:p<CR>
  autocmd BufRead,BufNewFile *.nim nnoremap <F5> :w<CR>:!clear;nim c -r %:p<CR>
  " autocmd BufRead,BufNewFile *.nim nnoremap <F5> :w<CR>:!clear;nim c -r -d:release %:p<CR>
  autocmd FileType c               nnoremap <F5> :w<CR>:!clear;gcc -lm -o %:r %:p;./%:r<CR>
  autocmd FileType cpp             nnoremap <F5> :w<CR>:!clear;g++ -o %:r %:p;./%:r<CR>
  autocmd FileType go              nnoremap <F5> :w<CR>:!clear;go run %:p<CR>
  autocmd FileType java            nnoremap <F5> :w<CR>:!clear;javac %;java %:r<CR>
  autocmd FileType sh              nnoremap <F5> :w<CR>:!clear;sh %<CR>
augroup END

" コンパイルのみ
augroup F6Compile
  autocmd!
  " autocmd BufRead,BufNewFile *.nim nnoremap <F6> :w<CR>:!clear;nim c %:p<CR>
  autocmd BufRead,BufNewFile *.nim nnoremap <F6> :w<CR>:!clear;nim c -d:release %:p<CR>
  autocmd FileType c               nnoremap <F6> :w<CR>:!clear;gcc -lm -o %:r %:p<CR>
  autocmd FileType cpp             nnoremap <F6> :w<CR>:!clear;g++ -o %:r %:p<CR>
  autocmd FileType go              nnoremap <F6> :w<CR>:!clear;go build<CR>
  autocmd FileType java            nnoremap <F6> :w<CR>:!clear;javac %<CR>
augroup END

