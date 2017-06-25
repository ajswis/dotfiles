hi def link     goMethodCall        Function
hi def link     goFunctionCall      Function

if !exists("g:go_highlight_fields")
  let g:go_highlight_fields = 0
endif
if g:go_highlight_fields != 0
  syn match goField                 /\(\.\)\@<=\w\+\([.\ \n\r\:\)\[,]\)\@=/
endif

if !exists("g:go_highlight_functions")
  let g:go_highlight_functions = 0
endif
if g:go_highlight_functions != 0
  " Why no work when not directly in vim-go/syntax/go.vim? :(
  syn match goReceiver             /\((\)\@<=\zs\(\w\|[ *]\)\+\ze\()\)\@=/ contained nextgroup=goFunction contains=goReceiverVar skipwhite skipnl
endif

if !exists("g:go_highlight_types")
  let g:go_highlight_types = 0
endif
if g:go_highlight_types != 0
  " Also doesn't work, again only when not directly in vim-go/syntax/go.vim
  syn match goTypeConstructor      /\zs\<\w\+\ze\({\)\@=/
endif
