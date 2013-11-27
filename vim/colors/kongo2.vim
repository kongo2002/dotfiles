" Name:         kongo2.vim
" Description:  vim colorscheme
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>
" Last Change:  Sat 24 Jul 2010 10:25:18 PM CEST
" Version:      0.1

if version > 580
    hi clear
    if exists('syntax_on')
        syntax reset
    endif
endif
let g:colors_name = 'kongo2'

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

hi Normal           guifg=#FFFFFF       guibg=#0B1022
hi Normal           ctermfg=15          ctermbg=17
hi Cursor           guifg=#000000       guibg=#FFFF00
hi Cursor           ctermfg=16          ctermbg=226
hi CursorIM         guifg=bg            guibg=#96CDCD
hi CursorIM         ctermfg=bg          ctermbg=80
hi CursorColumn     guifg=NONE          guibg=#191E2F      gui=none
hi CursorColumn     ctermfg=NONE        ctermbg=18         cterm=none
hi CursorLine       guifg=NONE          guibg=#191E2F      gui=none
hi CursorLine       ctermfg=NONE        ctermbg=18         cterm=none
hi Visual           guifg=NONE          guibg=#283A76
hi Visual           ctermfg=NONE        ctermbg=25
hi VisualNOS        guifg=fg                               gui=underline
hi VisualNOS        ctermfg=fg                             cterm=underline
hi Directory        guifg=#21D620                          gui=none
hi Directory        ctermfg=46                             cterm=none

" Pmenu       = normal item in popup
" PmenuSel    = selected item in popup
" PMenuSbar   = scrollbar in pop
" PMenuThumb  = thumb of the scrollbar in popup

hi Pmenu            guifg=#0B1022       guibg=#84A7C1      gui=none
hi Pmenu            ctermfg=17          ctermbg=74         cterm=none
hi PmenuSel                             guibg=#191E2F      gui=none
hi PmenuSel                             ctermbg=18         cterm=none
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

hi Folded           guifg=#1D2652       guibg=#070A15      gui=none
hi Folded           ctermfg=20          ctermbg=232        cterm=none
hi FoldColumn       guifg=#1D2652       guibg=#070A15      gui=none
hi FoldColumn       ctermfg=20          ctermbg=232        cterm=none
hi LineNr           guifg=#888888       guibg=#070A15
hi LineNr           ctermfg=245          ctermbg=232
hi ModeMsg          guifg=#B3B3B3       guibg=NONE         gui=none
hi ModeMsg          ctermfg=249         ctermbg=NONE       cterm=none
hi NonText          guifg=#4A4A59                          gui=none
hi NonText          ctermfg=146                            cterm=none
hi SignColumn       guifg=#888888       guibg=#070A15      gui=none
hi SignColumn       ctermfg=245         ctermbg=232        cterm=none
hi StatusLine       guifg=#E0E0E0       guibg=#101010      gui=bold
hi StatusLine       ctermfg=253         ctermbg=232        cterm=bold
hi StatusLineNC     guifg=#1D2652       guibg=#070A15      gui=none
hi StatusLineNC     ctermfg=20          ctermbg=232        cterm=none
hi VertSplit        guifg=#1D2652       guibg=#070A15      gui=none
hi VertSplit        ctermfg=20          ctermbg=232        cterm=none
hi WildMenu         guifg=#888888       guibg=#070A15      gui=bold
hi WildMenu         ctermfg=245         ctermbg=232        cterm=bold

" ErrorMsg      = error message in the command line
" WarningMsg    = warning message in the commmand line
" MoreMsg       = -- More --
" Question      = prompt and yes/no question
" SpecialKey    = 'listchars' and special/map keys in :map
" Title         = titles in :set all, :autocmd etc.

