" Set file types before default file type autocommands are sourced
" See 'help new-filetype' section C for more details

if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead requirements*.txt setfiletype requirements
augroup END
