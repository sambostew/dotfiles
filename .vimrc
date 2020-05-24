syntax on
filetype plugin indent on

" turn relative line numbers off
set relativenumber
highlight LineNr ctermfg=white

" turn on line cursor
set cursorline
highlight CursorLine gui=underline cterm=underline

" Install Vim Plugins
call plug#begin('~/.vim/plugged')

Plug 'pearofducks/ansible-vim'
Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'simnalamburt/vim-mundo'

" Initialize plugin system
call plug#end()

"Set colour scheme to palenight
colorscheme palenight

" define lightline configuration
let g:lightline = { 'colorscheme': 'palenight' }

" Shell check
map <leader>p :!clear && shellcheck %<CR>

"Map UndoTree to F5
nnoremap <F5> :MundoToggle<CR>

let NERDTreeMapActivateNode='<right>'
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']
let NERDTreeShowHidden=1

nmap <leader>j :NERDTreeFind<CR>

let NERDTreeDirArrowExpandable='+'
let NERDTreeDirArrowCollapsible='~'

"Fix Lightline"
set laststatus=2
set noshowmode
