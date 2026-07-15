" Quicker Alternate to Escape
inoremap jk <Esc>
inoremap kj <Esc>

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Alternate way to save
nnoremap <C-S-x> :qa!<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
" Better tabbing
vnoremap < <gv
vnoremap > >gv

"Create a new file, in a new tab
nmap <C-n> :tabedit file <CR>

"Map UndoTree to F5
nnoremap <F5> :MundoToggle<CR>

" Telescope
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-o> <cmd>Telescope buffers<cr>
nnoremap <C-g> <cmd>Telescope git_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>

" Shortcut to edit init.lua
nnoremap <silent> <leader>ee :e $HOME/.config/nvim/init.lua<CR>

" Buffer navigation by number
nnoremap <silent> <leader>1 :BufferGoto 1<CR>
nnoremap <silent> <leader>2 :BufferGoto 2<CR>
nnoremap <silent> <leader>3 :BufferGoto 3<CR>
nnoremap <silent> <leader>4 :BufferGoto 4<CR>
nnoremap <silent> <leader>5 :BufferGoto 5<CR>
nnoremap <silent> <leader>6 :BufferGoto 6<CR>
nnoremap <silent> <leader>7 :BufferGoto 7<CR>
nnoremap <silent> <leader>8 :BufferGoto 8<CR>
nnoremap <silent> <leader>9 :BufferGoto 9<CR>

" Buffer next/previous
nnoremap <silent> <S-l> :BufferNext<CR>
nnoremap <silent> <S-h> :BufferPrevious<CR>
