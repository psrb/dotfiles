" vim: sw=2 ts=2 sts=2 et fmr={{{,}}} fdm=marker fdl=0
scriptencoding utf-8

" The environment variable VIM_LIGHT_INSTALL controls wether all plugins
" should be installed (e.g. plugins that have external dependencies or
" should only be on main machines and not on servers)
let g:isFullInstall = 1
if $VIM_LIGHT_INSTALL != ""
  let g:isFullInstall = 0
endif

" Plug setup {{{
  call plug#begin('~/.vim/plugged')
  Plug 'chriskempson/base16-vim'
  Plug 'bling/vim-airline'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus',
              \'NERDTreeToggle']}

  " autoclosing of brackets, quotes, etc.
  Plug 'Raimondi/delimitMate'

  " make surroundings repeatable
  Plug 'tpope/vim-repeat'
  " motions for surrounding text objects with brackets, quotes, etc.
  Plug 'tpope/vim-surround'

  " commands for toggling of comments
  Plug 'tomtom/tcomment_vim'

  " git plugin
  Plug 'tpope/vim-fugitive'

  " show git diff in the number column
  Plug 'airblade/vim-gitgutter'

  " dependency for vim-session
  Plug 'xolox/vim-misc'
  " Nice session management
  Plug 'xolox/vim-session'

  " also better highlights for c
  Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}

  " sane buffer closing
  Plug 'vim-scripts/bufkill.vim'

  " improved syntax highlighting for javascript
  Plug 'pangloss/vim-javascript', {'for': ['javascript', 'html']}

  " live preview of complex regex searches
  Plug 'haya14busa/incsearch.vim'

  if g:isFullInstall
    " deps: compiled component
    Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer'}

    " syntax checking
    Plug 'scrooloose/syntastic'

    " switch between header/sources files
    Plug 'derekwyatt/vim-fswitch', {'for': ['c', 'cpp']}

    " external deps: clang format
    Plug 'rhysd/vim-clang-format', {'for': ['c', 'cpp']}

    " syntax highlighting, autocomplete and more nice things for go
    Plug 'fatih/vim-go', {'for': 'go'}

    " external deps: ctags
    Plug 'majutsushi/tagbar'

    " autocomplete for javascript
    " external deps: nodejs + extra npm install
    Plug 'marijnh/tern_for_vim', {'do': 'npm install',
          \ 'for': ['javascript', 'html']}

    " glsl shader language syntax definitions
    Plug 'tikhomirov/vim-glsl', {'for': 'glsl'}

    " essential for markdown editing. external deps: pandoc
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'godlygeek/tabular'
  endif
  call plug#end()
" }}}

" General {{{
  set encoding=UTF8

  " disable the visual/error bells
  set noerrorbells
  " and enable visual bell, but clear the visual bell character
  set visualbell t_vb =

  " folding
  set foldenable
  set foldlevelstart=99
  set foldmethod=syntax

  " persistent undo
  set undofile
  set undodir=$HOME/.vimundo
" }}}

" UI {{{
  set title " Display the current file and path as the title
  set showcmd " show incomplete command in status bar

  set splitright " new vertical splits always to the right
  set splitbelow " new horizontal splits always below
  set laststatus=2 "always show the status line

  " better commandline completion
  set wildmenu
  set wildmode=list:longest,full

  " Editor {{{
    syntax on
    set background=dark
    colorscheme base16-ocean

    set number " line numbers
    set ruler " position  of cursor
    set colorcolumn=+1 " highlight one column after textwidth
    set cursorline " highlight the line of the cursor

    " show tabs, trailing spaces, non-breaking spaces and line wraps
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

    if has("gui_running")
      if has('macunix')
        set guifont=Menlo:h13
        set linespace=1 " same as terminal/sublime
      endif

      set guioptions-=T " disable tab bar
      set guioptions-=m " disable menu
      set guioptions-=r " disable right scroll bar
      set guioptions-=R " disable right scroll bar
      set guioptions-=l " disable left scroll bar
      set guioptions-=L " disable left scroll bar
    endif
  " }}}
