set nocompatible
set encoding=UTF8

" Initialize Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"set rtp+=~/.vim/bundle/vundle
"call vundle#rc()
"Bundle 'scrooloose/nerdtree'
"Bundle 'tpope/vim-surround'
"Bundle 'Raimondi/delimitMate'
"Bundle 'chriskempson/base16-vim'

nmap <silent> <C-O> :NERDTreeToggle<CR>

syntax on
filetype plugin indent on

set background=dark
colorscheme base16-ocean

set shiftwidth=4
set tabstop=4

set number " line number
set ruler " position  of cursor
set showcmd " show incomplete command in status bar
set laststatus=2

set autoread
set autowriteall
au FocusLost * silent! wa " Save all buffers when focus is lost

" search stuff
set hlsearch
set incsearch
set ignorecase
set smartcase " if search pattern contains upper case chars ignorecase will ignored

" backup stuff
set backupdir=~/.vimbackup
set directory=~/.vimbackup

set title " Title of window
set wildmenu
set wildmode=list:longest,full

" backspace over everything
set backspace=indent,eol,start

" reindent whole file (it's not ideal)
nmap <tab> mzgg=G`zzz

" Python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4

