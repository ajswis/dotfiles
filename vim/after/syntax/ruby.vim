let ruby_operators = 1

syn match OperatorChars /\.\(class\)\@!/
syn match _rubyFunction /\(\.\|\s\|^\)\@<=\w\+\((\)\@=/

syn region ParenContainer   matchgroup=ContainerChars start=/(/ end=/)/ transparent
syn region BraceContainer   matchgroup=ContainerChars start=/{/ end=/}/ transparent
syn region BracketContainer matchgroup=ContainerChars start=/\[/ end=/\]/ transparent

hi link _rubyFunction Function
hi link rubyRoute Type
hi link rubyValidation Type

syn region rubyBlockParameterList matchgroup=Operator start="\%(\%(\<do\>\|{\)\_s*\)\@32<=|" end="|" oneline display contains=rubyBlockParameter
