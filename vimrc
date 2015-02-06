" vim: sw=2 ts=2 sts=2 et foldmarker={{{,}}} foldmethod=marker
set nocompatible

" The environment variable VIM_LIGHT_INSTALL controls if all plugins should be
" installed
let g:isFullInstall = 1
if $VIM_LIGHT_INSTALL != ""
  let g:isFullInstall = 0
endif

" Plug setup {{{
  call plug#begin('~/.vim/plugged')
  Plug 'chriskempson/base16-vim'
  Plug 'Raimondi/delimitMate'
  Plug 'tpope/vim-surround'
  Plug 'bling/vim-airline'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tomtom/tcomment_vim'
  Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus',
              \'NERDTreeToggle']}

  " git plugin
  Plug 'tpope/vim-fugitive'

  Plug 'tpope/vim-markdown', {'for': 'markdown'}
  " depends on 'tpope/vim-markdown'
  Plug 'nelstrom/vim-markdown-folding', {'for': 'markdown'}

  " dependency for vim-session
  Plug 'xolox/vim-misc'
  " Nice session management
  Plug 'xolox/vim-session'

  " also better highlights for c
  Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}

  " sane buffer closing
  Plug 'vim-scripts/bufkill.vim'

  " improved syntax highlighting for javascript
  " further tweaks below
  Plug 'pangloss/vim-javascript', {'for': ['javascript', 'html']}

  " show git diff in the number column
  Plug 'airblade/vim-gitgutter'

  " plugins that should only be on main machines (e.g. not on servers)
  if g:isFullInstall
    " deps: compiled component
    Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer'}
    Plug 'scrooloose/syntastic'

    " switch between header/sources files
    Plug 'derekwyatt/vim-fswitch', {'for': ['c', 'cpp']}

    " external deps: clang format
    Plug 'rhysd/vim-clang-format', {'for': ['c', 'cpp']}
    Plug 'fatih/vim-go', {'for': 'go'}

    " external deps: ctags
    Plug 'majutsushi/tagbar'

    " autocomplete for javascript
    " external deps: nodejs + extra npm install
    Plug 'marijnh/tern_for_vim', {'do': 'npm install',
          \ 'for': ['javascript', 'html']}

    " glsl shader language syntax definitions
    Plug 'tikhomirov/vim-glsl', {'for': 'glsl'}
  endif
  call plug#end()
" }}}

" General {{{

  set encoding=UTF8

  " no error/visualbells
  set noeb vb t_vb =

  " folding
  set foldenable
  set foldlevelstart=99
  set foldmethod=syntax

  " persistent undo
  set undofile
  set undodir=$HOME/.vimundo
" }}}

" UI {{{
  syntax on
  set background=dark
  colorscheme base16-ocean

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
  set laststatus=2

  " Search {{{
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase
  " }}}

  if has("gui_running")
    if has('macunix')
      set guifont=Menlo:h13
      set linespace=1 " inline with terminal/sublime
    endif

    set guioptions-=T " disable tab bar
    set guioptions-=m " disable menu
    set guioptions-=r " disable right scroll bar
    set guioptions-=R " disable right scroll bar
    set guioptions-=l " disable left scroll bar
    set guioptions-=L " disable left scroll bar
  endif
" }}}

" File Handling {{{
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
    let g:fsnonewfiles = ''
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

  " Javascript Syntax {{{
    " should probably go somewhere else
    hi link jsFuncCall Function
    hi link jsObjectKey Special
    hi link jsFunctionKey Function
    hi link jsFuncAssignIdent Function
    hi link jsThis Identifier
    " if/switch/for/while same color
    hi link jsRepeat Conditional
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

    " Syntastic {{{
      let g:syntastic_always_populate_loc_list = 1
    " }}}
  endif

" }}}

