
runtime! ftplugin/text.vim

noremap <buffer> <silent> <leader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline -g -r <C-r>=line('.')<CR> "%<.pdf" "%"<CR>

