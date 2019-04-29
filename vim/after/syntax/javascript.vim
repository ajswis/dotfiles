" Remove interface from future keys
syn clear   jsFutureKeys
syn keyword jsFutureKeys      final implements goto long synchronized volatile transient float boolean protected abstract native double short char enum throws byte int package

syn keyword tsAccessibility   public private
syn keyword tsPrimitives      string any number object void
syn keyword tsInterface       interface nextgroup=tsInterfaceType,jsExtend skipwhite
syn keyword jsExtend          extends nextgroup=tsInterfaceType,tsType skipwhite
syn match   tsInterfaceType   /\w\+/ nextgroup=jsBlock skipwhite contained

syn cluster tsKeyword         contains=@jsFutureKeys,tsAccessibility,tsPrimitives,tsInterface,jsExtend

syn keyword jsExport          export nextgroup=@jsAll,jsModuleGroup,jsExportDefault,jsModuleAsterisk,jsModuleKeyword,jsFlowTypeStatement,tsInterface  skipwhite skipempty
syn region  jsClassBlock      matchgroup=jsClassBraces start=/{/ end=/}/  contained extend fold contains=jsClassFuncName,jsClassMethodType,jsArrowFunction,jsArrowFuncArgs,jsComment,jsGenerator,jsDecorator,jsClassProperty,jsClassPropertyComputed,jsClassStringKey,jsAsyncKeyword,jsNoise,tsAccessibility
syn match   jsArrowFuncArgs   /\<\K\k*\ze\s*=>/  extend contains=jsFuncArgs,tsPrimitives nextgroup=jsArrowFunction skipwhite skipempty
syn region  jsParen           matchgroup=jsParens start=/(/ end=/)/  extend fold contains=@jsExpression,tsVariableType,tsPrimitives nextgroup=jsFlowDefinition,tsVariableType
syn region  jsFuncArgs        matchgroup=jsFuncParens start=/(/ end=/)/  contains=jsFuncArgCommas,jsComment,jsFuncArgExpression,jsDestructuringBlock,jsDestructuringArray,jsRestExpression,jsFlowArgumentDef,tsVariableType,tsPrimitives,jsOperator  nextgroup=jsCommentFunction,jsFuncBlock,jsFlowReturn,tsFuncReturnType skipwhite skipempty contained extend fold
"syn region jsCommentFunction start=+//+ end=/$/  contained keepend extend contains=jsCommentTodo,@Spell nextgroup=jsFuncBlock,jsFlowReturn skipwhite skipempty start=+/\*+ end=+\*/+  contained keepend extend fold contains=jsCommentTodo,@Spell nextgroup=jsFuncBlock,jsFlowReturn skipwhite skipempty
"syn match  jsClassFuncName   /\<\K\k*\ze\s*[(<]/  nextgroup=jsFuncArgs,jsFlowClassFunctionGroup skipwhite contained skipempty
syn match   jsVariableDef     /\<\K\k*/  nextgroup=jsFlowDefinition,tsVariableType skipwhite skipempty contained
syn match   jsBlockLabel      /\<\K\k*?\?\s*::\@!/  contains=jsNoise nextgroup=jsBlock skipwhite skipempty

"syn region jsClassDefinition  start=/\<class\>/ end=/\(\<extends\>\s\+\)\@<!{\@=/  contains=jsClassKeyword,jsExtendsKeyword,jsClassNoise,@jsExpression,jsFlowClassGroup,tsType,tsTypeArgAngleBrackets nextgroup=jsCommentClass,jsClassBlock,jsFlowClassGroup skipwhite skipempty
syn region jsClassDefinition  start=/\<class\>/ end=/\(\<extends\>\s\+\)\@<!{\@=/  contains=jsClassKeyword,jsExtendsKeyword,jsClassNoise,@jsExpression,jsFlowClassGroup,tsPrimitives nextgroup=jsCommentClass,jsClassBlock,jsFlowClassGroup skipwhite skipempty

syn match   tsVariableType    /:\s\+\w\+\(.\w\+\)*/ nextgroup=jsFlowDefinition contains=tsTypeDecl,tsType,tsPrimitives,tsTypeArg skipwhite contained
syn match   tsFuncReturnType  /:\s\+\w\+\(.\w\+\)*/ nextgroup=jsCommentFunction,jsFuncBlock,jsFlowReturn,jsFuncBraces,tsTypeArg contains=tsTypeDecl,tsType,tsTypeArg skipwhite contained
syn match   tsTypeDecl        /:/ contained nextgroup=tsType
syn match   tsType            /\w\+(\.\w\+)*/ nextgroup=tsTypeArg contained
syn region  tsTypeArg         start=/</ end=/>/ matchgroup=tsTypeArgAngleBrackets contains=tsType,tsTypeArg,tsPrimitives,tsKeyword nextgroup=jsCommentFunction,jsFuncBlock,jsFlowReturn,jsFuncBraces skipwhite contained

" Override the default definitions, adding/removing as necessary
syn cluster jsAll           contains=@jsExpression,jsStorageClass,jsConditional,jsRepeat,jsReturn,jsException,jsTry,jsNoise,jsBlockLabel,tsPrimitives

hi link jsObjectKey Special
hi link jsClassDefinition Type
hi link jsFutureKeys Keyword
hi link tsInterface Keyword
hi link tsAccessibility Keyword
hi link jsExtend Keyword
hi link tsInterfaceType Type
hi link tsPrimitives Special
hi link tsType Type
hi link tsFuncReturnType tsType
hi link tsVariableType tsType
hi link tsKeyword special
