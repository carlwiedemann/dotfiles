set nocompatible

set number relativenumber
set ruler
syntax on

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

" Use `ctrl + return` to return to normal mode insert mode.
"inoremap <C-CR> <Esc>
"vnoremap <C-CR> <Esc>

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
noremap piw ciw<C-r>0<Esc>
" Paste inner paragraph.
noremap pip cip<C-r>0<Esc>

" Use system clipboard.
" https://stackoverflow.com/a/30691754
set clipboard=unnamed
