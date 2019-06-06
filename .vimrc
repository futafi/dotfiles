" " settings
set encoding=UTF-8
set fenc=UTF-8
scriptencoding UTF-8
" バックアップとスワップを作らない
set nobackup
set noswapfile
" ファイルの変更検知と読み直し
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 高速化
set ttyfast
" " mouse
" set mouse=a

" " 見た目系
colorscheme desert
set t_Co=256
" 行番号を表示
set number
" ビープ音系
set vb t_vb=
set novisualbell
" scroll
set scrolloff=10
" 対応する括弧を表示
set showmatch
set matchtime=1
" 括弧ペアの追加
set matchpairs& matchpairs+=<:>,（:）
" ステータスラインを常に表示
set laststatus=2
" 行の折り返し
set wrap
" 全角スペースの可視化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/
" syntax on
syntax on

" " Tab系
" スマートインデント
set smartindent
" Tab文字を半角スペースにする
set expandtab
" Tab文字の表示幅（スペースいくつ分）
set tabstop=2
set shiftwidth=2

" " 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" " 入力系
" 補完の大文字小文字の無視
set infercase
" タブ補完
set wildmenu
set wildmode=list:longest,list:longest,full
" 空行のインデントの維持
nnoremap o ox<C-h>
nnoremap O OX<C-h>
inoremap <CR> <CR>X<C-h>

" ユーザー辞書
augroup dictionary
  autocmd!
  autocmd FileType tex setlocal dictionary+=~/.vim/user_dicts/tex.dict
augroup END

" コピペ
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
	set paste
	return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" " ファイルフォーマット
command Format normal gggqG
augroup format
  autocmd!
  autocmd FileType python setlocal formatprg=autopep8\ --aggressive\ --aggressive\ -
  autocmd FileType c      setlocal formatprg=clang-format\ -style=\"{BasedOnStyle:\ Google,\ IndentWidth:\ 4,\ Standard:\ C++11}\"\ -
  autocmd FileType cpp    setlocal formatprg=clang-format\ -style=\"{BasedOnStyle:\ Google,\ IndentWidth:\ 4,\ Standard:\ C++11}\"\ -
augroup END

" " 補完のお勉強
let s:compl_key_dict = {
      \ char2nr("\<C-l>"): "\<C-x>\<C-l>",
      \ char2nr("\<C-n>"): "\<C-x>\<C-n>",
      \ char2nr("\<C-p>"): "\<C-x>\<C-p>",
      \ char2nr("\<C-k>"): "\<C-x>\<C-k>",
      \ char2nr("\<C-t>"): "\<C-x>\<C-t>",
      \ char2nr("\<C-i>"): "\<C-x>\<C-i>",
      \ char2nr("\<C-]>"): "\<C-x>\<C-]>",
      \ char2nr("\<C-f>"): "\<C-x>\<C-f>",
      \ char2nr("\<C-d>"): "\<C-x>\<C-d>",
      \ char2nr("\<C-v>"): "\<C-x>\<C-v>",
      \ char2nr("\<C-u>"): "\<C-x>\<C-u>",
      \ char2nr("\<C-o>"): "\<C-x>\<C-o>",
      \ char2nr('s'): "\<C-x>s",
      \ char2nr("\<C-s>"): "\<C-x>s"
      \}
let s:hint_i_ctrl_x_msg = join([
      \ '<C-l>: While lines',
      \ '<C-n>: keywords in the current file',
      \ "<C-k>: keywords in 'dictionary'",
      \ "<C-t>: keywords in 'thesaurus'",
      \ '<C-i>: keywords in the current and included files',
      \ '<C-]>: tags',
      \ '<C-f>: file names',
      \ '<C-d>: definitions or macros',
      \ '<C-v>: Vim command-line',
      \ "<C-u>: User defined completion ('completefunc')",
      \ "<C-o>: omni completion ('omnifunc')",
      \ "s: Spelling suggestions ('spell')"
      \], "\n")
function! s:hint_i_ctrl_x() abort
  echo s:hint_i_ctrl_x_msg
  let c = getchar()
  return get(s:compl_key_dict, c, nr2char(c))
endfunction
inoremap <expr> <C-x>  <SID>hint_i_ctrl_x()

" " source
source ~/.vim/rc/map.vim
source ~/.vim/rc/plug-init.vim

if has("win32unix")
	source ~/.vim/rc/win.vim
elseif has("unix")
	source ~/.vim/rc/linux.vim
endif
