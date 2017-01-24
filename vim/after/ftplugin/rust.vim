" exclude <
let delimitMate_matchpairs = "(:),[:],{:}"
" exclude '
let b:delimitMate_quotes="\""
compiler cargo
noremap <buffer> <F5> :make! build<CR>
