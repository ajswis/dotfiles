syn match _rubyFunction /\(\.\|\s\|^\)\@<=\w\+\((\)\@=/
hi link _rubyFunction Function
hi link rubyRoute Type
hi link rubyValidation Type

syn region rubyBlockParameterList matchgroup=Operator start="\%(\%(\<do\>\|{\)\_s*\)\@32<=|" end="|" oneline display contains=rubyBlockParameter
