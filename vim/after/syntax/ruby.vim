syn match _rubyFunction /\(\.\)\@<=\w\+\((\)\@=/
hi link _rubyFunction Function

syn region rubyBlockParameterList matchgroup=Operator start="\%(\%(\<do\>\|{\)\_s*\)\@32<=|" end="|" oneline display contains=rubyBlockParameter
