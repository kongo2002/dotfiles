" Name:         kongo3.vim
" Description:  vim colorscheme
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>
" Last Change:  Tue 28 Oct 2014 12:27:36 AM CET
" Version:      0.1

if version > 580
    hi clear
    if exists('syntax_on')
        syntax reset
    endif
endif
let g:colors_name = 'kongo3'

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

hi Normal           guifg=#e2e2e5       guibg=#000000
hi Normal           ctermfg=253         ctermbg=0
hi Cursor           guifg=NONE          guibg=#626262
hi Cursor           ctermfg=NONE        ctermbg=241
hi CursorIM         guifg=bg            guibg=#96cdcd
hi CursorIM         ctermfg=bg          ctermbg=80
hi CursorColumn     guifg=NONE          guibg=#181818      gui=none
hi CursorColumn     ctermfg=NONE        ctermbg=233        cterm=none
hi CursorLine       guifg=NONE          guibg=#181818      gui=none
hi CursorLine       ctermfg=NONE        ctermbg=233        cterm=none
hi Visual           guifg=#ffffaf       guibg=#3c414c
hi Visual           ctermfg=229         ctermbg=235
hi VisualNOS        guifg=fg                               gui=underline
hi VisualNOS        ctermfg=fg                             cterm=underline
hi Directory        guifg=#de4900                          gui=none
hi Directory        ctermfg=166                            cterm=none

" Pmenu       = normal item in popup
" PmenuSel    = selected item in popup
" PMenuSbar   = scrollbar in popup
" PMenuThumb  = thumb of the scrollbar in popup

hi Pmenu            guifg=#ffffff       guibg=#444444      gui=none
hi Pmenu            ctermfg=255         ctermbg=238        cterm=none
hi PmenuSel         guifg=#000000       guibg=#b1d631      gui=none
hi PmenuSel         ctermfg=0           ctermbg=148        cterm=none
hi PMenuSbar                            guibg=#2d2d2d      gui=none
hi PMenuSbar                            ctermbg=236        cterm=none
hi PMenuThumb                           guibg=#444444      gui=none
hi PMenuThumb                           ctermbg=238        cterm=none

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

hi Folded           guifg=#808080       guibg=#262626      gui=none
hi Folded           ctermfg=244         ctermbg=235        cterm=none
hi FoldColumn       guifg=#808080       guibg=#000000      gui=none
hi FoldColumn       ctermfg=244         ctermbg=232        cterm=none
hi LineNr           guifg=#808080       guibg=#000000
hi LineNr           ctermfg=244         ctermbg=232
hi ModeMsg          guifg=#b3b3b3       guibg=NONE         gui=none
hi ModeMsg          ctermfg=249         ctermbg=NONE       cterm=none
hi NonText          guifg=#202020       guibg=#000000      gui=none
hi NonText          ctermfg=234         ctermbg=0          cterm=none
hi SignColumn       guifg=#808080       guibg=#000000
hi SignColumn       ctermfg=244         ctermbg=232
hi StatusLine       guifg=#d3d3d5       guibg=#444444      gui=italic
hi StatusLine       ctermfg=253         ctermbg=238        cterm=none
hi StatusLineNC     guifg=#939395       guibg=#444444      gui=none
hi StatusLineNC     ctermfg=246         ctermbg=238        cterm=none
hi VertSplit        guifg=#444444       guibg=#444444      gui=none
hi VertSplit        ctermfg=238         ctermbg=238        cterm=none
hi WildMenu         guifg=#de4900       guibg=#444444      gui=bold
hi WildMenu         ctermfg=166         ctermbg=238        cterm=bold

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
hi SpecialKey       guifg=#808080       guibg=#262626
hi SpecialKey       ctermfg=244         ctermbg=235
hi Title            guifg=#f6f3e8                          gui=bold
hi Title            ctermfg=254                            cterm=bold

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

hi IncSearch        guifg=#7e8aa2                          gui=reverse
hi IncSearch        ctermfg=103                            cterm=reverse
hi Search           guifg=#000000       guibg=#7e8aa2      gui=none
hi Search           ctermfg=16          ctermbg=103        cterm=none
hi MatchParen       guifg=#d0ffc0       guibg=#2f2f2f      gui=bold
hi MatchParen       ctermfg=157         ctermbg=237        cterm=bold

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
hi DiffChange       guifg=#e0e0e0       guibg=#3B4865      gui=none
hi DiffChange       ctermfg=253         ctermbg=67         cterm=none
hi DiffDelete       guifg=#e0e0e0       guibg=#3A0200      gui=none
hi DiffDelete       ctermfg=253         ctermbg=52         cterm=none
hi DiffText         guifg=#e0e0e0       guibg=#324900      gui=none
hi DiffText         ctermfg=253         ctermbg=22         cterm=none

