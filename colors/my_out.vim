
set background=dark
hi clear
if exists("syntax_on")
syntax reset
endif

let colors_name = "my_out"

if ! exists("g:inkpot_black_background")
let g:inkpot_black_background = 0
endif


hi Access ctermfg=130 guifg=#af5f00
hi Boolean ctermfg=125 guifg=#af005f
hi Cast ctermfg=71 guifg=#5faf5f
hi Comment term=bold ctermfg=63 guifg=#5f5fff
hi Constant term=underline ctermfg=201 guifg=#ff00ff
hi CursorColumn term=reverse ctermbg=242 guibg=#666666
hi ColorColumn ctermbg=232 guibg=#080808
hi CursorLine term=underline cterm=underline guibg=Grey40

"hi DiffAdd term=bold ctermfg=231 ctermbg=22 guifg=#ffffff guibg=#3f873f
hi DiffAdd term=bold ctermfg=231 ctermbg=22 guifg=#ffffff guibg=#5f875f
"hi DiffChange term=bold ctermfg=231 ctermbg=17 guifg=#ffffff guibg=#00005f
hi DiffChange term=bold ctermfg=231 ctermbg=17 guifg=#ffffff guibg=#3f3f87
hi DiffDelete term=bold ctermfg=231 ctermbg=52 gui=bold guifg=#f75f5f     guibg=#f75f5f
hi DiffText term=reverse ctermfg=231 ctermbg=55 gui=bold guifg=#2f2f2f guibg=#66d9ef
"hi DiffText term=reverse ctermfg=231 ctermbg=55 gui=bold guifg=#ffffff guibg=#5f00af
hi Directory term=bold ctermfg=46 guifg=#00ff00
hi Error term=reverse ctermfg=231 ctermbg=52 guifg=#ffffff guibg=#5f0000
hi ErrorMsg term=standout cterm=bold ctermfg=16 ctermbg=124 guifg=#000000 guibg=#af0000
hi Exception ctermfg=55 guifg=#5f00af
hi FoldColumn term=standout ctermfg=63 ctermbg=232 guifg=#5f5fff guibg=#080808
hi Folded term=standout ctermfg=231 ctermbg=57 guifg=#ffffff guibg=#5f00ff
hi Folded term=standout ctermfg=231 ctermbg=57 guifg=#ffffff guibg=#5f00ff
hi Identifier term=underline ctermfg=131 guifg=#af5f5f
hi Ignore ctermfg=0 guifg=#000000
hi IncSearch term=reverse cterm=bold ctermfg=232 ctermbg=215 gui=reverse guifg=#080808 guibg=#ffaf5f
hi Label ctermfg=131 guifg=#af5f5f
hi LineNr term=underline ctermfg=21 ctermbg=16 guifg=#0000ff guibg=#000000
hi MBEChanged ctermfg=253 ctermbg=235 guifg=#dadada guibg=#262626
hi MBENormal ctermfg=247 ctermbg=235 guifg=#9e9e9e guibg=#262626
hi MBEVisibleChanged ctermfg=253 ctermbg=238 guifg=#dadada guibg=#444444
hi MBEVisibleNormal ctermfg=247 ctermbg=238 guifg=#9e9e9e guibg=#444444
hi MatchParen term=reverse ctermbg=14 guibg=#00ffff
hi ModeMsg term=bold cterm=bold ctermfg=61 gui=bold guifg=#5f5faf
hi MoreMsg term=bold cterm=bold ctermfg=61 gui=bold guifg=#5f5faf
hi NonText term=bold cterm=bold ctermfg=63 gui=bold guifg=#5f5fff
hi Normal ctermfg=231 ctermbg=16 guifg=#ffffff guibg=#000000
hi Normal ctermfg=231 ctermbg=16 guifg=#ffffff guibg=#000000
hi Number ctermfg=202 guifg=#ff5f00
hi NumberTime ctermfg=125 guifg=#af005f
hi NumberComplex ctermfg=203 guifg=#ff5f5f
hi Pmenu ctermfg=253 ctermbg=238 guifg=#dadada guibg=#444444
hi Pmenu ctermfg=253 ctermbg=238 guifg=#dadada guibg=#444444
hi PmenuSbar cterm=bold ctermfg=253 ctermbg=63 guifg=#dadada guibg=#5f5fff
hi PmenuSel cterm=bold ctermfg=253 ctermbg=61 guifg=#dadada guibg=#5f5faf
hi PmenuThumb cterm=bold ctermfg=253 ctermbg=63 gui=reverse guifg=#dadada guibg=#5f5fff
hi PreCondit ctermfg=129 guifg=#af00ff
hi PreProc term=underline ctermfg=129 guifg=#af00ff
hi Question term=standout cterm=bold ctermfg=130 gui=bold guifg=#af5f00
hi Search term=reverse ctermfg=232 ctermbg=215 guifg=#080808 guibg=#ffaf5f
hi Search term=reverse ctermfg=232 ctermbg=215 guifg=#080808 guibg=#ffaf5f
hi SignColumn term=standout ctermfg=14 ctermbg=0 guifg=#00ffff guibg=#000000
hi Special term=bold ctermfg=135 guifg=#af5fff
hi SpecialChar ctermfg=135 ctermbg=235 guifg=#af5fff guibg=#262626
hi SpellBad term=reverse ctermbg=52 gui=undercurl guisp=Red guibg=#5f0000
hi SpellCap term=reverse ctermbg=23 gui=undercurl guisp=Blue guibg=#005f5f
hi SpellLocal term=underline ctermbg=58 gui=undercurl guisp=Cyan guibg=#5f5f00
hi SpellRare term=reverse ctermbg=53 gui=undercurl guisp=Magenta guibg=#5f005f
hi Statement term=bold ctermfg=39 gui=bold guifg=#00afff
hi StatusLine term=bold,reverse cterm=bold ctermfg=247 ctermbg=235 gui=bold,reverse guifg=#9e9e9e guibg=#262626
hi StatusLineNC term=reverse ctermfg=244 ctermbg=235 gui=reverse guifg=#808080 guibg=#262626
hi StorageClass ctermfg=70 guifg=#5faf00
hi String ctermfg=7 ctermbg=235 guifg=#c0c0c0 guibg=#262626
hi Structure ctermfg=34 guifg=#00af00
hi TabLine term=underline cterm=underline ctermfg=15 ctermbg=242 gui=underline guifg=#ffffff guibg=#666666
hi TabLineFill term=reverse cterm=reverse gui=reverse
hi TabLineSel term=bold cterm=bold gui=bold
hi TaglistTagName cterm=bold ctermfg=63 guifg=#5f5fff
hi Title term=bold cterm=bold ctermfg=124 gui=bold guifg=#af0000
hi Title term=bold cterm=bold ctermfg=124 gui=bold guifg=#af0000
hi Todo term=standout cterm=bold ctermfg=16 ctermbg=143 guifg=#000000 guibg=#afaf5f
hi Type term=underline ctermfg=214 gui=bold guifg=#ffaf00
hi Underlined term=underline cterm=bold ctermfg=227 gui=underline guifg=#ffff5f
hi User1 cterm=bold ctermfg=46 ctermbg=235 guifg=#00ff00 guibg=#262626
hi User2 cterm=bold ctermfg=63 ctermbg=235 guifg=#5f5fff guibg=#262626
hi VertSplit term=reverse ctermfg=244 ctermbg=235 gui=reverse guifg=#808080 guibg=#262626
hi Visual term=reverse ctermfg=231 ctermbg=61 guifg=#ffffff guibg=#5f5faf
hi Visual term=reverse ctermfg=231 ctermbg=61 guifg=#ffffff guibg=#5f5faf
hi VisualNOS term=bold,underline cterm=bold,underline gui=bold,underline
hi WarningMsg term=standout cterm=bold ctermfg=16 ctermbg=202 guifg=#000000 guibg=#ff5f00
hi WildMenu term=standout cterm=bold ctermfg=253 ctermbg=61 guifg=#dadada guibg=#5f5faf
hi cppType ctermfg=87 guifg=#5fffff
hi doxygenBoldWord term=bold cterm=bold gui=bold
hi doxygenCodeWord term=bold cterm=bold gui=bold
hi doxygenEmphasisedWord term=italic cterm=italic gui=italic
hi doxygenHtmlBoldItalic term=bold,italic cterm=bold,italic gui=bold,italic
hi doxygenHtmlBoldUnderline term=bold,underline cterm=bold,underline gui=bold,underline
hi doxygenHtmlBoldUnderlineItalic term=bold,underline,italic cterm=bold,underline,italic gui=bold,underline,italic
hi doxygenHtmlItalic term=italic cterm=italic gui=italic
hi doxygenHtmlUnderline term=underline cterm=underline gui=underline
hi doxygenHtmlUnderlineItalic term=underline,italic cterm=underline,italic gui=underline,italic

