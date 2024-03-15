" ================================= Insert Shortcuts ==================

  imap {<cr> {<cr>}<c-o><s-o>
  imap [<cr> [<cr>]<c-o><s-o>
  imap (<cr> (<cr>)<c-o>  
  imap [[ [[  ]<c-o>F 
  imap (<space> (  )<c-o>F 
  imap {<space> {  }<c-o>F 
  imap <<space> <  ><c-o>F 
  imap "" ""<esc>F"a
  imap '' ''<esc>F'a
  imap `` ``<esc>F`a
  imap ( ()<esc>F(a
  imap [ []<esc>F[a
  imap { {}<esc>F{a
  imap < <><esc>F<a
  imap <<space> < 
  imap <%= <%=<space><space>%><c-o>F 
  imap <%<space> <%<space><space>%><c-o>F 
  imap \" \"\"<esc>F"a
  imap (s <esc>lmh`>a)<c-o>`h(  
  imap {s <esc>lmh`>a}<c-o>`h{  
  imap [s <esc>lmh`>a]<c-o>`h[  
  imap "s <esc>lmh`>a"<c-o>`h"  
  imap 's <esc>lmh`>a'<c-o>`h'  
  imap `s <esc>lmh`>a`<c-o>`h`  
  nmap <Leader>" mh/"<CR>x?"<CR>x`hh
  nmap <Leader>' mh/'<CR>x?'<CR>x`hh
  nmap <Leader>` mh/`<CR>x?`<CR>x`hh
  nmap <Leader>( mh/)<CR>x?(<CR>x`hh
  nmap <Leader>{ mh/}<CR>x?{<CR>x`hh
  nmap <Leader>[ mh/]<CR>x?[<CR>x`hh
  nmap <Leader>< mh/><CR>x?<<CR>x`hh

" ================================= Visual Wrappers ==================

  vmap s' x<esc>i''<esc>p
  vmap s" x<esc>i""<esc>p
  vmap s` x<esc>i``<esc>p
  vmap s( x<esc>i(<esc>p
  vmap s[ x<esc>i[<esc>p
  vmap s{ x<esc>i{<esc>p
  vmap s< x<esc>i<<esc>p

"  Legacy Versions: 
"  vmap s' <esc>`>a'<c-o>`<'<esc>v`>l
"  vmap s" <esc>`>a"<c-o>`<"<esc>v`>l
"  vmap s` <esc>`>a`<c-o>`<`<esc>v`>l
"  vmap s[ <esc>`>a]<c-o>`<[<esc>v`>l
"  vmap s( <esc>`>a)<c-o>`<(<esc>v`>l
"  vmap s{ <esc>`>a}<c-o>`<{<esc>v`>l

" ================================= Case Manipulation ================

  function! s:Camelize(range) abort
    if a:range == 0
      s#\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2#g
    else
      s#\%V\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)\%V#\u\1\2#g
    endif
  endfunction

  function! s:Snakeize(range) abort
    if a:range == 0
      s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g
    else
      s#\%V\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)\%V#\l\1_\l\2#g
    endif
  endfunction

  command! -range Camelize silent! call <SID>Camelize(<range>)
  command! -range Snakeize silent! call <SID>Snakeize(<range>)

" ================================= Comments =========================
  
  function! ToggleComment()
    let pos=getpos(".")
    let win=winsaveview()
    if getline(".") =~ '\s*\# '
        normal! ^2x
        let pos[2]-=1
    else 
        normal! ^i# 
        let pos[2]+=3
    endif
    call winrestview(win)
    call setpos(".",pos)
    startinsert
  endfunction   
