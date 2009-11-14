" Vim syntax file
" Language:     Drawing Interchange Format (AutoCAD 2000)
" Maintainer:   Gregor Uhlenheuer
" Last Change:  Sa 14 Nov 2009 18:31:45 CET

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" highlight helper function {{{
function! s:hiGroupCode(name, regex)
    let l:len = float2nr(abs(log10(a:regex)) + 1)
    let l:spaces = ''
    if l:len < 3
        let l:spaces = '\s\{' . (3-l:len) . '\}'
    endif
    exec 'syn match '.a:name.' display /^'.l:spaces.a:regex.'$/'
    exec 'hi def link ' . a:name . ' Identifier'
endfunction
" }}}

syn sync fromstart
syn case match

syn keyword dSystem HEADER CLASSES TABLES BLOCKS ENTITIES OBJECTS

syn keyword dSystemVar ACADVER ANGBASE ANGDIR ATTMODE AUNITS AUPREC
syn keyword dSystemVar CECOLOR CELTSCALE CELTYPE CELWEIGHT CPSNID
syn keyword dSystemVar CEPSNTYPE CHAMFERA CHAMFERB CHAMFERC CHAMFERD
syn keyword dSystemVar CLAYER CMLJUST CMLSCALE CMLSTYLE DIMADEC DIMALT
syn keyword dSystemVar DIMALTD DIMALTF DIMALTRND DIMALTTD DIMALTTZ
syn keyword dSystemVar DIMALTU DIMALTZ DIMAPOST DIMASO DIMASZ DIMATFIT
syn keyword dSystemVar DIMAUNIT DIMAZIN DIMBLK DIMBLK1 DIMBLK2 DIMCEN
syn keyword dSystemVar DIMCLRD DIMCLRE DIMCLRT DIMDEC DIMDLE DIMDLI
syn keyword dSystemVar DIMDSEP DIMEXE DIMEXO DIMFAC DIMGAP DIMJUST
syn keyword dSystemVar DIMLDRBLK DIMLFAC DIMLIM DIMLUNIT DIMLWD DIMLWE
syn keyword dSystemVar DIMPOST DIMRND DIMSAH DIMSCALE DIMSD1 DIMSD2
syn keyword dSystemVar DIMSE1 DIMSE2 DIMSHO DIMSOXD DIMSTYLE DIMTAD
syn keyword dSystemVar DIMTDEC DIMTFAC DIMTIH DIMTIX DIMTM DIMTMOVE
syn keyword dSystemVar DIMTOFL DIMTOH DIMTOL DIMTOLJ DIMTP DIMTSZ DIMTVP
syn keyword dSystemVar DIMTXSTY DIMTXT DIMTZIN DIMUPT DIMZIN DISPSILH
syn keyword dSystemVar DWGCODEPAGE ELEVATION ENDCAPS EXTMAX EXTMIN
syn keyword dSystemVar EXTNAMES FILLETRAD FILLMODE FINGERPRINTGUID
syn keyword dSystemVar HANDSEED HYPERLINKBASE INSBASE INSUNITS JOINSTYLE
syn keyword dSystemVar LIMCHECK LIMMAX LIMMIN LTSCALE LUNITS LUPREC
syn keyword dSystemVar LWDISPLAY MAXACTVP MEASUREMENT MENU MIRRTEXT
syn keyword dSystemVar ORTHOMODE PDMODE PDSIZE PELEVATION PEXTMAX PEXTMIN
syn keyword dSystemVar PINSBASE PLIMCHECK PLIMMAX PLIMMIN PLINEGEN
syn keyword dSystemVar PLINEWID PROXYGRAPHICS PSLTSCALE PSTYLEMODE
syn keyword dSystemVar PSVPSCALE PUCSBASE PUCSNAME PUCSORG PUCSORGBACK
syn keyword dSystemVar PUCSORGBOTTOM PUCSORGFRONT PUCSORGLEFT PUCSORGRIGHT
syn keyword dSystemVar PUCSORGTOP PUCSORTHOREF PUCSORTHOVIEW PUCSXDIR
syn keyword dSystemVar PUCSYDIR QTEXTMODE REGENMODE SHADEDGE SHADEDIF
syn keyword dSystemVar SKETCHINC SKPOLY SPLFRAME SPLINESEGS SPLINETYPE
syn keyword dSystemVar SURFTAB1 SURFTAB2 SURFTYPE SURFU SURFV TDCREATE
syn keyword dSystemVar TDINDWG TDUCREATE TDUPDATE TDUSRTIMER TDUUPDATE
syn keyword dSystemVar TEXTSIZE TEXTSTYLE THICKNESS TILEMODE TRACEWID
syn keyword dSystemVar TREEDEPTH UCSBASE UCSNAME UCSORG UCSORGBACK
syn keyword dSystemVar UCSORGBOTTOM UCSORGFRONT UCSORGLEFT UCSORGRIGHT
syn keyword dSystemVar UCSORGTOP UCSORTHOREF UCSORTHOVIEW UCSXDIR UCSYDIR
syn keyword dSystemVar UNITMODE USRTIMER VERSIONGUID VISRETAIN WORLDVIEW
syn keyword dSystemVar XEDIT

