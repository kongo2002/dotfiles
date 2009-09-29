" Vim syntax file
" Language:     AutoMod
" Maintainer:   Gregor Uhlenheuer
" Last Change: Sep 29, 2009

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" synchronization settings
syn sync clear
syn sync fromstart

" case sensitive matching
syn case match

" standard control statements
syn keyword mStatement  begin end break continue

syn keyword mRepeat while do until each for

syn keyword mConditional    if then else

syn keyword mSystem function procedure return model modelsys pickup
syn keyword mSystem arriving leaving initialization passing retrieving
syn keyword mSystem blocked cleared start finish done

" todo statements
syn keyword mTodo   TODO FIXME XXX contained

" control keywords
syn keyword mControl    and as at but be by call case dec delimiter dispatch
syn keyword mControl    filled free from get in inc insert into is move
syn keyword mControl    nlt not of on open or order ordered preempt print
syn keyword mControl    read remove result rotate save scale send set
syn keyword mControl    schedule take terminate to translate travel use
syn keyword mControl    wait with clone create bring choose claim increment
syn keyword mControl    merge toggle without next along satisfying
syn keyword mControl    among whose

" model specific keywords
syn keyword mModel  absolute ac all appending backorder color continuous
syn keyword mModel  counter current day days deliver die down eof
syn keyword mModel  finished first hr job last list load loads location
syn keyword mModel  message min new nextclock nextof null ok one oneof
syn keyword mModel  orderlist parentsys park parking pausecontinue percent
syn keyword mModel  priority procindex reading relative resource sec schedjob
syn keyword mModel  size space status theLoad theVehicle this time type
syn keyword mModel  uniform up vehicle work writing substring remaining
syn keyword mModel  amount align acceleration deceleration capacity
syn keyword mModel  choice exponential greatest lognormal limit loadtype
syn keyword mModel  max maximum minimum norm normal orientation random
syn keyword mModel  previous state triangular weibull x y z
syn keyword mModel  path destination distance velocity

" constants
syn keyword mBool  true True TRUE false False FALSE

" color statements
syn keyword mColor  black blue cyan dkgray green ltblue ltgray ltgreen ltyellow
syn keyword mColor  magenta orange purple red white yellow brown

" strings
syn region mString start=/"/ skip=/\\"/ end=/"/

" character strings
syn region mCharacter start=/'/ skip=/\\'/ end=/'/

" parantheses
syn region mParenInner  matchgroup=mParen start=/(/ end=/)/ contains=ALLBUT,mComment,mTodo,mParen

" operators
syn match mOperator display "[-+*/%=]\+"

" numbers
" syn match mNumber display "[0-9]*\.\?[0-9]\+"
syn match mNumbers display transparent "\<\d\|\.\d" contains=mNumber
syn match mNumber display contained "\d\+"

" constants
syn match mConstant display "\s[A-Z]\+\([_-]*[A-Z]\+\)*\s"

" nesting comments
syn region mComment start=/\/\*/ end=/\*\// contains=mComment,mTodo

" default highlighting
hi def link mStatement  Function
hi def link mRepeat Function
hi def link mConditional    Function
hi def link mSystem Label
hi def link mControl    Statement
hi def link mModel  Type
hi def link mBool  Boolean
hi def link mCharacter  Character
hi def link mString String
hi def link mTodo   Todo
hi def link mComment    Comment
hi def link mColor  SpecialChar
hi def link mParen  Function
hi def link mNumber Number
hi def link mOperator Operator
hi def link mConstant   Constant
