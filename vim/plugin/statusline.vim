" If the given value is not empty either the value itself or the optional
" third argument will be added to the list.
function! s:addNotEmpty(array, value, ...)
  if !empty(a:value)
      call add(a:array, a:0 > 0 ? a:1 : a:value)
  endif
endfunction

" Returns general file info: type, encoding, format
function! StatusLineFileInfo()
  let l:infos = []

  call s:addNotEmpty(l:infos, &filetype)
  call add(l:infos, empty(&fileencoding) ? &encoding : &fileencoding)
  call add(l:infos, &fileformat)

  return printf('[%s]', join(l:infos, ','))
endfunction

" Returns the current tag (class,method,function signature) given that Tagbar
" is installed.
function! StatusLineCurrentTag()
  if exists(':Tagbar')
      return tagbar#currenttag('%s','','f')
  endif

  return ''
endfunction

"-----------------------------------------------------------------------------
" Ale Linting
"-----------------------------------------------------------------------------

" Helper for displaying the current linting progress in the status line.
" The vim running is needed so that redrawstatus is only called after vim is
" fully initialized! Otherwise there are some glitches in the UI.
let s:vim_running = 0
let s:ale_running = 0

augroup ALEProgress
  autocmd!
  autocmd VimEnter * let s:vim_running = 1
  autocmd User ALELintPre  let s:ale_running = 1 | if s:vim_running | redrawstatus | endif
  autocmd User ALELintPost let s:ale_running = 0 | if s:vim_running | redrawstatus | endif
augroup end


" Returns the number of errors and warnings found by ale given that ale is
" installed.
function! StatusLineLintingStatus()
  " TODO Figure out if linter is not installed and display warning!
  if !exists(':ALELint') || empty(ale#linter#Get(&filetype))
    return ''
  endif

  if s:ale_running
    return '[Linting]'
  endif

  let l:problems = ale#statusline#Count(bufnr('%'))
  let l:errors = l:problems['error'] + l:problems['style_error']
  let l:warnings = l:problems['warning'] + l:problems['style_warning']
  let l:info = l:problems['info']

  let l:formatted_output = []
  call s:addNotEmpty(l:formatted_output, l:errors, 'E: '.l:errors)
  call s:addNotEmpty(l:formatted_output, l:warnings, 'W: '.l:warnings)
  call s:addNotEmpty(l:formatted_output, l:info, 'I: '.l:info)

  if empty(l:formatted_output)
    return '[OK]'
  endif

  return printf('[%s]', join(l:formatted_output))
endfunction
