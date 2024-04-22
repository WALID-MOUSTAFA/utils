set nocompatible
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sainnhe/everforest'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'preservim/nerdtree'
Plug 'plan9-for-vimspace/acme-colors'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Wombat'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'ervandew/supertab'
Plug 'chrisbra/unicode.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jpo/vim-railscasts-theme'
Plug 'sheerun/vim-polyglot'
Plug 'flazz/vim-colorschemes'
Plug 'edkolev/tmuxline.vim'
Plug 'yegappan/taglist'
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
if has("nvim") 
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
endif
" Plug 'posva/vim-vue'
call plug#end()
let g:deoplete#enable_at_startup = 1

"look and feel
set bg=dark
let g:everforest_background = 'hard'
colorscheme cobaltish 
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme='cobalt2'
set ignorecase
set encoding=utf-8
set t_Co=256
" set term=xterm-256color
set number relativenumber 

let mapleader = ","
set termencoding=utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set nohlsearch
set noswapfile
set termguicolors
set laststatus=2
nnoremap <f2> :NERDTreeToggle<CR>
nnoremap <silent> <C-p> :Files <CR>
nnoremap <silent> <leader>p :GFiles <CR>
nnoremap <silent> <C-b> :Buffers <CR>
nnoremap  <f3> :set arabic! <CR>
let g:user_emmet_leader_key='<C-J>'
:tnoremap <Esc> <C-\><C-n>

if has("gui_running")
	set guioptions -=m 
	set guioptions -=T
	set guioptions -=r
	set guioptions -=L
	set guifont = "Noto Mono for Powerline \10"
endif
set arabicshape!

let g:LanguageClient_autoStart = 0

" lsp configurations for old vim
if executable('vls')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'vls',
				\ 'cmd': {server_info->['vls']},
				\ 'allowlist': ['vue'],
				\ })
endif
let g:lsp_auto_enable=0
function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal signcolumn=yes
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> gs <plug>(lsp-document-symbol-search)
	nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
	nmap <buffer> gr <plug>(lsp-references)
	nmap <buffer> gi <plug>(lsp-implementation)
	nmap <buffer> gt <plug>(lsp-type-definition)
	nmap <buffer> <leader>rn <plug>(lsp-rename)
	nmap <buffer> [g <plug>(lsp-previous-diagnostic)
	nmap <buffer> ]g <plug>(lsp-next-diagnostic)
	nmap <buffer> K <plug>(lsp-hover)
	nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
	nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

	let g:lsp_format_sync_timeout = 1000
	autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
	" refer to doc to add more commands
endfunction
augroup lsp_install
	au!
	" call s:on_lsp_buffer_enabled only for languages that has the server registered.
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

