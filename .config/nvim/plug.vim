call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-fugitive'     " Git wrapper
Plug 'tpope/vim-rhubarb'      " Git wrapper extension
Plug 'cohama/lexima.vim'      " Auto close parenthesis with dot dot dot support
Plug 'sheerun/vim-polyglot'   " Better syntax highlighting
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Official vim go plugin

if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()
