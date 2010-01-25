" Name:         kongo.vim
" Description:  vim colorscheme
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>
" Last Change:  Mo 25 Jan 2010 20:24:57 CET
" Version:      0.1

set background=dark

if version > 580
    hi clear
    if exists('syntax_on')
        syntax reset
    endif
endif
let g:colors_name = 'kongo'

" GENERAL APPEARANCE {{{

" Normal        = normal text
" Cursor        = character under the cursor
" CursorIM      = cursor in IME mode
" CursorColumn  = screen column the cursor is in -> 'cursorcolumn'
" CursorLine    = screen line the cursor is in   -> 'cursorline'
" Visual        = visual mode selection
" VisualNOS     = visual mode selection (not owning the selection)
"                 (X11 GUI and xterm-clipboard only)
" Directory     = directory names (and special names in listings)

hi Normal           guifg=#e0e0e0           guibg=#202020
hi Cursor           guifg=bg                guibg=#dfdfdf
hi CursorIM         guifg=bg                guibg=#96cdcd
hi CursorColumn     guifg=NONE              guibg=#151515           gui=none
hi CursorLine       guifg=NONE              guibg=#151515           gui=none
hi Visual           guifg=NONE              guibg=#101010
hi VisualNOS        guifg=fg                                        gui=underline
hi Directory        guifg=#9cd620                                   gui=none

" Pmenu       = normal item in popup
" PmenuSel    = selected item in popup
" PMenuSbar   = scrollbar in pop
" PMenuThumb  = thumb of the scrollbar in popup

hi Pmenu            guifg=#969696           guibg=#101010           gui=none
hi PmenuSel         guifg=#9cd620           guibg=#151515           gui=none
hi PMenuSbar                                guibg=#505860           gui=none
hi PMenuThumb                               guibg=#808890           gui=none

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

hi Folded           guifg=#969696           guibg=#101010           gui=none
hi FoldColumn       guifg=#969696           guibg=#101010           gui=none
hi LineNr           guifg=#969696           guibg=#101010
hi ModeMsg          guifg=#b3b3b3           guibg=NONE              gui=none
hi NonText          guifg=#000000                                   gui=none
hi SignColumn       guifg=#969696           guibg=#101010           gui=none
hi StatusLine       guifg=#e0e0e0           guibg=#101010           gui=bold
hi StatusLineNC     guifg=#757575           guibg=#2d2d2d           gui=none
hi VertSplit        guifg=#969696           guibg=#101010           gui=none
hi WildMenu         guifg=#9cd620           guibg=#101010           gui=bold

" ErrorMsg      = error message in the command line
" WarningMsg    = warning message in the commmand line
" MoreMsg       = -- More --
" Question      = prompt and yes/no question
" SpecialKey    = 'listchars' and special/map keys in :map
" Title         = titles in :set all, :autocmd etc.

hi ErrorMsg         guifg=#d70000           guibg=NONE              gui=none
hi WarningMsg       guifg=#de4900                                   gui=none
hi MoreMsg          guifg=#a28700                                   gui=none
hi Question         guifg=fg                                        gui=none
hi SpecialKey       guifg=#3e3e3e
hi Title            guifg=#a28700                                   gui=bold

" Tabline       = not active tab
" TablineFill   = no tab
" TablineSel    = active tab

hi TabLine          guifg=#e0e0e0           guibg=#151515           gui=none
hi TabLineFill      guifg=#e0e0e0           guibg=#2d2d2d           gui=none
hi TabLineSel       guifg=#e1e1e1           guibg=#101010           gui=bold

" IncSearch  = incremental search
" Search     = found matches -> 'hlsearch'
" MatchParen = paired bracket and its match

hi IncSearch        guifg=#9cd620                                   gui=reverse
hi Search                                   guibg=#9cd620           gui=underline
hi MatchParen       guifg=#ff0000           guibg=NONE              gui=bold

" SpellBad      = word is not recognized
" SpellCap      = word should start with capital
" SpellRare     = word is hardly ever used
" SpellLocal    = word is used in another region

hi SpellBad         guisp=#ee0000                                   gui=undercurl
hi SpellCap         guisp=#eeee00                                   gui=undercurl
hi SpellRare        guisp=#ffa500                                   gui=undercurl
hi SpellLocal       guisp=#ffa500                                   gui=undercurl

" DiffAdd     = added line
" DiffChange  = changed line
" DiffDelete  = removed line
" DiffText    = changed characters

hi DiffAdd          guifg=#80a090           guibg=#313c36           gui=none
hi DiffChange       guifg=NONE              guibg=#4a343a           gui=none
hi DiffDelete       guifg=#6c6661           guibg=#3c3631           gui=none
hi DiffText         guifg=#f05060           guibg=#4a343a           gui=bold

" SYNTAX HIGHLIGHTING {{{

hi Comment          guifg=#606060                                   gui=none
hi Constant         guifg=#980c0f                                   gui=none
hi String           guifg=#d54817                                   gui=none
hi StringDelimiter  guifg=#980c0f                                   gui=none
hi Character        guifg=#980c0f                                   gui=none
hi Number           guifg=#ddda35                                   gui=none
hi Boolean          guifg=#98320c                                   gui=none
hi Float            guifg=#ddda35                                   gui=none
hi Identifier       guifg=#ffae25                                   gui=none
hi Function         guifg=#ffae25                                   gui=none
hi Statement        guifg=#9cd620                                   gui=none
hi Conditional      guifg=#9cd620                                   gui=none
hi Exception        guifg=#62a216                                   gui=none
hi Repeat           guifg=#9cd620                                   gui=none
hi Label            guifg=#25a0ff                                   gui=none
hi Operator         guifg=#25a0ff                                   gui=none
hi Keyword          guifg=#25a0ff                                   gui=none
hi PreProc          guifg=#117ebf                                   gui=none
hi Include          guifg=#117ebf                                   gui=none
hi Define           guifg=#117ebf                                   gui=none
hi Macro            guifg=#117ebf                                   gui=none
hi PreCondit        guifg=#117ebf                                   gui=none
hi Type             guifg=#9eb51e                                   gui=none
hi StorageClass     guifg=#9eb51e                                   gui=none
hi Structure        guifg=#9eb51e                                   gui=none
hi Typedef          guifg=#9eb51e                                   gui=none
hi Special          guifg=#21d5e0                                   gui=none
hi SpecialChar      guifg=#21d5e0                                   gui=none
hi Tag              guifg=#21d5e0                                   gui=none
hi Delimiter        guifg=#21d5e0                                   gui=none
hi SpecialComment   guifg=#21d5e0                                   gui=none
hi Debug            guifg=#21d5e0           guibg=NONE              gui=none
hi Underlined       guifg=fg                                        gui=underline
hi Ignore           guifg=bg
hi Error            guifg=#f80c0c           guibg=bg                gui=reverse,none
hi Todo             guifg=#ffae25           guibg=bg                gui=reverse,bold

" vim: set fdm=marker foldmarker={{{,}}}
