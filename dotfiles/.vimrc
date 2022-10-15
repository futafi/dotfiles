" " settings
set encoding=UTF-8
set fenc=UTF-8
scriptencoding UTF-8
" helpの日本語化
set helplang=ja,en
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
set t_Co=256
set synmaxcol=288
" 行番号を表示
set number
set relativenumber
" ビープ音系
set vb t_vb=
set novisualbell
set belloff=all
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
augroup Iroiro
  autocmd!
  autocmd BufNewFile,BufRead * match ZenkakuSpace /　/
augroup END

" " Tab系
" スマートインデント
set smartindent
set tabstop=6
set shiftwidth=2
" filetype
augroup FileTypeSettings
  autocmd!
  " Tab文字を半角スペースにする
  autocmd BufRead,BufNewFile set expandtab
  " Tab文字の表示幅（スペースいくつ分）
  autocmd BufRead,BufNewFile set tabstop=6
  autocmd BufRead,BufNewFile set shiftwidth=2
  autocmd BufRead,BufNewFile *.nim set filetype=nim
  autocmd BufRead,BufNewFile *.h set filetype=c
  autocmd Filetype python set shiftwidth=4
  autocmd Filetype c set noexpandtab
  autocmd Filetype c set tabstop=6
  autocmd Filetype c set shiftwidth=6
  autocmd Filetype go set noexpandtab
  autocmd Filetype go set tabstop=4
  autocmd Filetype go set shiftwidth=4
  autocmd Filetype markdown set tabstop=2
  autocmd Filetype systemverilog set expandtab
augroup END

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
" 補完時の設定
" set completeopt=menuone
" set completeopt=menuone,longest
set completeopt=menuone,noinsert,noselect
" set completeopt=menuone,preview,noinsert,noselect
" ファイル名タブ補完
set wildmenu
" set wildmode=list:longest,longest,full
set wildmode=list:longest,longest,longest,full
" 空行のインデントの維持
nnoremap o ox<C-h>
nnoremap O OX<C-h>
inoremap <CR> <CR>X<C-h>

" ユーザー辞書
augroup user_dict
  autocmd!
  autocmd FileType tex setlocal dictionary+=~/.vim/user_dicts/tex.dict
augroup END

" Clear Undo
function! s:clear_undo() abort
  let old_undolevels = &undolevels
  setlocal undolevels=-1
  execute "normal! a \<BS>\<Esc>"
  let &l:undolevels = old_undolevels
endfunction
command! -bar ClearUndo  call s:clear_undo()

" 曜日
function! s:weekday(...) abort
  if a:0 == 2
    let l:time = localtime() -  str2nr(a:2) * 60 * 60 * 24
  else
    let l:time = localtime()
  endif
  let l:week_str = strftime("%w", l:time)
  let l:weeks_dict = {
        \ "ja": [ "日", "月", "火", "水", "木", "金", "土" ],
        \ "en": [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ],
        \ "jal": [ "日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日" ],
        \ "enl": [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ]
        \ }
  if a:0 == 0
    let l:weeks = l:weeks_dict["ja"]
  else
    let l:weeks = l:weeks_dict[a:1]
  endif
  return l:weeks[l:week_str]
endfunction

" Tday Command
function! s:tday(...) abort
  if a:0 == 0
    let l:diff = 0
  else
    let l:diff = str2nr(a:1) * 60 * 60 * 24
  endif
  let l:weekday = s:weekday("ja", l:diff)
  return strftime('%d', localtime() + l:diff)."日（".l:weekday."）"
endfunction
command! -bar -nargs=* Week execute ":normal a".s:weekday(<f-args>)
command! -bar -nargs=* TDay execute ":normal a"s:tday(<f-args>)

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
  " autocmd FileType python setlocal formatprg=autopep8\ -a\ -a\ -
  " autocmd FileType c      setlocal formatprg=clang-format\ -style=\"{BasedOnStyle:\ Google,\ IndentWidth:\ 4,\ Standard:\ C++11}\"\ -
  autocmd FileType c      setlocal formatprg=clang-format\ -style=\"{BasedOnStyle:\ LLVM,\ IndentWidth:\ 8,\ UseTab:\ Always,\ BreakBeforeBraces:\ Linux,\ AllowShortIfStatementsOnASingleLine:\ false,\ IndentCaseLabels:\ false,\ ColumnLimit:\ 0,\ AlignConsecutiveMacros:\ true,\ AlignEscapedNewlines:\ Left}\"\ -
  autocmd FileType cpp    setlocal formatprg=clang-format\ -style=\"{BasedOnStyle:\ Google,\ IndentWidth:\ 4,\ Standard:\ C++11}\"\ -
  autocmd FileType go     setlocal formatprg=gofmt
  autocmd FileType json   setlocal formatprg=python\ -m\ json.tool\ -
  autocmd FileType javascript setlocal formatprg=js-beautify\ --indent-size=2\ --stdin\ -
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

" colorscheme
source ~/.vim/rc/color.vim
set visualbell t_vb=
