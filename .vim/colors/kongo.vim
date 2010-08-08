" Name:         kongo.vim
" Description:  vim colorscheme
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>
" Last Change:  Sun 08 Aug 2010 01:19:07 PM CEST
" Version:      0.3

if version > 580
    hi clear
    if exists('syntax_on')
        syntax reset
    endif
endif
let g:colors_name = 'kongo'

" GENERAL APPEARANCE {{{1

" Normal        = normal text
" Cursor        = character under the cursor
" CursorIM      = cursor in IME mode
" CursorColumn  = screen column the cursor is in -> 'cursorcolumn'
" CursorLine    = screen line the cursor is in   -> 'cursorline'
" Visual        = visual mode selection
" VisualNOS     = visual mode selection (not owning the selection)
"                 (X11 GUI and xterm-clipboard only)
" Directory     = directory names (and special names in listings)

hi Normal           guifg=#e0e0e0       guibg=#202020
hi Normal           ctermfg=253         ctermbg=234
hi Cursor           guifg=bg            guibg=#969696
hi Cursor           ctermfg=bg          ctermbg=246
hi CursorIM         guifg=bg            guibg=#96cdcd
hi CursorIM         ctermfg=bg          ctermbg=80
hi CursorColumn     guifg=NONE          guibg=#151515      gui=none
hi CursorColumn     ctermfg=NONE        ctermbg=233        cterm=none
hi CursorLine       guifg=NONE          guibg=#151515      gui=none
hi CursorLine       ctermfg=NONE        ctermbg=233        cterm=none
hi Visual           guifg=NONE          guibg=#101010
hi Visual           ctermfg=NONE        ctermbg=232
hi VisualNOS        guifg=fg                               gui=underline
hi VisualNOS        ctermfg=fg                             cterm=underline
hi Directory        guifg=#9cd620                          gui=none
hi Directory        ctermfg=112                            cterm=none

" Pmenu       = normal item in popup
" PmenuSel    = selected item in popup
" PMenuSbar   = scrollbar in pop
" PMenuThumb  = thumb of the scrollbar in popup

hi Pmenu            guifg=#969696       guibg=#101010      gui=none
hi Pmenu            ctermfg=246         ctermbg=232        cterm=none
hi PmenuSel         guifg=#9cd620       guibg=#151515      gui=none
hi PmenuSel         ctermfg=112         ctermbg=233        cterm=none
hi PMenuSbar                            guibg=#505860      gui=none
hi PMenuSbar                            ctermbg=237        cterm=none
hi PMenuThumb                           guibg=#808890      gui=none
hi PMenuThumb                           ctermbg=244        cterm=none

" FoldColumn    = the '+' you can click when having folds
" Folded        = closed folds
" LineNr        = :set nu
" ModeMsg       = -- INSERT --
" NonText       = everything below EOF
" SignColumn    = left from the 'LineNr' when enabled
" StatusLine    = active statusline
" StatusLineNC  = unactive statuslines
" VertSplit     = vert split seperator
" WildMenu      = current match in 'wildmenu' completion

hi Folded           guifg=#969696       guibg=#101010      gui=none
hi Folded           ctermfg=246         ctermbg=232        cterm=none
hi FoldColumn       guifg=#969696       guibg=#101010      gui=none
hi FoldColumn       ctermfg=246         ctermbg=232        cterm=none
hi LineNr           guifg=#969696       guibg=#101010
hi LineNr           ctermfg=246         ctermbg=232
hi ModeMsg          guifg=#b3b3b3       guibg=NONE         gui=none
hi ModeMsg          ctermfg=249         ctermbg=NONE       cterm=none
hi NonText          guifg=#000000                          gui=none
hi NonText          ctermfg=16                             cterm=none
hi SignColumn       guifg=#969696       guibg=#101010      gui=none
hi SignColumn       ctermfg=246         ctermbg=232        cterm=none
hi StatusLine       guifg=#e0e0e0       guibg=#101010      gui=bold
hi StatusLine       ctermfg=253         ctermbg=232        cterm=bold
hi StatusLineNC     guifg=#757575       guibg=#2d2d2d      gui=none
hi StatusLineNC     ctermfg=243         ctermbg=236        cterm=none
hi VertSplit        guifg=#969696       guibg=#101010      gui=none
hi VertSplit        ctermfg=246         ctermbg=232        cterm=none
hi WildMenu         guifg=#9cd620       guibg=#101010      gui=bold
hi WildMenu         ctermfg=112         ctermbg=232        cterm=bold

