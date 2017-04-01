runtime! ftplugin/text.vim

" Open Markdown files in Marked 2
nnoremap <buffer> <localleader>lv :!open -g -a "Marked 2" "%"<cr><cr>

set formatoptions-=or " don't insert comment leader after o,O or <Enter>

