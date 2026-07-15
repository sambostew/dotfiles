" set leader key
let g:mapleader = "\<Space>"

syntax enable
set hidden
set wrap linebreak
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
set cursorline
set termguicolors
set modifiable
set signcolumn=yes
set shortmess+=c

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.lua alternatively you can run :source $MYVIMRC

" You can't stop me
cmap w!! w !sudo tee %

" Automatically enable spellcheck for .txt files
augroup textSpell
    autocmd!
    autocmd FileType text setlocal spell
    autocmd BufRead,BufNewFile *.text setlocal spell
augroup END

" Enable Spellcheck
nnoremap <F6> :set spell spelllang=en_gb<CR>

"Add a Return line in normal mode without having to switch to Insert
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

set guioptions-=e



" Auto-reload buffers when modified externally
set autoread
set updatetime=300
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
