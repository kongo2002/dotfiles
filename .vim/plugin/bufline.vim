" Name:         bufline.vim
" Author:       Gregor Uhlenheuer <kongo2002@googlemail.com>
" Last Change:  Di 26 Jan 2010 16:21:42 CET
"
" Description:  This script/plugin is heavily inspired by the miniBufExplorer
"               plugin by Bindu Wavell. I just played around with the idea and
"               tried to match it my needs. It became somewhat lean by
"               removing some stuff I do not need.

if exists('g:bufline_loaded')
  finish
endif
let g:bufline_loaded= 1

" VARIABLES {{{1

" -bufline- initialization
" do not open -bufline- on vim start
if !exists('g:bufline_autoup')
  let g:bufline_autoup = 0
  let g:bl_buflist = ''
  let g:bl_bufmap=''
  let g:bl_force_display = 0
  let g:bl_mutex = 0
endif

" FUNCTIONS {{{1

" bufline_start(): {{{2
" initializes and displays -bufline-
function! <SID>bufline_start(sticky, del_buf)
  if a:sticky == 1
    let g:bufline_autoup = 1
  endif

  " Store the current buffer
  let l:curBuf = bufnr('%')

  " Prevent a report of our actions from showing up.
  let l:save_rep = &report
  let l:save_sc  = &showcmd
  let &report    = 1000
  set noshowcmd

  call <SID>bufline_winfind('-bufline-')

  if bufname('%') != '-bufline-'
    let &report  = l:save_rep
    let &showcmd = l:save_sc
    return
  endif

  " set buffer options
  set noequalalways
  set nomousefocus
  setlocal foldcolumn=0
  setlocal nonumber

  if has("syntax")
    syn clear
    syn match BLNormal         '\[[^\]]*\]'
    syn match BLChanged        '\[[^\]]*\]+'
    syn match BLVisNormal      '\[[^\]]*\]\*+\='
    syn match BLVisChanged     '\[[^\]]*\]\*+'

    if !exists("g:did_bufline_syntax")
      hi def link BLNormal     Comment
      hi def link BLChanged    String
      hi def link BLVisNormal  StatusLineNC
      hi def link BLVisChanged Special
      let g:did_bufline_syntax= 1
    endif
  endif

  " open selected buffer on <CR>
  nnoremap <buffer> <CR> :call <SID>bufline_openbuf()<CR>:<BS>

  " <tab> navigation
  nnoremap <buffer> <TAB>   :call search('\[[0-9]*:[^\]]*\]')<CR>:<BS>
  nnoremap <buffer> <S-TAB> :call search('\[[0-9]*:[^\]]*\]','b')<CR>:<BS>

  " print buffer list
  call <SID>bufline_print(a:del_buf)

  if l:curBuf != -1
    call search('\['.l:curBuf.':'.expand('#'.l:curBuf.':t').'\]')
  endif

  let &report  = l:save_rep
  let &showcmd = l:save_sc

endfunction

" bufline_stop(): {{{2
" looks for -bufline- and closes the window if open
function! <SID>bufline_stop(sticky)
  if a:sticky == 1
    let g:bufline_autoup = 0
  endif

  let l:win_num = <SID>bufline_bufwin('-bufline-')

  if l:win_num != -1
    exec l:win_num.' wincmd w'
    silent! close
    wincmd p
  endif
endfunction

" bufline_toggle(): {{{2
" looks for -bufline- and opens/closes the window
function! <SID>bufline_toggle()
  let g:bufline_autoup = 0

  let l:win_num = <SID>bufline_bufwin('-bufline-')

  if l:win_num != -1
    call <SID>bufline_stop(1)
  else
    call <SID>bufline_start(1, -1)
    wincmd p
  endif
endfunction

" bufline_autoupdate(): {{{2
" function called by auto commands for auto updating -bufline-
function! <SID>bufline_autoupdate(del_buf)
  if g:bl_mutex == 1
    return
  else
    let g:bl_mutex = 1
  endif

  " Don't update the TabBar window
  if bufname('%') == '-bufline-'
    " If this is the only buffer left then toggle the buffer
    if winbufnr(2) == -1
      call <SID>bufline_cycle(1)
    endif

    let g:bl_mutex = 0
    return
  endif

  " only update when autoupdate flag is set
  if g:bufline_autoup == 1
    if bufnr('%') != -1 && bufname('%') != ""
      if <SID>bufline_realbuf(a:del_buf) == 1
        " if we don't have a window then create one
        let l:bufnr = <SID>bufline_bufwin('-bufline-')
        if l:bufnr == -1
          call <SID>bufline_start(0, a:del_buf)
        else
          " otherwise only update the window if the contents have changed
          let l:list_changed = <SID>bufline_buildlist(a:del_buf, 0)
          if l:list_changed
            call <SID>bufline_start(0, a:del_buf)
          endif
        endif

        " switch back to previous buffer
        if bufname('%') == '-bufline-'
          wincmd p
        endif
      else
        call <SID>bufline_stop(0)
      endif
    endif
  endif

  let g:bl_mutex = 0
