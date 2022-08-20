" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Quicker Alternate to Escape
inoremap jk <Esc>
inoremap kj <Esc>

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Alternate way to save
nnoremap <C-x> :qa!<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

"Create a new file, in a new tab
nmap <C-n> :tabedit file <CR>

"Map UndoTree to F5
nnoremap <F5> :MundoToggle<CR>

"fzf
nnoremap <C-p> :Files <CR>
nnoremap <C-o> :Buffers<CR>
nnoremap <C-g> :GFiles<CR>
nnoremap <C-f> :Rg   

" Shortcut to edit nvim.init
nnoremap <silent> <leader>ee :e $HOME/.config/nvim/init.vim<CR>