hi ErrorMsg         guifg=#D70000       guibg=#191E2F      gui=none
hi ErrorMsg         ctermfg=160         ctermbg=18        cterm=none
hi WarningMsg       guifg=#DE4900                          gui=none
hi WarningMsg       ctermfg=166                            cterm=none
hi MoreMsg          guifg=#A28700                          gui=none
hi MoreMsg          ctermfg=178                            cterm=none
hi Question         guifg=fg                               gui=none
hi Question         ctermfg=fg                             cterm=none
hi SpecialKey       guifg=#4A4A59
hi SpecialKey       ctermfg=146
hi Title            guifg=#A28700                          gui=bold
hi Title            ctermfg=178                            cterm=bold

" Tabline       = not active tab
" TablineFill   = no tab
" TablineSel    = active tab

hi TabLine          guifg=#E0E0E0       guibg=#191E2F      gui=none
hi TabLine          ctermfg=253         ctermbg=18         cterm=none
hi TabLineFill      guifg=#E0E0E0       guibg=#2D2D2D      gui=none
hi TabLineFill      ctermfg=253         ctermbg=236        cterm=none
hi TabLineSel       guifg=#E1E1E1       guibg=#101010      gui=bold
hi TabLineSel       ctermfg=255         ctermbg=232        cterm=none

" IncSearch  = incremental search
" Search     = found matches -> 'hlsearch'
" MatchParen = paired bracket and its match

hi IncSearch        guifg=#1C3B79                          gui=reverse
hi IncSearch        ctermfg=27                             cterm=reverse
hi Search                               guibg=#1C3B79      gui=none
hi Search                               ctermbg=27         cterm=none
hi MatchParen       guifg=#FFFF00       guibg=NONE         gui=bold
hi MatchParen       ctermfg=226         ctermbg=NONE       cterm=bold

" SpellBad      = word is not recognized
" SpellCap      = word should start with capital
" SpellRare     = word is hardly ever used
" SpellLocal    = word is used in another region

hi SpellBad         guisp=#EE0000                          gui=undercurl
hi SpellBad         ctermfg=160                            cterm=reverse
hi SpellCap         guisp=#EEEE00                          gui=undercurl
hi SpellCap         ctermfg=208                            cterm=reverse
hi SpellRare        guisp=#FFA500                          gui=undercurl
hi SpellRare        ctermfg=130                            cterm=reverse
hi SpellLocal       guisp=#FFA500                          gui=undercurl
hi SpellLocal       ctermfg=130                            cterm=reverse

" DiffAdd     = added line
" DiffChange  = changed line
" DiffDelete  = removed line
" DiffText    = changed characters

hi DiffAdd          guifg=#E0E0E0       guibg=#324900      gui=none
hi DiffAdd          ctermfg=253         ctermbg=22         cterm=none
hi DiffChange       guifg=NONE          guibg=#3B4865      gui=none
hi DiffChange       ctermfg=NONE        ctermbg=67         cterm=none
hi DiffDelete       guifg=#E0E0E0       guibg=#3A0200      gui=none
hi DiffDelete       ctermfg=253         ctermbg=52         cterm=none
hi DiffText         guifg=#E0E0E0       guibg=#324900      gui=none
hi DiffText         ctermfg=253         ctermbg=22         cterm=none

" SYNTAX HIGHLIGHTING {{{1

