noremap <C-Right> :vertical resize -5<CR>
nnoremap <C-Left> :vertical resize +5<CR>
nnoremap <C-Up> :resize -5<CR>
nnoremap <C-Down> :resize +5<CR>

nmap <c-k> :wincmd k<CR>
nmap <c-j> :wincmd j<CR>
nmap <c-h> :wincmd h<CR>
nmap <c-l> :wincmd l<CR>

nmap <leader>p "+p
vmap <leader>p "+p
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>db :%bd! <bar> #e <bar> bd# <CR>
vmap <leader>db :%bd! <bar> #e <bar> bd# <CR>

vmap <C-y> "+y

nnoremap <C-TAB> :bn!<CR>

noremap <silent> <C-S> :update<CR><Esc>
vnoremap <silent> <C-S> <C-C>:update<CR><Esc>
inoremap <silent> <C-S> <C-O>:update<CR><Esc>

nnoremap <C-y> :let @+=join([expand('%'),  line(".")], ':')<CR>

nnoremap <leader>dd d0kJx

nnoremap <S-Tab> :bn!<CR>
nnoremap <C-Q> :bp\|bd! #<CR>
nnoremap <C-C> <C-w>c

nnoremap <esc><esc> :silent! nohls<cr>
