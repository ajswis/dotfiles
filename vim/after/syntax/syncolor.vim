hi MatchParen ctermfg=160 ctermbg=NONE cterm=underline guifg=#df0000 guibg=NONE gui=underline
hi ContainerChars ctermfg=208 ctermbg=NONE cterm=NONE guifg=#fd971f guibg=NONE gui=NONE

syn region ParenContainer   matchgroup=ContainerChars start=/(/ end=/)/ transparent fold
syn region BraceContainer   matchgroup=ContainerChars start=/{/ end=/}/ transparent fold
syn region BracketContainer matchgroup=ContainerChars start=/\[/ end=/\]/ transparent fold
