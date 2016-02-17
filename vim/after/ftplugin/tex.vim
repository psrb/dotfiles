runtime! ftplugin/text.vim

" Highlight current line in Skim
nnoremap <buffer> <silent> <leader>ls
            \ :silent
            \ !/Applications/Skim.app/Contents/SharedSupport/displayline
            \ -g -r <C-r>=line('.')<CR> "%<.pdf" "%"<CR>

