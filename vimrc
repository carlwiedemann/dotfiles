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
set list listchars=tab:\ \ ,trail:·

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

cmap w!! %!sudo tee > /dev/null %

set guifont=Hack:h18

" Use `ctrl + return` to return to normal mode insert mode.
inoremap <C-CR> <Esc>
vnoremap <C-CR> <Esc>

" Home and end using emacs
inoremap <C-E> <End>
nnoremap <C-E> <End>
inoremap <C-A> <Home>
nnoremap <C-A> <Home>

" Move through windows
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

set clipboard=unnamed
