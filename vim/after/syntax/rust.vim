"syn match rustType "\w\+\s{\@="
syn match rustField "\w\+\(: \)\@="

hi link rustCommentLineDoc SpecialComment
hi link rustCommentBlockDoc SpecialComment
hi link rustField Special


hi SpecialComment ctermfg=246 ctermbg=NONE cterm=NONE  guifg=#949494 guibg=NONE gui=NONE
hi rustAttribute ctermfg=cyan
hi rustDerive ctermfg=cyan
hi rustAssert ctermfg=red
hi rustPanic ctermfg=red
hi rustMacro ctermfg=magenta
