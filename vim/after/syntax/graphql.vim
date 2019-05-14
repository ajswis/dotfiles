
syn clear graphqlStructure
syn keyword graphqlStructure query mutation fragment nextgroup=graphqlName,graphqlNameWithArgs skipwhite

syn match graphqlNameWithArgs       "\<\h\w*\>\s*\((\)\@="

hi link graphqlName Special
hi link graphqlStructure Keyword
hi link graphqlNameWithArgs Function
