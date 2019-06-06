" plugins
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdcommenter'
  " Plug 'justmao945/vim-clang'
  Plug 'zah/nim.vim'
  Plug 'lervag/vimtex'
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'tpope/vim-fugitive'
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
call plug#end()

runtime! ~/.vim/plug-config/*.vim
