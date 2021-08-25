"Nerdtree
let g:NERDTreeWinPos = "right"
let g:NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.orig$']
nnoremap <C-Space> :NERDTreeFind<CR>zz
vmap <C-Space> :NERDTreeFind<CR>zz
inoremap <C-Space> <Esc>:NERDTreeFind<CR>zz
nnoremap <C-e> :NERDTreeRefreshRoot<CR>
inoremap <C-e> :NERDTreeRefreshRoot<CR>
vmap <C-e> :NERDTreeRefreshRoot<CR>

nnoremap <leader>tq :NERDTreeClose<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <silent>gb <C-^>

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
autocmd BufWinEnter * call PreventBuffersInNERDTree()

function! PreventBuffersInNERDTree()
  if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree'
    \ && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr
    \ && &buftype == '' && !exists('g:launching_fzf')
    let bufnum = bufnr('%')
    close
    exe 'b ' . bufnum
    NERDTree
  endif
  if exists('g:launching_fzf') | unlet g:launching_fzf | endif
endfunction
