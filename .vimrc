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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug '907th/vim-auto-save'
" Initialize plugin system
call plug#end()

"Set colour scheme to palenight
colorscheme palenight
set background=dark 

" define lightline configuration
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
	  \	  'colorscheme': 'palenight',
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}

let g:lightline.component_raw = {'buffers': 1}

" Buffline navigation using numbers
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

"Fix Lightline"
set laststatus=2
set showtabline=2
set noshowmode

" Spell check
map <leader>s :setlocal spell spellang=en_gb<CR>
" Shell check
map <leader>S :!clear && shellcheck %<CR>

"Map UndoTree to F5
nnoremap <F5> :MundoToggle<CR>

" Nerd Tree
map <leader>n :NERDTreeToggle<CR>

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

"fzf
nnoremap <C-p> :Files /$HOME/<CR>

"Auto Save text files
let g:auto_save = 0
augroup ft_text
  au!
  au FileType text let b:auto_save = 1
augroup END

"Disable the annoying bell
set belloff=all

"Add a Return line in normal mode without having to switch to Insert
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

"Create a new file, in a new tab
nmap <C-n> :tabedit file <CR>

"Automaticall Center the buffer
set scrolloff=999

"Fix delete key in vim
set backspace=indent,eol,start
