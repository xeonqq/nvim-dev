call plug#begin("~/.config/nvim/plugged")
" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'bazelbuild/vim-bazel'
Plug 'alexander-born/bazel-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'vim-airline/vim-airline-themes'
Plug 'grailbio/bazel-compilation-database'
Plug 'powerline/powerline'
Plug 'chrisbra/vim-autoread'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'cj/vim-webdevicons'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'dag/vim-fish'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'bfrg/vim-cpp-modern'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'dyng/ctrlsf.vim'
Plug 'luochen1990/rainbow'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'pangloss/vim-javascript'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mechatroner/rainbow_csv'
Plug 'junegunn/vim-easy-align'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/async.vim'
Plug 'wellle/tmux-complete.vim'
Plug 'tpope/vim-abolish'
"vim-lsp-settings
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'lifepillar/vim-mucomplete'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'lighttiger2505/deoplete-vim-lsp'
" debugging
Plug 'szw/vim-maximizer'
Plug 'puremourning/vimspector'
"alway last
Plug 'ryanoasis/vim-devicons'
call plug#end()

set autoread
set rnu nu
set encoding=utf-8
set cmdheight=2
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab

let mapleader = " "
" set vim backup files direcotry to tmp
let tmp_dir=system('mktemp -d -t nvim-XXXXXXXXXX')
exe 'set backupdir='.tmp_dir
exe 'set directory='.tmp_dir
"happy_hacking deep_focus
colorscheme gruvbox 

"set list
"set listchars+=tab:-->
"set list listchars=tab:>-,nbsp:.,trail:.,extends:>,precedes:<,space: 
"set lazyredraw

set ignorecase
set cursorline
"set cursorcolumn
command! Q :qa!
command! E :e!
command! W :w!
filetype plugin on

set timeoutlen=1000
set ttimeoutlen=0

" Disable inherited syntastic
let g:syntastic_mode_map = {
			\ "mode": "passive",
			\ "active_filetypes": [],
			\ "passive_filetypes": [] }
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools' ]
set mouse=n
let g:rooter_patterns = ['WORKSPACE']

set noautochdir

let g:rainbow_active = 1

"visual_allign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Required for operations modifying multiple buffers like rename.
set hidden

"Git
nnoremap <leader>blame :Gblame<CR>

:runtime custom.vim
:runtime cpp.vim
:runtime lsp.vim
:runtime bazel.vim
:runtime style.vim
:runtime nerdtree.vim
:runtime fzf.vim
:runtime autoformat.vim
:runtime bindings.vim
:runtime ctrlsf.vim
:runtime debug.vim
