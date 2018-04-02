" Common settings for text files (Markdown, LaTeX, ...)

setlocal spell
setlocal nocindent " prevent indentation after (), {, ...

" Add an undo point after every space and enter instead of just when exiting
" insert mode
inoremap <buffer> <Space> <Space><C-g>u
inoremap <buffer> <CR> <CR><C-g>u

setlocal formatoptions-=o " don't insert comment leader after o,O
setlocal formatoptions-=r " don't insert comment leader after <Enter>

set wrap      " Wrap lines longer than window width
set linebreak " Break up lines on a word boundary
