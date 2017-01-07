"highlight Functions
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunctions gui=NONE ctermfg=blue

syn match cMathOperator display "[\-\+\*\%\=\/\.\<\>\?\&\!\|]"
hi cMathOperator cterm=bold ctermfg=2



