" Opens a terminal in a given split direction, starting in the directory of
" the file in the current window.
function! user#Term(splitcmd='new') abort
  if assert_match('^v\?new$', a:splitcmd) != 0
    echoerr v:errors
    return
  endif

  let l:pwd=expand('%:p:h')
  execute a:splitcmd
  call termopen([&shell], {'cwd': l:pwd})
endfunction


" Trims whitespace at the end of lines and, optionally, blank lines at the end
" of the file.
function! user#TrimWhitespace(trim_eof_lines=0) abort
  if (&filetype != 'diff' && &binary == 'nobinary')
    let l:view = winsaveview()
    keeppatterns %s/\s\+$//e

    if a:trim_eof_lines
      silent! keeppatterns g/^\n*\%$/d
    endif

    call winrestview(l:view)
  endif
endfunction


" Opens a floating, centered window of a given size (% of ui).
function! user#FloatWin(width=50, height=50) abort
  if assert_inrange(1, 100, a:width) != 0 || assert_inrange(1, 100, a:height) != 0
    echoerr v:errors
    return
  endif

  let l:ui = nvim_list_uis()[0]
  let l:width = float2nr(l:ui.width*a:width/100)
  let l:height = float2nr(l:ui.height*a:height/100)

  let l:opts = {
  \ 'relative': 'editor',
  \ 'width': l:width,
  \ 'height': l:height,
  \ 'col': (l:ui.width/2) - (l:width/2),
  \ 'row': (l:ui.height/2) - (l:height/2),
  \ 'border': 'single',
  \ 'style': 'minimal',
  \ }

  let l:buf = nvim_create_buf(v:false, v:true)
  let l:win = nvim_open_win(l:buf, 1, l:opts)

  call nvim_win_set_option(l:win, 'winhighlight', 'Normal:Normal')
endfunction

" Opens FZF starting in the directory of the current file
function! user#FzfHere()
  let l:here=expand('%:p:h')
  silent execute 'FZF' l:here
endfunction
