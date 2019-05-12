let ruby_operators = 1

syn match Operator /\.\(class\)\@!/
syn match Operator /[?+*;,<>&!~=-]/
syn match Operator /||\||=\||\(\d\)\@=\||\(\w\)\@!\(.\{-\}|\)\@!/


syn match _rubyFunction /\(\.\|\s\|^\)\@<=\w\+\((\)\@=/

syn region ParenContainer   matchgroup=ContainerChars start=/(/ end=/)/ transparent
syn region BraceContainer   matchgroup=ContainerChars start=/{/ end=/}/ transparent
syn region BracketContainer matchgroup=ContainerChars start=/\[/ end=/\]/ transparent

hi link _rubyFunction Function
hi link rubyBangPredicateMethod Function
hi link rubyRoute Type
hi link rubyValidation Type

syn region rubyBlockParameterList matchgroup=Operator start="\%(\%(\<do\>\|{\)\_s*\)\@32<=|" end="|" oneline display contains=rubyBlockParameter

unlet b:current_syntax
syn include @SQL syntax/sql.vim
syn region sqlHeredoc start=/\v\<\<[-~]SQL/ end=/\vSQL/ keepend contains=@SQL
let b:current_syntax = "ruby"