syn keyword dHeader CELWEIGHT CEPSNID CEPSNTYPE DIMADEC DIMALTRND
syn keyword dHeader DIMATFIT DIMAZIN DIMDSEP DIMFAC DIMLDRBLK DIMLUNIT
syn keyword dHeader DIMLWD DIMLWE DIMTMOVE ENDCAPS EXTNAMES
syn keyword dHeader FINGERPRINTGUID HYPERLINKBASE INSUNITS JOINSTYLE
syn keyword dHeader LWDISPLAY PSTYLEMODE PSVPSCALE PUCSBASE PUCSORGBACK
syn keyword dHeader PUCSORGBOTTOM PUCSORGFRONT PUCSORGLEFT PUCSORGRIGHT
syn keyword dHeader PUCSORGTOP PUCSORTHOREF PUCSORTHOVIEW TDUCREATE
syn keyword dHeader TDUUPDATE UCSBASE UCSORGBACK UCSORGBOTTOM UCSORGFRONT
syn keyword dHeader UCSORGLEFT UCSORGBACK UCSORGTOP UCSORTHOREF
syn keyword dHeader UCSORTHOVIEW VERSIONGUID XEDIT

syn keyword dClass ACDBDICTIONARYWDFLT ACDBPLACEHOLDER ARCALIGNEDTEXT LAYOUT
syn keyword dClass PLOTSETTINGS RTEXT WIPEOUT WIPEOUTVARIABLES HATCH IMAGE
syn keyword dClass IDBUFFER IMAGEDEF IMAGEDEF_REACTOR LAYER_INDEX
syn keyword dClass LWPOLYLINE OBJECT_PTR OLE2FRAME RASTERVARIABLES
syn keyword dClass SORTENTSTABLE SPATIAL_INDEX SPATIAL_FILTER WIPEOUT

syn keyword dTable APPID BLOCK_RECORD DIMSTYLE LAYER LTYPE STYLE UCS VIEW
syn keyword dTable VPORT

syn keyword dEntity 3DFACE 3DSOLID ACAD_PROXY_ENTITY ARC ARCALIGNEDTEXT ATTDEF
syn keyword dEntity ATTRIB BODY CIRCLE DIMENSION ELLIPSE HATCH IMAGE INSERT
syn keyword dEntity LEADER LINE LWPOLYLINE MLINE MTEXT OLEFRAME OLE2FRAME
syn keyword dEntity POINT POLYLINE RAY REGION RTEXT SEQEND SHAPE SOLID SPLINE
syn keyword dEntity TEXT TOLERANCE TRACE VERTEX VIEWPORT WIPEOUT XLINE

syn keyword dObject ACAD_PROXY_OBJECT ACDBDICTIONARYWDFLT ACDBPLACEHOLDER
syn keyword dObject DICTIONARY DICTIONARYVAR GROUP IDBUFFER IMAGEDEF
syn keyword dObject IMAGEDEF_REACTOR LAYER_INDEX LAYOUT MLINESTYLE OBJECT_PTR
syn keyword dObject RASTERVARIABLES SPATIAL_INDEX SPATIAL_FILTER SORTENTSTABLE
syn keyword dObject XRECORD

syn keyword dThumbnail THUMBNAILIMAGE

syn match dNumber display /\<\d\+\%(\.\d\+\)\?\>/

syn match dCode display /^\s\{1,2\}\d\+/

syn match dVariable display /^\$/

"syn match dText display /^\s\+1\n\@<=.*$/
syn match dTextCode display /^\s\{2\}1$/

syn region dSection start=/^SECTION$/ end=/^ENDSEC/ fold transparent contains=ALLBUT,dSection

syn region dTabSec start=/^TABLE$/ end=/^ENDTAB/ fold transparent contains=ALLBUT,dSection,dTabSec

syn region dBlockSec start=/^BLOCK$/ end=/^AcDbBlockEnd/ fold transparent contains=ALLBUT,dSection,dTabSec,dBlocSec

" highlight group codes {{{
call s:hiGroupCode('dName', 2)
call s:hiGroupCode('dLayerName', 8)
call s:hiGroupCode('dStartX', 10)
call s:hiGroupCode('dStartY', 20)
call s:hiGroupCode('dStartZ', 30)
call s:hiGroupCode('dEndX', 11)
call s:hiGroupCode('dEndY', 21)
call s:hiGroupCode('dEndZ', 31)
call s:hiGroupCode('d3rdX', 12)
call s:hiGroupCode('d3rdY', 22)
call s:hiGroupCode('d3rdZ', 32)
call s:hiGroupCode('d4thX', 13)
call s:hiGroupCode('d4thY', 23)
call s:hiGroupCode('d4thZ', 33)
call s:hiGroupCode('dElevation', 38)
call s:hiGroupCode('dThickness', 39)
call s:hiGroupCode('dRadius', 40)
call s:hiGroupCode('dScaleX', 41)
call s:hiGroupCode('dScaleY', 42)
call s:hiGroupCode('dScaleZ', 43)
call s:hiGroupCode('dAngle', 50)
call s:hiGroupCode('dAngle', 51)
call s:hiGroupCode('dColor', 62)
call s:hiGroupCode('dEntitiesFollow', 66)
call s:hiGroupCode('dFlags', 70)
call s:hiGroupCode('dViewportFlags', 90)
call s:hiGroupCode('dSubCMarker', 100)
call s:hiGroupCode('dControlStr', 102)
call s:hiGroupCode('dObjHandle', 105)
call s:hiGroupCode('dExtrDirX', 210)
call s:hiGroupCode('dExtrDirY', 220)
call s:hiGroupCode('dExtrDirZ', 230)
call s:hiGroupCode('dRenderMode', 281)
call s:hiGroupCode('dHardPointer', 340)
" }}}

hi def link dSystem Type
hi def link dSystemVar Keyword
hi def link dCode Keyword
hi def link dVariable SpecialChar
hi def link dHeader Function
hi def link dClass Function
hi def link dTable Function
hi def link dEntity Function
hi def link dObject Function
hi def link dThumbnail Function
hi def link dNumber Number
hi def link dBlockSec Statement
hi def link dSection Statement
hi def link dTabSec Statement
hi def link dTextCode Identifier
"hi def link dText String

let b:current_syntax = 'dxf'

delf s:hiGroupCode