endfunction

" bufline_bufwin(): {{{2
" return matching window id to given buffer name
function! <SID>bufline_bufwin(buf_name)
  let l:buf_nr = bufnr(a:buf_name)
  if l:buf_nr != -1
    return bufwinnr(l:buf_nr)
  else
    return -1
  endif
endfunction

" bufline_winfind(): {{{2
" attempts to find a window for a named buffer
function! <SID>bufline_winfind(buf_name)

  " split above
  let l:save_sb = &splitbelow
  let &splitbelow = 0

  " Try to find an existing explorer window
  let l:win_num = <SID>bufline_bufwin(a:buf_name)

  " If found goto the existing window, otherwise
  " split open a new window.
  if l:win_num != -1
    exec l:win_num.' wincmd w'
  else

    exec 'sp '.a:buf_name

    let g:bl_force_display = 1

    " Try to find an existing explorer window
    let l:win_num = <SID>bufline_bufwin(a:buf_name)
    if l:win_num != -1
      exec l:win_num.' wincmd w'
    else
      return
    endif

    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nowrap

  endif

  " restore 'splitbelow' setting
  let &splitbelow = l:save_sb

endfunction

" bufline_winresize(): {{{2
" resize -bufline- window to the size needed
function! <SID>bufline_winresize()

  if bufname('%') != '-bufline-'
    return
  endif

  " resize if necessary
  if winheight('.') != 1
      resize 1
  endif

  " jump to active window
  call search('\]\*', 'ew')

endfunction