hi Comment          guifg=#AEAEAE                          gui=none
hi Comment          ctermfg=249                            cterm=none
hi Constant         guifg=#D8FA3C                          gui=none
hi Constant         ctermfg=190                            cterm=none
hi String           guifg=#61CE3C                          gui=none
hi String           ctermfg=77                             cterm=none
hi StringDelimiter  guifg=#D8FA3C                          gui=none
hi StringDelimiter  ctermfg=190                            cterm=none
hi Character        guifg=#D8FA3C                          gui=none
hi Character        ctermfg=190                            cterm=none
hi Number           guifg=#E7820F                          gui=none
hi Number           ctermfg=208                            cterm=none
hi Boolean          guifg=#98320C                          gui=none
hi Boolean          ctermfg=130                            cterm=none
hi Float            guifg=#E7820F                          gui=none
hi Float            ctermfg=208                            cterm=none
hi Identifier       guifg=#61CE3C                          gui=none
hi Identifier       ctermfg=77                             cterm=none
hi Function         guifg=#FF5600                          gui=none
hi Function         ctermfg=202                            cterm=none
hi Statement        guifg=#21D620                          gui=none
hi Statement        ctermfg=46                             cterm=none
hi Conditional      guifg=#21D620                          gui=none
hi Conditional      ctermfg=46                             cterm=none
hi Exception        guifg=#62A216                          gui=none
hi Exception        ctermfg=64                             cterm=none
hi Repeat           guifg=#21D620                          gui=none
hi Repeat           ctermfg=46                             cterm=none
hi Label            guifg=#FFDE00                          gui=none
hi Label            ctermfg=220                            cterm=none
hi Operator         guifg=#FFDE00                          gui=none
hi Operator         ctermfg=220                            cterm=none
hi Keyword          guifg=#FFDE00                          gui=none
hi Keyword          ctermfg=220                            cterm=none
hi PreProc          guifg=#FF5600                          gui=none
hi PreProc          ctermfg=220                            cterm=none
hi Include          guifg=#FF5600                          gui=none
hi Include          ctermfg=220                            cterm=none
hi Define           guifg=#FF5600                          gui=none
hi Define           ctermfg=220                            cterm=none
hi Macro            guifg=#FF5600                          gui=none
hi Macro            ctermfg=220                            cterm=none
hi PreCondit        guifg=#FF5600                          gui=none
hi PreCondit        ctermfg=220                            cterm=none
hi Type             guifg=#84A7C1                          gui=none
hi Type             ctermfg=74                             cterm=none
hi StorageClass     guifg=#9EB51E                          gui=none
hi StorageClass     ctermfg=106                            cterm=none
hi Structure        guifg=#9EB51E                          gui=none
hi Structure        ctermfg=106                            cterm=none
hi Typedef          guifg=#9EB51E                          gui=none
hi Typedef          ctermfg=106                            cterm=none
hi Special          guifg=#21D5E0                          gui=none
hi Special          ctermfg=44                             cterm=none
hi SpecialChar      guifg=#21D5E0                          gui=none
hi SpecialChar      ctermfg=44                             cterm=none
hi Tag              guifg=#21D5E0                          gui=none
hi Tag              ctermfg=44                             cterm=none
hi Delimiter        guifg=#21D5E0                          gui=none
hi Delimiter        ctermfg=44                             cterm=none
hi SpecialComment   guifg=#21D5E0                          gui=none
hi SpecialComment   ctermfg=44                             cterm=none
hi Debug            guifg=#21D5E0       guibg=NONE         gui=none
hi Debug            ctermfg=44          ctermbg=NONE       cterm=none
hi Underlined       guifg=fg                               gui=underline
hi Underlined       ctermfg=fg                             cterm=underline
hi Ignore           guifg=bg
hi Ignore           ctermfg=bg
hi Error            guifg=#F80C0C       guibg=bg           gui=reverse
hi Error            ctermfg=160         ctermbg=bg         cterm=reverse
hi Todo             guifg=#61CE3C       guibg=bg           gui=reverse,bold
hi Todo             ctermfg=77          ctermbg=bg         cterm=reverse,bold

" SPECIAL GROUPS {{{1

hi MyTagListFileName  guifg=#888888       guibg=#070A15      gui=none
hi MyTagListFileName  ctermfg=245         ctermbg=232        cterm=none

if exists('+colorcolumn')
    hi ColorColumn     guifg=NONE          guibg=#191E2F      gui=none
    hi ColorColumn     ctermfg=NONE        ctermbg=18         cterm=none
endif

" vim: set fdm=marker foldmarker={{{,}}}
