call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-rhubarb'  " Git wrapper extension
Plug 'cohama/lexima.vim'  " Auto close parenthesis with dot dot dot support

if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()
