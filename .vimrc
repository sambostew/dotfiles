"Set the leader key to space
let mapleader = "\<space>"

set clipboard^=unnamed,unnamedplus

" Change the ESC timeout values
set timeoutlen=1000 ttimeoutlen=0

" Tab Settings"
set shiftwidth=4
set softtabstop=4
set tabstop=4

syntax on
filetype plugin indent on

" turn relative line numbers off
set relativenumber
highlight LineNr ctermfg=white

" turn on line cursor
set cursorline
highlight CursorLine gui=underline cterm=underline

" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Set splits to the right and the bottom, useful for vim help output
set splitbelow
set splitright

" Install Vim Plugins
call plug#begin('~/.vim/plugged')

Plug 'pearofducks/ansible-vim'
Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

"Set colour scheme to palenight
colorscheme palenight

" define lightline configuration
let g:lightline = {'colorscheme': 'palenight'}
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}

" Shell check
map <leader>s :!clear && shellcheck %<CR>

"Map UndoTree to F5
nnoremap <F5> :MundoToggle<CR>

" Nerd Tree
map <leader>n :NERDTreeToggle<CR>
nmap <leader>j :NERDTreeFind<CR>

" Automatically open NerdTree but place the cursor in the main buffer
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"Automatically close when NerdTree is the last open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMapActivateNode='<right>'
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"Fix Lightline"
set laststatus=2
set noshowmode
