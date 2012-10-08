"options
set nocompatible
set ts=2
set shiftwidth=2
set showcmd
syntax on
set autoindent
set smartindent 
set ignorecase
set incsearch
set hlsearch
set showmode
set ruler
set laststatus=2
set fileformats=unix,dos,mac
set background=dark
set expandtab
filetype plugin indent on
colorscheme desert

let g:syntastic_python_checker = 'pylint'

call pathogen#infect()

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar

if has('gui_running')
	colorscheme railscasts
endif

"omni completion
au filetype html,eruby,twig       set omnifunc=htmlcomplete#CompleteTags
au filetype css         set omnifunc=csscomplete#CompleteCSS
au filetype javascript  set omnifunc=javascriptcomplete#CompleteJS
au filetype c           set omnifunc=ccomplete#Complete
au filetype php         set omnifunc=phpcomplete#CompletePHP
au filetype sql         set omnifunc=sqlcomplete#Complete
au filetype python      set omnifunc=pythoncomplete#Complete
au filetype xml         set omnifunc=xmlcomplete#CompleteTags

let g:closetag_html_style=1
au filetype html,xml,xsl,eruby,twig source ~/.vim/scripts/closetag.vim 

"nerd tree
nnoremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <silent> <C-s> <:NERDTreeToggle<CR>

if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	unlet s:enc_euc
	unlet s:enc_jis
endif
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
if exists('&ambiwidth')
	set ambiwidth=double
endif

au Bufenter *.hs compiler ghc



set runtimepath+=/home/daniel/.vim/bundle/vim-ibus/