" ErrorMsg      = error message in the command line
" WarningMsg    = warning message in the commmand line
" MoreMsg       = -- More --
" Question      = prompt and yes/no question
" SpecialKey    = 'listchars' and special/map keys in :map
" Title         = titles in :set all, :autocmd etc.

hi ErrorMsg         guifg=#d70000       guibg=#151515      gui=none
hi ErrorMsg         ctermfg=160         ctermbg=233       cterm=none
hi WarningMsg       guifg=#de4900                          gui=none
hi WarningMsg       ctermfg=166                            cterm=none
hi MoreMsg          guifg=#a28700                          gui=none
hi MoreMsg          ctermfg=178                            cterm=none
hi Question         guifg=fg                               gui=none
hi Question         ctermfg=fg                             cterm=none
hi SpecialKey       guifg=#3e3e3e
hi SpecialKey       ctermfg=237
hi Title            guifg=#a28700                          gui=bold
hi Title            ctermfg=178                            cterm=bold

" Tabline       = not active tab
" TablineFill   = no tab
" TablineSel    = active tab

hi TabLine          guifg=#e0e0e0       guibg=#151515      gui=none
hi TabLine          ctermfg=253         ctermbg=233        cterm=none
hi TabLineFill      guifg=#e0e0e0       guibg=#2d2d2d      gui=none
hi TabLineFill      ctermfg=253         ctermbg=236        cterm=none
hi TabLineSel       guifg=#e1e1e1       guibg=#101010      gui=bold
hi TabLineSel       ctermfg=255         ctermbg=232        cterm=none

" IncSearch  = incremental search
" Search     = found matches -> 'hlsearch'
" MatchParen = paired bracket and its match

hi IncSearch        guifg=#9cd620                          gui=reverse
hi IncSearch        ctermfg=112                            cterm=reverse
hi Search           guifg=#000000       guibg=#9cd620      gui=none
hi Search           ctermfg=16          ctermbg=112        cterm=none
hi MatchParen       guifg=#ff0000       guibg=NONE         gui=bold
hi MatchParen       ctermfg=196         ctermbg=NONE       cterm=bold

" SpellBad      = word is not recognized
" SpellCap      = word should start with capital
" SpellRare     = word is hardly ever used
" SpellLocal    = word is used in another region

hi SpellBad         guisp=#ee0000                          gui=undercurl
hi SpellBad         ctermfg=160                            cterm=reverse
hi SpellCap         guisp=#eeee00                          gui=undercurl
hi SpellCap         ctermfg=208                            cterm=reverse
hi SpellRare        guisp=#ffa500                          gui=undercurl
hi SpellRare        ctermfg=130                            cterm=reverse
hi SpellLocal       guisp=#ffa500                          gui=undercurl
hi SpellLocal       ctermfg=130                            cterm=reverse

" DiffAdd     = added line
" DiffChange  = changed line
" DiffDelete  = removed line
" DiffText    = changed characters

hi DiffAdd          guifg=#e0e0e0       guibg=#324900      gui=none
hi DiffAdd          ctermfg=253         ctermbg=22         cterm=none
hi DiffChange       guifg=NONE          guibg=#3B4865      gui=none
hi DiffChange       ctermfg=NONE        ctermbg=67         cterm=none
hi DiffDelete       guifg=#e0e0e0       guibg=#3A0200      gui=none
hi DiffDelete       ctermfg=253         ctermbg=52         cterm=none
hi DiffText         guifg=#e0e0e0       guibg=#324900      gui=none
hi DiffText         ctermfg=253         ctermbg=22         cterm=none

" SYNTAX HIGHLIGHTING {{{1

