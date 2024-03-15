" ================================ Colors =============================
" Color Sceme Emerald
" Use :so $VIMRUNTIME/syntax/hitest.vim to preview
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  hi   ColorColumn  guibg=#062909 guifg=NONE    gui=NONE
  hi   Comment      guifg=#BBE0E6 guibg=#1A2F23
  hi   Conceal      guifg=#BBE0E6
  hi   Constant     guifg=#9cb39d
  hi   Cursor       guifg=NONE    guibg=#026228 gui=BOLD
  hi   CursorLine   guibg=NONE    guifg=NONE    gui=underline
  hi   CursorLineNr guibg=#062909 guifg=#26c06d gui=NONE
  hi   EndOfBuffer  guibg=NONE    guifg=#026228 gui=NONE
  hi   ErrorMsg     guibg=darkred guifg=#BBE0E6 gui=NONE
  hi   Ignore       guifg=#000000
  hi   LineNr       guibg=NONE    guifg=#00a100 gui=NONE
  hi   ModeMsg      guibg=#062909 guifg=#678472 gui=NONE
  hi   NonText      guibg=NONE    guifg=#678472 gui=NONE
  hi   Pmenu        guibg=#000000 guifg=#026228 gui=NONE
  hi   PmenuSbar    guibg=#000000 guifg=NONE    gui=NONE
  hi   PmenuSel     guibg=#000000 guifg=#678472 gui=NONE
  hi   PmenuThumb   guibg=#026228 guifg=#026228 gui=NONE
  hi   PreProc      guifg=#BEE6E3
  hi   Search       guibg=#062909 guifg=#678472 gui=reverse
  hi   Statement    guifg=#26c06d
  hi   StatusLine   guibg=NONE    guifg=#26c06d gui=BOLD
  hi   StatusLineNC guibg=#26c06d guifg=#062909 gui=BOLD
  hi   TabLine      guifg=#26c06d guibg=#062909 gui=BOLD
  hi   TabLineFill  guifg=#BDE1E6 guibg=NONE    gui=NONE
  hi   TabLineSel   guifg=#00a100 guibg=NONE    gui=BOLD
  hi   TermCursor   guifg=#26c06d guibg=#062909 gui=BOLD
  hi   Type         guifg=#1AA053
  hi   VertSplit    guibg=#678472 guifg=#062909 
  hi   Visual       guibg=#026228
  hi   WildMenu     guibg=#678472 guifg=#000000 gui=NONE