" SYNTAX HIGHLIGHTING {{{1

hi Comment          guifg=#808080                          gui=italic
hi Comment          ctermfg=244                            cterm=none
hi Constant         guifg=#ff9800                          gui=none
hi Constant         ctermfg=208                            cterm=none
hi String           guifg=#b1d631                          gui=none
hi String           ctermfg=148                            cterm=none
hi StringDelimiter  guifg=#62a216                          gui=none
hi StringDelimiter  ctermfg=64                             cterm=none
hi Character        guifg=#62a216                          gui=none
hi Character        ctermfg=64                             cterm=none
hi Number           guifg=#b1d631                          gui=none
hi Number           ctermfg=148                            cterm=none
hi Boolean          guifg=#b1d631                          gui=none
hi Boolean          ctermfg=148                            cterm=none
hi Float            guifg=#b1d631                          gui=none
hi Float            ctermfg=148                            cterm=none
hi Identifier       guifg=#62a216                          gui=none
hi Identifier       ctermfg=64                             cterm=none
hi Function         guifg=#ffd700                          gui=none
hi Function         ctermfg=220                            cterm=none
hi Statement        guifg=#7e8aa2                          gui=none
hi Statement        ctermfg=103                            cterm=none
hi Conditional      guifg=#7e8aa2                          gui=none
hi Conditional      ctermfg=103                            cterm=none
hi Exception        guifg=#62a216                          gui=none
hi Exception        ctermfg=64                             cterm=none
hi Repeat           guifg=#7e8aa2                          gui=none
hi Repeat           ctermfg=103                            cterm=none
hi Label            guifg=#ff9800                          gui=none
hi Label            ctermfg=208                            cterm=none
hi Operator         guifg=#ff9800                          gui=none
hi Operator         ctermfg=208                            cterm=none
hi Keyword          guifg=#ff9800                          gui=none
hi Keyword          ctermfg=208                            cterm=none
hi PreProc          guifg=#ffffaf                          gui=none
hi PreProc          ctermfg=229                            cterm=none
hi Include          guifg=#ffffaf                          gui=none
hi Include          ctermfg=229                            cterm=none
hi Define           guifg=#ffffaf                          gui=none
hi Define           ctermfg=229                            cterm=none
hi Macro            guifg=#ffffaf                          gui=none
hi Macro            ctermfg=229                            cterm=none
hi PreCondit        guifg=#ffffaf                          gui=none
hi PreCondit        ctermfg=229                            cterm=none
hi Type             guifg=#7e8aa2                          gui=none
hi Type             ctermfg=103                            cterm=none
hi StorageClass     guifg=#9eb51e                          gui=none
hi StorageClass     ctermfg=106                            cterm=none
hi Structure        guifg=#9eb51e                          gui=none
hi Structure        ctermfg=106                            cterm=none
hi Typedef          guifg=#9eb51e                          gui=none
hi Typedef          ctermfg=106                            cterm=none
hi Special          guifg=#ff9800                          gui=none
hi Special          ctermfg=208                            cterm=none
hi SpecialChar      guifg=#ff9800                          gui=none
hi SpecialChar      ctermfg=208                            cterm=none
hi Tag              guifg=#ff9800                          gui=none
hi Tag              ctermfg=208                            cterm=none
hi Delimiter        guifg=#ff9800                          gui=none
hi Delimiter        ctermfg=208                            cterm=none
hi SpecialComment   guifg=#ff9800                          gui=none
hi SpecialComment   ctermfg=208                            cterm=none
hi Debug            guifg=#ff9800       guibg=NONE         gui=none
hi Debug            ctermfg=208         ctermbg=NONE       cterm=none
hi Underlined       guifg=fg                               gui=underline
hi Underlined       ctermfg=fg                             cterm=underline
hi Ignore           guifg=bg
hi Ignore           ctermfg=bg
hi Error            guifg=#f80c0c       guibg=bg           gui=reverse
hi Error            ctermfg=160         ctermbg=bg         cterm=reverse
hi Todo             guifg=#e6ea50       guibg=bg           gui=reverse,bold
hi Todo             ctermfg=227         ctermbg=bg         cterm=reverse,bold

" SPECIAL GROUPS {{{1

" hi MyTagListFileName  guifg=#969696       guibg=#101010      gui=none
" hi MyTagListFileName  ctermfg=246         ctermbg=232        cterm=none

if exists('+colorcolumn')
    hi ColorColumn     guifg=NONE          guibg=#181818      gui=none
    hi ColorColumn     ctermfg=NONE        ctermbg=233        cterm=none
endif

" vim: set fdm=marker foldmarker={{{,}}}
