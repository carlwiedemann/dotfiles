set nocompatible

set number relativenumber
set ruler
syntax on

" Let's ignore modelines for now.
" set modeline

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:»·,trail:·

" Indent settings for the detected filetype.
autocmd FileType go setlocal noexpandtab

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Directories for swp files.
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Font.
set guifont=Hack:h18

" Home and end using emacs.
inoremap <C-E> <End>
nnoremap <C-E> <End>
inoremap <C-A> <Home>
nnoremap <C-A> <Home>

" Move through windows.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Toggle relative number with `ctrl + shift + n`
map <C-S-n> :set relativenumber!<CR>

" Use system clipboard https://vi.stackexchange.com/a/96
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" Do not replace buffer with pasted-over contents.
" https://stackoverflow.com/questions/3837772/vim-replace-selection-with-default-buffer-without-overwriting-the-buffer#comment76964481_3837845
vnoremap p "_dP

" Paste inner word.
noremap gpiw ciw<C-r>0<Esc>
" Paste inner paragraph.
noremap gpip cip<C-r>0<Esc>

" Use system clipboard.
" https://stackoverflow.com/a/30691754
set clipboard=unnamed

" Plugins, using Vim Plug. https://github.com/junegunn/vim-plug
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

Plug 'chrisbra/matchit'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jeffkreeftmeijer/vim-numbertoggle', { 'branch': 'main' }
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-utils/vim-line'
Plug 'wsdjeg/vim-lua'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
