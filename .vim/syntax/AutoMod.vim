" Vim syntax file
" Language:     AutoMod
" Maintainer:   Gregor Uhlenheuer
" Last Change:  Mi 03 Feb 2010 18:50:26 CET

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" synchronization settings
syn sync fromstart

" case sensitive matching
syn case match

" standard control statements
syn keyword mStatement break continue

syn keyword mRepeat while do until each for

syn keyword mConditional if then else

syn keyword mSystem function procedure return model modelsys pickup
syn keyword mSystem arriving leaving initialization passing retrieving
syn keyword mSystem blocked cleared start finish done

" todo statements
syn keyword mTodo TODO FIXME XXX contained

" control keywords
syn keyword mControl and as at but be by call case dec delimiter dispatch
syn keyword mControl filled free from get in inc insert into is move
syn keyword mControl nlt not of on open or order ordered preempt print
syn keyword mControl read remove result rotate save scale send set
syn keyword mControl schedule take terminate to translate travel use
syn keyword mControl wait with clone create bring choose claim increment
syn keyword mControl merge toggle without next along satisfying
syn keyword mControl among whose

" model specific keywords
syn keyword mModel a absolute ac all appending backorder color continuous
syn keyword mModel counter current day days deliver die down eof
syn keyword mModel finished first hr job last list load loads location
syn keyword mModel message min new nextclock nextof null ok one oneof
syn keyword mModel orderlist parentsys park parking pausecontinue percent
syn keyword mModel priority procindex reading relative resource sec schedjob
syn keyword mModel size space status theLoad theVehicle this time type
syn keyword mModel uniform up vehicle work writing substring remaining
syn keyword mModel amount align acceleration deceleration capacity
syn keyword mModel choice exponential greatest lognormal limit loadtype
syn keyword mModel max maximum minimum norm normal orientation random
syn keyword mModel previous state triangular weibull x y z total
syn keyword mModel path destination distance velocity line realclock

" constants
syn keyword mBool  true false

" color statements
syn keyword mColor  black blue cyan dkgray green ltblue ltgray ltgreen ltyellow
syn keyword mColor  magenta orange purple red white yellow brown

" 'at end' keyword
syn match mAtEnd display /\(at\s\+\)\@<=end\>/

" strings
syn region mString start=/"/ skip=/\\"/ end=/"/

" character strings
syn region mCharacter start=/'/ skip=/\\'/ end=/'/

" blocks
syn match mBlockError /^\s*\<end\>/
syn region mBlockInner matchgroup=mBlock start=/\<begin\>/ end=/^\s*\<end\>/ contains=ALLBUT,mBlock

" folding of procedures/functions/subroutines only
syn region mFold start=/^begin\>/ end=/^end\>/ transparent fold keepend containedin=ALL

" parantheses
syn match mParenError display /)/
syn region mParenInner  matchgroup=mParen start=/(/ end=/)/ contains=ALLBUT,mComment,mTodo,mParen

" operators
syn match mOperator display /[-+*/%=<>]\+/

" numbers
syn match mNumber display /\<\d*\.\?\d\+\>/

" constants
syn match mConstant display /\<\u\+\%(_*[0-9A-Z]\+\)*\>/

" nesting comments
syn region mComment matchgroup=mCommentInner start=/\/\*/ end=/\*\// contains=mComment,mTodo

" default highlighting
if version >= 508 || !exists("did_automod_syn_inits")
    if version <= 508
        let did_automod_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink mStatement  Function
    HiLink mBlock Function
    HiLink mRepeat Repeat
    HiLink mConditional Conditional
    HiLink mSystem Label
    HiLink mControl Statement
    HiLink mModel Type
    HiLink mBool Boolean
    HiLink mCharacter Character
    HiLink mString String
    HiLink mTodo Todo
    HiLink mComment Comment
    HiLink mCommentInner Comment
    HiLink mColor SpecialChar
    HiLink mParen Function
    HiLink mNumber Number
    HiLink mOperator Operator
    HiLink mConstant Constant
    HiLink mParenError Error
    HiLink mBlockError Error
    HiLink mAtEnd Type

    delcommand HiLink

endif

let b:current_syntax = "AutoMod"
