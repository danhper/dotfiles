set nocompatible
filetype off

let mapleader = ','
set hidden


" vundle
set rtp+=~/.vim/bundle/Vundle.vim
set shell=/bin/bash
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jiangmiao/auto-pairs'
if has('nvim')
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plugin 'Shougo/deoplete.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'zchee/deoplete-jedi'

call vundle#end()
filetype plugin indent on

let base16colorspace=256
colorscheme base16-default-dark

" powerline
let g:airline_powerline_fonts = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:python_host_prog = $HOME.'/.asdf/shims/python2'
let g:python3_host_prog = $HOME.'/.asdf/shims/python3'
let g:jedi#auto_close_doc = 1

" ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"keybindings
map <leader>tf :NERDTreeToggle<CR>
inoremap jk <Esc>
inoremap kj <Esc>
noremap <C-g> <Esc>
noremap! <C-g> <Esc>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
