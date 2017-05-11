" Common settings for text files (Markdown, LaTeX, ...)

setlocal spell
setlocal nocindent " prevent indentation after (), {, ...

" quicker umlauts than <C-k> o:
" <C-s>: s for special
inoremap <buffer> <C-s>a ä
inoremap <buffer> <C-s>o ö
inoremap <buffer> <C-s>u ü
inoremap <buffer> <C-s>s ß

inoremap <buffer> <C-s>A Ä
inoremap <buffer> <C-s>O Ö
inoremap <buffer> <C-s>U Ü

" Add an undo point after every space and enter instead of just when exiting
" insert mode
inoremap <buffer> <Space> <Space><C-g>u
inoremap <buffer> <CR> <CR><C-g>u

setlocal formatoptions-=o " don't insert comment leader after o,O
setlocal formatoptions-=r " don't insert comment leader after <Enter>

set wrap      " Wrap lines longer than window width
set linebreak " Break up lines on a word boundary
