set nocompatible
filetype off

" vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jiangmiao/auto-pairs'
Plugin 'neomake/neomake'
if has('nvim')
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plugin 'Shougo/deoplete.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'zchee/deoplete-jedi'
Plugin 'zchee/deoplete-clang'
Plugin 'davidhalter/jedi-vim'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'dag/vim-fish'

call vundle#end()
filetype plugin indent on

" config

let mapleader = ','
set hidden
set tabstop=4 shiftwidth=4 expandtab
set ignorecase smartcase

let base16colorspace=256
colorscheme base16-default-dark

" powerline
let g:airline_powerline_fonts = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:python_host_prog = $HOME.'/.asdf/shims/python2'
let g:python3_host_prog = $HOME.'/.asdf/shims/python3'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" jedi
let g:jedi#completions_enabled = 0
let g:jedi#auto_close_doc = 1

" clang
let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#libclang_header = "/usr/lib/clang"

" ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s; and git ls-files']

" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" automake
call neomake#configure#automake('nw', 1000)
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_c_enabled_makers = ['clang']

" window resize
if bufwinnr(1)
  map <M-=> <C-W>+
  map <M--> <C-W>-
  map <M-.> <C-W>>
  map <M-,> <C-W><
endif

"keybindings
noremap <leader>tf :NERDTreeToggle<CR>
noremap <leader>b :CtrlPBuffer<CR>
inoremap jk <Esc>
inoremap kj <Esc>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <C-f> <right>
inoremap <C-b> <left>
tnoremap <Esc> <C-\><C-n>
