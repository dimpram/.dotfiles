" -----------------------------------------------------------------------------
" Author: @dimpram
" Description: My neovim/vim config inspired by: \
" craftzdog ~ https://github.com/craftzdog/dotfiles-public \
" George Ornbo ~ https://shapeshed.com/vim-netrw/ \
" -----------------------------------------------------------------------------

" -------------------
" Pluggins vim
" -------------------
call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
let g:coc_node_path = '~/.nvm/versions/node/v15.10.0/bin/node'

" -------------------
" Vanilla vim
" -------------------
set nocompatible
set encoding=utf-8
syntax on                     " Syntax highlighting
set nu rnu                    " Hybrid lines
set nowrap                    " Disables line wrap
set splitright                " New split appears on the right
set path+=**                  " Search down into subfolders, provides tab completion for all file related tags
set wildmenu                  " Display all matching files when we tab complete
set ttyfast                   " Speed up scrolling in Vim
set ignorecase                " Search ignores case
set smartcase                 " Search includes only uppercase words with uppercase search terms
set smarttab                  " Tab...
set tabstop=2                 " ...
set shiftwidth=2              " ...Customization
set expandtab                 " Always uses spaces instead of tab characters
set clipboard+=unnamedplus    " Copy to clipboard
set cursorline                " Sets cursor line
" set spell                     " Set spell checking with ISO language codes like :set spelllang=fr_ch
" set autochdir                 " Change directory to the current buffer when opening files.


" -------------------
" Useful stuff
" -------------------
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv


" -------------------
" Status line
" -------------------
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set laststatus=2              " First ensure that the status bar is enabled all the time

set statusline=
set statusline+=%#CursorColumn#
set statusline+=%{StatuslineGit()}
set statusline+=%#PmenuSel#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}]
set statusline+=\ %p%%
set statusline+=\ %l:%c


" -------------------
" netrw
" -------------------
let g:netrw_banner = 0        " Remove top banner
let g:netrw_liststyle = 3     " Choose default list style (Values: 0 to 4)
nmap sf :Explore<CR>


" -------------------
" Tabs
" -------------------
" Open current directory
nmap te :tabedit 
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>


" -------------------
" Windows
" -------------------
" Split window
nmap ss :split<Return>
nmap sv :vsplit<Return>
" Move window
nmap <Space> <C-w>w
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Resize window
nnoremap <Up> :resize +4<CR>
nnoremap <Down> :resize -4<CR>
nnoremap <Left> :vertical resize +4<CR>
nnoremap <Right> :vertical resize -4<CR>
" nmap <C-w><left> <C-w><
" nmap <C-w><right> <C-w>>
" nmap <C-w><up> <C-w>+
" nmap <C-w><down> <C-w>-
