syn match Operator /\.\((\)\@!/ " ignore type assertion
syn match Operator +/\(/\|*\)\@!+ " ignore comments
syn match Operator /[|:-?+*;,<>&!~=%*]/
hi link OperatorChars Operator
