" vim: sw=2 ts=2 sts=2 et foldmarker={,} foldmethod=marker
set nocompatible
set encoding=UTF8

" Vundle setup {
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'gmarik/Vundle.vim'
  Plugin 'chriskempson/base16-vim'
  Plugin 'scrooloose/nerdtree'
  Plugin 'Raimondi/delimitMate'
  Plugin 'tpope/vim-surround'
  call vundle#end()
  filetype plugin indent on
" }

" color scheme {
  syntax on
  set background=dark
  colorscheme base16-ocean
" }

" ui {
  set number " line number
  set ruler " position  of cursor
  set showcmd " show incomplete command in status bar
  set colorcolumn=80
  set title " Title of window
  set wildmenu
  set wildmode=list:longest,full
  set list
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
  set cursorline
  " statusline {
      set laststatus=2
  " }
  " Search {
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase
  " }
  if has("gui_running")
    if has('macunix')
      set guifont=Menlo:h11
    endif
    set guioptions-=T " disable tab bar
    set guioptions-=r " disable right scroll bar
    set guioptions-=L " disable left scroll bar
  endif
" }

" file handling {
  set autoread
  set autowriteall " write when switching buffers, exiting ...
  au FocusLost * silent! wa " Save all buffers when focus is lost
  set backupdir=~/.vimbackup
  set directory=~/.vimbackup
" }

" tabs/spaces {
  set shiftwidth=4
  set tabstop=4
  set softtabstop=4  " let backspace no about space indentation
  set expandtab
  set backspace=indent,eol,start
" }

" Key mappings {
  imap jj <Esc>
" }

" Plugins {
  " NerdTree {
    let NERDTreeShowHidden=1
    let NERDTreeIgnore=['^\.git$', '^\.DS_Store$']
    nmap <silent> <C-O> :NERDTreeToggle<CR>
  " }
" }
