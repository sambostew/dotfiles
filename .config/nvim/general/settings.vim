" set leader key
let g:mapleader = "\<Space>"

syntax enable
set hidden
set nowrap
set encoding=utf-8
set ruler
set mouse=a 
set shiftwidth=2
set tabstop=2
set smarttab
set autoindent
set smartindent
set number relativenumber
set belloff=all
set clipboard=unnamedplus
set foldmethod=marker
set scrolloff=999
set spell
set cursorline
set ttyfast
set termguicolors
set modifiable

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

" You can't stop me
cmap w!! w !sudo tee %

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