hi Comment          guifg=#606060                          gui=none
hi Comment          ctermfg=240                            cterm=none
hi Constant         guifg=#980c0f                          gui=none
hi Constant         ctermfg=88                             cterm=none
hi String           guifg=#d54817                          gui=none
hi String           ctermfg=202                            cterm=none
hi StringDelimiter  guifg=#980c0f                          gui=none
hi StringDelimiter  ctermfg=88                             cterm=none
hi Character        guifg=#980c0f                          gui=none
hi Character        ctermfg=88                             cterm=none
hi Number           guifg=#e7820f                          gui=none
hi Number           ctermfg=208                            cterm=none
hi Boolean          guifg=#98320c                          gui=none
hi Boolean          ctermfg=130                            cterm=none
hi Float            guifg=#e7820f                          gui=none
hi Float            ctermfg=208                            cterm=none
hi Identifier       guifg=#ffae25                          gui=none
hi Identifier       ctermfg=214                            cterm=none
hi Function         guifg=#ffae25                          gui=none
hi Function         ctermfg=214                            cterm=none
hi Statement        guifg=#9cd620                          gui=none
hi Statement        ctermfg=112                            cterm=none
hi Conditional      guifg=#9cd620                          gui=none
hi Conditional      ctermfg=112                            cterm=none
hi Exception        guifg=#62a216                          gui=none
hi Exception        ctermfg=64                             cterm=none
hi Repeat           guifg=#9cd620                          gui=none
hi Repeat           ctermfg=112                            cterm=none
hi Label            guifg=#25a0ff                          gui=none
hi Label            ctermfg=39                             cterm=none
hi Operator         guifg=#25a0ff                          gui=none
hi Operator         ctermfg=39                             cterm=none
hi Keyword          guifg=#25a0ff                          gui=none
hi Keyword          ctermfg=39                             cterm=none
hi PreProc          guifg=#117ebf                          gui=none
hi PreProc          ctermfg=27                             cterm=none
hi Include          guifg=#117ebf                          gui=none
hi Include          ctermfg=27                             cterm=none
hi Define           guifg=#117ebf                          gui=none
hi Define           ctermfg=27                             cterm=none
hi Macro            guifg=#117ebf                          gui=none
hi Macro            ctermfg=27                             cterm=none
hi PreCondit        guifg=#117ebf                          gui=none
hi PreCondit        ctermfg=27                             cterm=none
hi Type             guifg=#d3d300                          gui=none
hi Type             ctermfg=226                            cterm=none
hi StorageClass     guifg=#9eb51e                          gui=none
hi StorageClass     ctermfg=106                            cterm=none
hi Structure        guifg=#9eb51e                          gui=none
hi Structure        ctermfg=106                            cterm=none
hi Typedef          guifg=#9eb51e                          gui=none
hi Typedef          ctermfg=106                            cterm=none
hi Special          guifg=#21d5e0                          gui=none
hi Special          ctermfg=44                             cterm=none
hi SpecialChar      guifg=#21d5e0                          gui=none
hi SpecialChar      ctermfg=44                             cterm=none
hi Tag              guifg=#21d5e0                          gui=none
hi Tag              ctermfg=44                             cterm=none
hi Delimiter        guifg=#21d5e0                          gui=none
hi Delimiter        ctermfg=44                             cterm=none
hi SpecialComment   guifg=#21d5e0                          gui=none
hi SpecialComment   ctermfg=44                             cterm=none
hi Debug            guifg=#21d5e0       guibg=NONE         gui=none
hi Debug            ctermfg=44          ctermbg=NONE       cterm=none
hi Underlined       guifg=fg                               gui=underline
hi Underlined       ctermfg=fg                             cterm=underline
hi Ignore           guifg=bg
hi Ignore           ctermfg=bg
hi Error            guifg=#f80c0c       guibg=bg           gui=reverse
hi Error            ctermfg=160         ctermbg=bg         cterm=reverse
hi Todo             guifg=#ffae25       guibg=bg           gui=reverse,bold
hi Todo             ctermfg=214         ctermbg=bg         cterm=reverse,bold

" SPECIAL GROUPS {{{1

hi MyTagListFileName  guifg=#969696       guibg=#101010      gui=none
hi MyTagListFileName  ctermfg=246         ctermbg=232        cterm=none

if exists('+colorcolumn')
    hi ColorColumn     guifg=NONE          guibg=#242424      gui=none
    hi ColorColumn     ctermfg=NONE        ctermbg=235        cterm=none
endif

" vim: set fdm=marker foldmarker={{{,}}}