hi level1c ctermfg=130 guifg=#af5f00
hi level2c ctermfg=12 guifg=#0000ff
hi level3c ctermfg=242 guifg=#666666
hi level4c ctermfg=6 guifg=#008080
hi level5c ctermfg=14 guifg=#00ffff
hi level6c ctermfg=10 guifg=#00ff00
hi level7c ctermfg=11 guifg=#ffff00
hi level8c ctermfg=13 guifg=#ff00ff
hi level9c ctermfg=7 guifg=#c0c0c0
hi level10c ctermfg=248 guifg=#a8a8a8
hi level11c ctermfg=121 guifg=#87ffaf
hi level12c ctermfg=229 guifg=#ffffaf
hi level13c ctermfg=81 guifg=#5fdfff
hi level15c ctermfg=224 guifg=#ffdfdf
hi level16c ctermfg=15 guifg=#ffffff

hi makeBString ctermfg=82 guifg=#5fff00
hi makeCommands ctermfg=196 guifg=#ff0000
hi makeConfig ctermfg=199 guifg=#ff00af
hi makeDString ctermfg=71 guifg=#5faf5f
hi makeSString ctermfg=73 guifg=#5fafaf
hi makeTarget ctermfg=34 guifg=#00af00
hi otlTab1 ctermfg=63 guifg=#5f5fff
hi otlTextLeader ctermfg=237 guifg=#3a3a3a
hi SpecialKey term=bold cterm=bold ctermfg=237 guifg=#3a3a3a
hi cppSTD ctermfg=246 guifg=#949494
hi cppOverride ctermfg=207 guifg=#ff5fff
hi YcmInlayHInt guifg=#555555
hi cppType ctermfg=87 guifg=#5fffff
hi cppParam guifg=#7fff7f
hi cppMember guifg=#ffff8f
hi cppEnum guifg=#ffafff

hi ChooseMe guifg=#ff0000  guibg=#ff8888

hi BookmarkSign ctermbg=NONE ctermfg=160 guifg=#00afbf
hi BookmarkAnnotationSign ctermbg=NONE ctermfg=160 guifg=#00cfdf
hi BookmarkLine ctermbg=194 ctermfg=NONE guibg=#440000

hi link cppAccess Access
hi link cppCast Cast

hi link mkdHeading htmlSpecialChar

" vim: tabstop=4 shiftwidth=4
