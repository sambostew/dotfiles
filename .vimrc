execute pathogen#infect()

syntax on
filetype plugin indent on

colorscheme herokudoc
set nu

autocmd vimenter * NERDTree

nmap <F6> :NERDTreeToggle<CR>

let NERDTreeMapActivateNode='<right>'
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']

nmap <leader>j :NERDTreeFind<CR>

let NERDTreeDirArrowExpandable='+'
let NERDTreeDirArrowCollapsible='~'

set laststatus=2
