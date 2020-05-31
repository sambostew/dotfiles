": Basic Leader key bindings, configuration and setting {{{

"Set the leader key to space
let mapleader = "\<space>"

set clipboard^=unnamed,unnamedplus
set foldmethod=marker
set timeoutlen=1000 ttimeoutlen=0
set shiftwidth=4
set softtabstop=4
set tabstop=4
syntax on
filetype plugin indent on
set relativenumber
highlight LineNr ctermfg=white
set belloff=all
set scrolloff=999
set backspace=indent,eol,start

" turn on line cursor
set cursorline
highlight CursorLine gui=underline cterm=underline

"Add a Return line in normal mode without having to switch to Insert
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

"Create a new file, in a new tab
nmap <C-n> :tabedit file <CR>

"Map UndoTree to F5
nnoremap <F5> :MundoToggle<CR>
"fzf
nnoremap <C-p> :Files /$HOME/<CR>

set guioptions-=e
": }}}

": Set split configuration and shortcuts {{{
"
" Shortcuts for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Set splits to the right and the bottom, useful for vim help output
set splitbelow
set splitright

": }}}

": Vim Plugins {{{
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

call plug#end()

": }}}

": Color Scheme {{{
"Set colour scheme to palenight

set background=dark 
colorscheme palenight

": }}}
"
": Lightline and Bufferline Configuration {{{
 
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

let g:lightline#bufferline#number_map = {
  \ '0': ' 0 ',
  \ '1': ' 1 ',
  \ '2': ' 2 ',
  \ '3': ' 3 ',
  \ '4': ' 4 ',
  \ '5': ' 5 ',
  \ '6': ' 6 ',
  \ '7': ' 7 ',
  \ '8': ' 8 ',
  \ '9': ' 9 ',
  \ }
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#shorten_path = 0

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

": }}}

": Spell and Shell checking {{{
map <leader>s :setlocal spell spellang=en_gb<CR>
" Shell check
map <leader>S :!clear && shellcheck %<CR>

": }}}

": Nerd Tree {{{
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

": }}}

": Auto Save text files {{{
let g:auto_save = 0
augroup ft_text
  au!
  au FileType text let b:auto_save = 1
augroup END
": }}}