" }}}

" File Handling {{{
  set autoread
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

" Search {{{
  set hlsearch
  set incsearch
  set ignorecase
  set smartcase
" }}}

" Functions {{{

  " Display the syntax highlight groups for word under cursor
  function! SynStack()
    if !exists('*synstack')
      return
    endif
    echo map(synstack(line('.'), col('.')), "synIDattr(v:val, 'name')")
  endfunc

  " Open a new MacVim instance in my notes directory
  function! s:openNotes()
    if has('macunix')
      call system("mvim +cd~/Dropbox/Notes")
    endif
  endfunction
  command! OpenNotes :call s:openNotes()

  " Switch between dark and light colorschemes
  function! s:toggleLightColorscheme()
    if &background ==? "light"
      set background=dark
      colorscheme base16-ocean
    else
      set background=light
      colorscheme base16-solarized
    endif
  endfunc
  command! ToggleLightColorscheme :call s:toggleLightColorscheme()

" }}}

" Key mappings {{{

  " better movement between windows
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

  " resize active window to 60% of the window width
  nnoremap <silent> <Leader>r :exe "vertical resize " .
        \ string(round(&columns * 0.60))<CR>

  " make j/k useful for long lines
  nnoremap j gj
  nnoremap k gk

  " center cursor on forward/backwards jumps
  nnoremap <C-b> <C-b>zz
  nnoremap <C-f> <C-f>zz

  " making saving easier
  nnoremap <Leader>w :w<cr>

  " 'sudo save'
  cnoremap w!! w !sudo tee % >/dev/null

  " Newlines above/below current line without leaving normal mode
  nnoremap <silent> zk O<Esc>j
  nnoremap <silent> zj o<Esc>k

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
  nnoremap <F2> :source $MYVIMRC<cr>:echom "vimrc reloaded"<cr>

" }}}

" Plugins {{{

  " DelimitMate {{{
    " exclude `
    let delimitMate_quotes = "\" '"
    " put closing bracket on seperate line after enter
    let g:delimitMate_expand_cr = 1
  " }}}

  " NerdTree {{{
    let NERDTreeShowHidden = 1
    let NERDTreeIgnore = ['^\.git$', '^\.DS_Store$', '\.pyc$']

    noremap <silent> <Leader>o :NERDTreeToggle<CR>
  " }}}

  " Airline {{{
    " show current branch in status line (req. Fugitive)
    let g:airline#extensions#branch#enabled = 1

    " show buffers on the top of the window
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
    nnoremap <Leader>h :FSHere<CR>
    let g:fsnonewfiles = ''
  " }}}

  " Session {{{
    let g:session_autosave = "yes"
    let g:session_autoload = "no"
    let g:session_command_aliases = 1
  " }}}

  " Bufkill {{{
    nnoremap <silent> <Leader>bd :BD<CR>
  " }}}

  " Incsearch {{{
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
  "}}}

  " CTRLP {{{
    " ctrlp on the top of the window instead on of the bottom
    let g:ctrlp_match_window_bottom   = 0
    let g:ctrlp_match_window_reversed = 0
  " }}}

  if g:isFullInstall
    " YouCompleteMe {{{
      let g:ycm_global_ycm_extra_conf = "~/.dotfiles/ycm_extra_conf.py"
      let g:ycm_autoclose_preview_window_after_insertion = 1

      nnoremap <silent> <Leader>yg :YcmCompleter GoTo<CR>
      nnoremap <silent> <Leader>yc :YcmCompleter GoToDeclaration<CR>
      nnoremap <silent> <Leader>yf :YcmCompleter GoToDefinition<CR>
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

    " Pandoc {{{
      let g:pandoc#syntax#conceal#use=0
      let g:pandoc#folding#fdc=0
      let g:pandoc#spell#enabled=0
      let g:pandoc#modules#disabled = ["chdir"]
    " }}}
  endif

" }}}
