call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
call plug#end()

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-prettier', 
  \ 'coc-json',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-python',
  \ 'coc-phpls',
  \ 'coc-java',
  \ 'coc-markdownlint',
  \ ]

" Hybrid lines
set nu rnu

" Search down into subfolders
" Provides tab completion for all file related tags
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Speed up scrolling in Vim
set ttyfast

" Search customization
set ignorecase
set smartcase

"NerdTREE
map <C-b> :NERDTreeToggle<CR>
