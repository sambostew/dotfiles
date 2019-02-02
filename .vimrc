execute pathogen#infect()

syntax on
filetype plugin indent on

colorscheme wal
set nu

" define lightline configuration
 let g:lightline = {
       \ 'colorscheme': 'wombat',
             \ }

autocmd vimenter * NERDTree

nmap <F6> :NERDTreeToggle<CR>
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
