" Remove interface from future keys
syn clear   jsFutureKeys
syn keyword jsFutureKeys      final implements goto long synchronized volatile transient float boolean protected abstract native double short char enum throws byte int package

syn keyword tsAccessibility   public private
syn keyword tsPrimitives      string any number object
syn keyword tsInterface       interface nextgroup=tsInterfaceType,jsExtend skipwhite
syn keyword jsExtend          extends nextgroup=tsInterfaceType skipwhite
syn match   tsInterfaceType   /\w\+/ nextgroup=jsBlock skipwhite contained

syn keyword jsExport          export nextgroup=@jsAll,jsModuleGroup,jsExportDefault,jsModuleAsterisk,jsModuleKeyword,jsFlowTypeStatement,tsInterface  skipwhite skipempty
syn region  jsClassBlock      matchgroup=jsClassBraces start=/{/ end=/}/  contained extend fold contains=jsClassFuncName,jsClassMethodType,jsArrowFunction,jsArrowFuncArgs,jsComment,jsGenerator,jsDecorator,jsClassProperty,jsClassPropertyComputed,jsClassStringKey,jsAsyncKeyword,jsNoise,tsAccessibility
syn region  jsFuncArgs        matchgroup=jsFuncParens start=/(/ end=/)/  contains=jsFuncArgCommas,jsComment,jsFuncArgExpression,jsDestructuringBlock,jsDestructuringArray,jsRestExpression,jsFlowArgumentDef,tsVariableType nextgroup=jsCommentFunction,jsFuncBlock,jsFlowReturn,tsFuncReturnType skipwhite skipempty contained extend fold
"syn region jsCommentFunction start=+//+ end=/$/  contained keepend extend contains=jsCommentTodo,@Spell nextgroup=jsFuncBlock,jsFlowReturn skipwhite skipempty start=+/\*+ end=+\*/+  contained keepend extend fold contains=jsCommentTodo,@Spell nextgroup=jsFuncBlock,jsFlowReturn skipwhite skipempty
"syn match  jsClassFuncName   /\<\K\k*\ze\s*[(<]/  nextgroup=jsFuncArgs,jsFlowClassFunctionGroup skipwhite contained skipempty
syn match   jsVariableDef     /\<\K\k*/  nextgroup=jsFlowDefinition,tsVariableType skipwhite skipempty contained
syn match   jsBlockLabel      /\<\K\k*?\?\s*::\@!/  contains=jsNoise nextgroup=jsBlock skipwhite skipempty

syn match   tsVariableType    /:\s\+\w\+\(.\w\+\)*/ nextgroup=jsFlowDefinition contains=tsTypeDecl,tsType skipwhite contained
syn match   tsFuncReturnType  /:\s\+\w\+\(.\w\+\)*/ nextgroup=jsCommentFunction,jsFuncBlock,jsFlowReturn,jsFuncBraces contains=tsTypeDecl,tsType skipwhite contained
syn match   tsTypeDecl        /:/ contained nextgroup=tsType
syn match   tsType            /\w\+(\.\w\+)*/ contained

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
