set wildignore+=.DS_Store
set wildignore+=.git
set wildignore+=node_modules
set wildignore+=lib

" Latex
set wildignore+=*.aux
set wildignore+=*.bbl
set wildignore+=*.blg
set wildignore+=*.fdb_latexmk
set wildignore+=*.fls
set wildignore+=*.idx
set wildignore+=*.ind
set wildignore+=*.ilg
set wildignore+=*.lof
set wildignore+=*.lol
set wildignore+=*.lot
set wildignore+=*.out
set wildignore+=*.synctex.gz
set wildignore+=*.tdo
set wildignore+=*.toc

" Python
set wildignore+=*.pyc
set wildignore+=__pycache__

" Netrw
let s:ignore_regex = map(split(&wildignore, ','), 'substitute(v:val, "\*", ".*\\", "g")')
let g:netrw_list_hide=join(s:ignore_regex, ',')
