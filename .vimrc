" vim: sw=2 ts=2 sts=2 et foldmarker={{{,}}} foldmethod=marker
set nocompatible

" Setting the env variable SERVER disables some plugins that are not
" needed when using vim on a server
if $SERVER == ""
  let g:isNotServerConfig=1
endif

" Vundle setup {{{
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'gmarik/Vundle.vim'
  Plugin 'chriskempson/base16-vim'
  Plugin 'scrooloose/nerdtree'
  Plugin 'Raimondi/delimitMate'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-fugitive'
  Plugin 'bling/vim-airline'
  " dependency for vim-session
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-session'

  " plugins that are not needed on a server
  if exists("g:isNotServerConfig")
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'derekwyatt/vim-fswitch'
    Plugin 'rhysd/vim-clang-format'
    Plugin 'greyblake/vim-preview'
    Plugin 'fatih/vim-go'
  endif
  call vundle#end()
  filetype plugin indent on
" }}}

" color scheme {{{
  syntax on
  set background=dark
  colorscheme base16-ocean
" }}}

" general {{{
  set encoding=UTF8
  " no error/visualbells
  set noeb vb t_vb =
" }}}

" ui {{{
  set number " line number
  set ruler " position  of cursor
  set showcmd " show incomplete command in status bar
  set colorcolumn=+1 " display column 1 column after textwidth
  set title " Title of window
  set wildmenu
  set wildmode=list:longest,full
  set list
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
  set cursorline
  set splitright " new vertical splits always to the right
  set splitbelow " new horizontal splits always below

  " statusline {{{
      set laststatus=2
  " }}}

  " Search {{{
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase
  " }}}

  if has("gui_running")
    if has('macunix')
      set guifont=Menlo:h12
    endif
    set guioptions-=T " disable tab bar
    set guioptions-=r " disable right scroll bar
    set guioptions-=L " disable left scroll bar
  endif
" }}}

" file handling {{{
  set autoread
  set autowriteall " write when switching buffers, exiting ...
  au FocusLost * silent! wa " Save all buffers when focus is lost
  set nobackup
  set noswapfile
" }}}

" tabs/spaces {{{
  set shiftwidth=4
  set tabstop=4
  set softtabstop=4  " let backspace no about space indentation
  set expandtab
  set backspace=indent,eol,start
" }}}

" Key mappings {{{
  inoremap jj <Esc>

  " make j/k useful for long lines
  nnoremap j gj
  nnoremap k gk

  " 'sudo save'
  cnoremap w!! w !sudo tee % >/dev/null

  " Newlines above/below current line without leaving normal mode
  nnoremap <silent> zk O<Esc>j
  nnoremap <silent> zj o<Esc>k

  " NerdTree {{{
    noremap <silent> <C-O> :NERDTreeToggle<CR>
  " }}}

  " Fswitch {{{
    noremap <C-h> :FSHere<CR>
  " }}}

  " YouCompleteMe {{{
    noremap <silent> <C-]> :YcmCompleter GoToDeclaration<CR>
    noremap <silent> <C-}> :YcmCompleter GoToDefinition<CR>
  " }}}
" }}}

" Plugins {{{
  " NerdTree {{{
    let NERDTreeShowHidden=1
    let NERDTreeIgnore=['^\.git$', '^\.DS_Store$']
  " }}}

  " Airline {{{
    let g:airline_left_sep=' '
    let g:airline_right_sep=' '
    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
  " }}}

  if exists("g:isNotServerConfig")
    " YouCompleteMe {{{
      let g:ycm_global_ycm_extra_conf="~/.dotfiles/.ycm_extra_conf.py"
      "let g:ycm_autoclose_preview_window_after_insertion = 1
    " }}}

    " ClangFormat {{{
      let g:clang_format#auto_format=0
      let g:clang_format#auto_format_on_insert_leave=0
      let g:clang_format#detect_style_file=1
      let g:clang_format#code_style='WebKit'
    " }}}

    " Session {{{
      let g:session_autosave="yes"
      let g:session_persist_colors=0
    " }}}
  endif
" }}}