" bufline_getbuf(): {{{2
" return the buffer id from buffer under the cursor
function! <SID>bufline_getbuf()
  if bufname('%') != '-bufline-'
    return -1
  endif

  let l:save_reg = @"
  let @" = ""
  normal! ""yi[
  if @" != ""
    let l:retv = substitute(@",'\([0-9]*\):.*', '\1', '') + 0
    let @" = l:save_reg
    return l:retv
  else
    let @" = l:save_reg
    return -1
  endif
endfunction

" bufline_print(): {{{2
" update -bufline- content and resize window if necessary
function! <SID>bufline_print(del_buf)
  if bufname('%') != '-bufline-'
    return
  endif

  setlocal modifiable

  let l:list_changed = <SID>bufline_buildlist(a:del_buf, 1)

  " rewrite buffer if forced or list has changed
  if l:list_changed == 1 || g:bl_force_display
    let l:save_rep = &report
    let l:save_sc = &showcmd
    let &report = 1000
    set noshowcmd

    " empty the whole buffer
    1,$d _

    " write list into buffer
    $
    put! =g:bl_buflist

    " delete remaining empty line
    $ d _

    let g:bl_force_display = 0
    let &report  = l:save_rep
    let &showcmd = l:save_sc
  endif

  " resize window if necessary
  call <SID>bufline_winresize()

  normal! zz

  setlocal nomodifiable
  setlocal nobuflisted
endfunction

" bufline_buildlist(): {{{2
" build the list for the -bufline- window
" return 1 if list has changed, 0 otherwise
" update g:bl_buflist if a:update == 1
function! <SID>bufline_buildlist(del_buf, update)
  let l:bufnum = bufnr('$')
  let l:i = 0
  let l:y = 0
  let l:fileNames = ''
  let g:bl_bufmap = ''

  " loop through all buffers
  while l:i <= l:bufnum
    let l:i += 1

    " If we have a del_buf and it is the current
    " buffer then ignore the current buffer.
    " Otherwise, continue.
    if a:del_buf == -1 || l:i != a:del_buf
      " Make sure the buffer in question is listed.
      if getbufvar(l:i, '&buflisted') == 1
        " Get the name of the buffer.
        let l:BufName = bufname(l:i)
        " Check to see if the buffer is a blank or not. If the buffer
        " does have a name, process it.
        if strlen(l:BufName)
          " Only show modifiable buffers (The idea is that we don't
          " want to show Explorers)
          if getbufvar(l:i, '&modifiable') == 1 && BufName != '-bufline-'
            " Get filename and remove [] and ()
            let l:shortBufName = fnamemodify(l:BufName, ":t")
            let l:shortBufName = substitute(l:shortBufName, '[][()]', '', 'g')
            let l:y += 1
            let g:bl_bufmap .= l:y . "-" . l:i . "\r"
            let l:tab = '['.l:y.':'.l:shortBufName." ]"

            " active buffer?
            if bufwinnr(l:i) != -1
              let l:tab = "[".l:y.':'.l:shortBufName."]*"
            endif

            " modified buffer?
            if getbufvar(l:i, '&modified') == 1
              let l:tab .= '+'
            endif

            let l:fileNames .= l:tab
          endif
        endif
      endif
    endif
  endwhile

  if g:bl_buflist != l:fileNames
    if a:update
      let g:bl_buflist = l:fileNames
    endif
    return 1
  else
    return 0
  endif
endfunction

" bufline_realbuf(): {{{2
" search for all listed buffers that are not 'delbuf' or
" the -bufline- buffer itself
function! <SID>bufline_realbuf(delbuf)
  let l:save_rep = &report
  let l:save_sc = &showcmd
  let &report = 1000
  set noshowcmd

  let l:bufnum = bufnr('$')
  let l:i        = 0
  let l:found    = 0
  let l:needed   = 2

  " loop through all buffers
  while l:i <= l:bufnum && l:found < l:needed
    let l:i += 1
    if a:delbuf == -1 || l:i != a:delbuf
      if getbufvar(l:i, '&buflisted') == 1
        let l:bufname = bufname(l:i)
        if strlen(l:bufname)
          if getbufvar(l:i, '&modifiable') == 1 && l:bufname != '-bufline-'
            let l:found += 1
          endif
        endif
      endif
    endif
  endwhile

  let &report  = l:save_rep
  let &showcmd = l:save_sc

  return (l:found >= l:needed)
endfunction

" bufline_bufswitch(): {{{2
" switch to the buffer with given index
function! <SID>bufline_bufswitch(bufNum)
  let l:vimbuf = <SID>id_to_map(a:bufNum)
  exec "b!" . l:vimbuf
endfunction

" bufline_openbuf(): {{{2
" open the buffer under the cursor from within -bufline-
function! <SID>bufline_openbuf()
  if bufname('%') != '-bufline-'
    return
  endif

  let l:save_rep = &report
  let l:save_sc  = &showcmd
  let &report    = 1000
  set noshowcmd

  let l:bufnr  = <SID>bufline_getbuf()
  if l:bufnr != -1

    let l:resize = 0
    let l:save_autoup = g:bufline_autoup
    let g:bufline_autoup = 0

    " switch to the previous window
    wincmd p

    " switch till non -bufline- buffer (max 4 times)
    if bufname('%') == '-bufline-'
      wincmd w
      if bufname('%') == '-bufline-'
        wincmd w
        if bufname('%') == '-bufline-'
          wincmd w
          " -bufline- is the only window left
          if bufname('%') == '-bufline-'
            let l:resize = 1
          endif
        endif
      endif
    endif

    call <SID>bufline_bufswitch(l:bufnr)
    if l:resize | resize | endif

    let g:bufline_autoup = l:save_autoup
    call <SID>bufline_autoupdate(-1)

  endif

  let &report  = l:save_rep
  let &showcmd = l:save_sc

endfunction

" bufline_cycle(): {{{2
" cycle through listed buffers in forward or backward direction
" depending on a:forward argument
function! <SID>bufline_cycle(forward)

  " there is only one window left
  let l:save_autoup = g:bufline_autoup
  if winbufnr(2) == -1
    resize
    let g:bufline_autoup = 0
  endif

  " switch buffer and save original and next buffer
  let l:orig_buf = bufnr('%')
  if a:forward == 1
    bn!
  else
    bp!
  endif
  let l:cur_buf = bufnr('%')

  " switch to next modifiable buffer
  while getbufvar(l:cur_buf, '&modifiable') == 0 && l:orig_buf != l:cur_buf
    if a:forward == 1
      bn!
    else
      bp!
    endif
    let l:cur_buf = bufnr('%')
  endwhile

  let g:bufline_autoup = l:save_autoup
  if l:save_autoup == 1
    call <SID>bufline_autoupdate(-1)
  endif
endfunction

" id_to_map(): {{{2
" convert tab id to buffer map
" format: [id:foo.c]
function! <SID>id_to_map(id)
  return substitute(g:bl_bufmap, '^.*'.a:id.'-\(\d\+\)\r.*$', '\1', '')
endfunction

" map_to_id(): {{{2
" convert buffer map to matching tab id
" format: [id:foo.c]
function! <SID>map_to_id(map)
  return substitute(g:bl_bufmap, '^.*\(\d\+\)-'.a:map.'\r.*$', '\1', '')
endfunction

" COMMANDS {{{1

if !exists(':BLstart')
  command! BLstart  call <SID>bufline_start(1, -1)
endif

if !exists(':BLstop')
  command! BLstop  call <SID>bufline_stop(1)
endif

if !exists(':BLau')
  command! BLau  call <SID>bufline_autoupdate(-1)
endif

if !exists(':BLtoggle')
  command! BLtoggle  call <SID>bufline_toggle()
endif

if !exists(':BLn')
  command! BLn call <SID>bufline_cycle(1)
endif
if !exists(':BLp')
  command! BLp call <SID>bufline_cycle(0)
endif

" AUTOCOMMANDS {{{1

augroup bufline
  autocmd bufline BufDelete * call <SID>bufline_autoupdate(expand('<abuf>'))
  autocmd bufline BufEnter * call <SID>bufline_autoupdate(-1)
  autocmd bufline VimEnter * let g:bufline_autoup = 1 |call <SID>bufline_autoupdate(-1)
augroup end
