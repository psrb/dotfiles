" vim: sw=2 ts=2 sts=2 et foldmarker={{{,}}} foldmethod=marker
set nocompatible

" The environment variable VIM_LIGHT_INSTALL controls if all plugins should be
" installed
let g:isFullInstall = 1
if $VIM_LIGHT_INSTALL != ""
  let g:isFullInstall = 0
endif

" Vundle setup {{{
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'chriskempson/base16-vim'
  Plugin 'gmarik/Vundle.vim'
  Plugin 'scrooloose/nerdtree'
  Plugin 'Raimondi/delimitMate'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-markdown'
  Plugin 'bling/vim-airline'
  Plugin 'xolox/vim-misc' " dependency for vim-session
  Plugin 'xolox/vim-session'
  Plugin 'octol/vim-cpp-enhanced-highlight' " also better highlights for c
  Plugin 'vim-scripts/bufkill.vim' " sane buffer closing

  " plugins that are on main machines
  if g:isFullInstall
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'derekwyatt/vim-fswitch'
    Plugin 'rhysd/vim-clang-format'
    Plugin 'fatih/vim-go'
    Plugin 'majutsushi/tagbar'
  endif
  call vundle#end()
  filetype plugin indent on
" }}}

" color scheme {{{
  syntax on
  set background=dark
  colorscheme base16-ocean
  if has("gui_running")
    if has('macunix')
      set guifont=Menlo:h13
    endif
  endif
" }}}

" general {{{
  set encoding=UTF8
  " no error/visualbells
  set noeb vb t_vb =

  " persistent undo
  set undofile
  set undodir=$HOME/.vimundo
" }}}

" ui {{{
  set number
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
    set guioptions-=T " disable tab bar
    set guioptions-=m " disable menu
    set guioptions-=r " disable right scroll bar
    set guioptions-=R " disable right scroll bar
    set guioptions-=l " disable left scroll bar
    set guioptions-=L " disable left scroll bar
  endif
" }}}

" file handling {{{
  set autoread
  set autowriteall " write when switching buffers, exiting ...
  set nobackup
  set noswapfile
" }}}

" Indentation {{{
  set shiftwidth=4
  set tabstop=4
  set softtabstop=4  " let backspace know about space indentation
  set expandtab
  set backspace=indent,eol,start
  set autoindent
  set copyindent
  set cindent
" }}}

" Autocommands {{{

  " Save all buffers when focus is lost
  au FocusLost * silent! wa

  " Focus current window {{{
    " TODO: Bug with fugitives gdiff window (WinEnter not called)
    function! s:windowEnter()
      if &buftype == '' && &diff == 0 && &previewwindow == 0
        setlocal number
        setlocal cursorline
        if exists("w:curColorColumn")
          let &colorcolumn=w:curColorColumn
        endif
      endif
    endfunction

    function! s:windowLeave()
      if &buftype == '' && &diff == 0 && &previewwindow == 0
        setlocal nonumber
        setlocal nocursorline
        let w:curColorColumn = &colorcolumn
        setlocal colorcolumn=0
      endif
    endfunction

    augroup FocusWindow
      au!
      "au WinEnter * call s:windowEnter()
      "au WinLeave * call s:windowLeave()
    augroup END
  " }}}

" }}}

" Key mappings {{{

  " better movement between windows
  nmap <C-h> <C-w>h
  nmap <C-j> <C-w>j
  nmap <C-k> <C-w>k
  nmap <C-l> <C-w>l

  " make j/k useful for long lines
  nnoremap j gj
  nnoremap k gk

  " center cursor on forward/backwards jumps
  nnoremap <C-b> <C-b>zz
  nnoremap <C-f> <C-f>zz

  " making saving easer
  nmap <Leader>w :w<cr>

  " 'sudo save'
  cnoremap w!! w !sudo tee % >/dev/null

  " Newlines above/below current line without leaving normal mode
  nnoremap <silent> zk O<Esc>j
  nnoremap <silent> zj o<Esc>k

  " Add two newlines and position cursor on the first one in insert mode
  nmap <S-cr> o<cr><esc>ki

  " Keep selection when (re-)indenting
  vnoremap < <gv
  vnoremap > >gv
  vnoremap = =gv

  " centering searches (auto opens folds)
  nnoremap * *zzzv
  nnoremap # #zzzv
  nnoremap n nzzzv
  nnoremap N Nzzzv

  " reload vimrc
  nmap <F2> :source $MYVIMRC<cr>:echom "vimrc reloaded"<cr>

" }}}

" Plugins {{{

  " DelimitMate {{{
    " put closing bracket on seperate line after enter
    let g:delimitMate_expand_cr = 1
  " }}}

  " NerdTree {{{
    " Show hidden files
    let NERDTreeShowHidden = 1
    let NERDTreeIgnore = ['^\.git$', '^\.DS_Store$', '\.pyc$']

    noremap <silent> <Leader>O :NERDTreeToggle<CR>
    noremap <silent> <Leader>o :NERDTreeFocus<CR>
  " }}}

  " Airline {{{
    " show current branch in status line (req. Fugitive)
    let g:airline#extensions#branch#enabled = 1

    " enhanced tabline
    let g:airline#extensions#tabline#enabled = 1
    " quickly select open buffers (max 9)
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9

    " don't have powerline fonts
    let g:airline_left_sep = ' '
    let g:airline_right_sep = ' '
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
  " }}}

  " Fswitch {{{
    nmap <Leader>h :FSHere<CR>
  " }}}

  " Session {{{
    let g:session_autosave = "yes"
    let g:session_autoload = "no"
    let g:session_persist_colors = 0
    let g:session_command_aliases = 1
  " }}}

  " Bufkill {{{
    nmap <silent> <Leader>bd :BD<CR>
  " }}}

  if g:isFullInstall
    " YouCompleteMe {{{
      let g:ycm_global_ycm_extra_conf = "~/.dotfiles/ycm_extra_conf.py"
      let g:ycm_autoclose_preview_window_after_insertion = 1

      nmap <silent> <Leader>yg :YcmCompleter GoTo<CR>
      nmap <silent> <Leader>yc :YcmCompleter GoToDeclaration<CR>
      nmap <silent> <Leader>yf :YcmCompleter GoToDefinition<CR>
    " }}}

    " ClangFormat {{{
      let g:clang_format#auto_format = 0
      let g:clang_format#auto_format_on_insert_leave = 0
      let g:clang_format#detect_style_file = 1
    " }}}

    " Tagbar {{{
      map <silent> <Leader>t :TagbarOpenAutoClose<cr>
    " }}}
  endif

" }}}

