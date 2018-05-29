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
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on

let base16colorspace=256
colorscheme base16-default-dark

" powerline
let g:airline_powerline_fonts = 1

" ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" nerdtree
map <leader>tf :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
