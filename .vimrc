" We use a vim
"colorscheme default

python3 << EOL
pass
EOL


"source /etc/vimrc
set nu
set nocompatible
let mapleader=","
"
" Colo(u)red or not colo(u)red
" If you want color you should set this to true
"
let color = "true"


filetype plugin indent on
filetype plugin on
"
if has("syntax")
    if color == "true"
	" This will switch colors ON
	so ${VIMRUNTIME}/syntax/syntax.vim
    else
	" this switches colors OFF
	syntax off
	set t_Co=0
    endif
endif

if has('gui_running')
    set t_Co=256
endif

if &t_Co != 256
  hi Folded guifg=yellow guibg=NONE ctermfg=yellow ctermbg=NONE
  hi Search ctermfg=white ctermbg=red guifg=white  guibg=Red
  hi Folded guifg=orange            guibg=black
  hi SpellBad ctermbg=yellow
endif

set guifont=Inconsolata\ 11

if &t_Co == 256
    let g:inkpot_black_background = 1
"    colo my_inkpot
    colo my_out
endif

"set cindent
set shiftwidth=4
set smartindent

let g:load_doxygen_syntax=1


" Disable spelling checks for the preview window
func PreviewSpell()
    if &previewwindow
	set nospell
    endif
    if bufname('%') == '-MiniBufExplorer-' || bufname('%') == 'TreeExplorer' || bufname('%') == '__Tag_List__' || bufname('%') == '' || bufname('%') == '[YankRing]'
	set nospell
    endif
endfun

fun AddCppSyntax()
    let g:doxygen_javadoc_autobrief=1
    syn match cppSTD "\<std::\|\<boost::\|\<vwd::"
    syn keyword cppSTD VWD_EXPECT_TRUE VWD_EXPECT_FALSE
    syn match cppAccess "<\public:\|\<private:\|\<protected:"me=e-1
    syn keyword cConstant EWOULDBLOCK __PRETTY_FUNCTION__
    syn keyword cConstant nullptr 
    syn keyword cStorageClass constexpr
    syn keyword cppOverride override final
    syn keyword cStorageClass thread_local
    syn keyword cppOperator decltype
    syn match SpellBad "\<.*stirng\|\<.*strign\|<.*strnig"
    syn match SpellBad "retrun\|reutrn"
    syn match SpellBad "mdsp"
    syn keyword cppCast poly_cast
"    call indent_guides#enable()
endfun

fun AddPythonSyntax()

    let g:doxygen_enhanced_color=0
    runtime! syntax/doxygen.vim
    syn clear pythonAttribute
    syn match   pythonAttribute	/\.\h\w*/hs=s+1 contains=TOP,pythonBuiltin,pythonFunction,pythonAsync transparent
    syn region doxygenComment matchgroup=pythonString start=+[uU]\=\z('''\|"""\)+ end="\z1" contains=doxygenSyncStart,doxygenStart,doxygenTODO keepend fold containedin=pythonString
    return


    " below is the old code for python comments
    runtime! syntax/doxygen.vim
"    syn clear doxygenFormula
"    syn clear doxygenFormulaKeyword
"    syn clear doxygenFormulaEscaped
"    syn clear doxygenFormulaOperator
"    syn clear doxygenFormulaSpecial
"    syn clear doxygenSpecialHeading

"    syn clear doxygenSpecialMultilineDesc
"    syn clear doxygenSpecialOnelineDesc
"    syn clear doxygenSpecialTypeOnelineDesc
"    syn clear doxygenSpecialSectionDesc
"    syn clear doxygenPageDesc
"    syn clear doxygenLinkRest
"    syn clear doxygenHeaderLine
"    syn clear doxygenReturnValue

"    syn clear doxygenBody
"    syn clear doxygenBrief
"    syn clear doxygenSpecialIdent
"    syn clear doxygenPageIdent
"    syn clear doxygenLinkWord
"    syn clear doxygenParamName
"    syn clear doxygenBriefLine
"    syn clear doxygenSymbol
"    syn clear doxygenRetval
"    syn clear doxygenSpecialEmphasisedWord
"    syn clear doxygenSpecialCodeWord
"    syn clear doxygenSpecialArgumentWord
"    syn clear doxygenSmallSpecial
"    syn clear doxygenSpecialBoldWord

"    syn clear doxygenBody
"    syn clear doxygenBrief
" almost works on its own
"    syn region pythonComment	start="#" end="#" end="^#" end="$" end="^\ze[^#]*$" contains=doxygenBody keepend
"    syn region pythonComment	start="##" end="^\ze[^#]*$" keepend contains=doxygenComment,doxygenStart,doxygenBody
    syn region doxygenStart start="##" end="^\ze[^#]*$" keepend contains=doxygenBody,doxygenStart,doxygenComment
"    syn match doxygenStart +##+ contained nextgroup=doxygenBrief,doxygenPrev,doxygenFindBriefSpecial,doxygenStartSpecial,doxygenStartSkipWhite,doxygenPage skipwhite skipnl
"    syn match doxygenContinueComment contained +\*/\@!#+
"    syn match doxygenContinueComment contained +\s*#+
"  syn match doxygenContinueCommentWhite contained +^\s*\ze\*+ nextgroup=doxygenContinueComment
"  syn match doxygenContinueComment contained +\*/\@!+
"    syn match doxygenContinueCommentWhite contained +^\s*\ze#+ nextgroup=doxygenContinueComment
    syn match doxygenSpecialContinueCommentWhite contained +^\s*\ze#+ nextgroup=doxygenSpecialContinueComment
    syn match doxygenSpecialContinueComment contained +#+
    syn match doxygenContinueCommentWhite contained +^\s*\ze#+ nextgroup=doxygenContinueComment
    syn match doxygenContinueComment contained +\s*#+
"    syn region doxygenSpecialMultilineDesc  start=+.\++ skip=+^\s*\(#\)\(\*/\@!\s*\)\=\(\<\|[@\\]\<\([npcbea]\>\|em\>\|ref\|link\>\>\|f\$\|[$\\&<>]\)\|[^ \t\\@*]\)+ end=+^+ contained contains=doxygenSpecialContinueCommentWhite,doxygenSmallSpecial,doxygenHyperLink,doxygenHashLink,@doxygenHtmlGroup,@Spell  skipwhite keepend
    syn region doxygenSpecialMultilineDesc  start=+.\++ skip=+^\s*\(#\s*\)\(\*/\@!\s*\)\=\(\<\|[@\\]\<\([npcbea]\>\|em\>\|ref\|link\>\>\|f\$\|[$\\&<>]\)\|[^ \t\\@*]\)+ end=+^+ contained contains=doxygenSpecialContinueCommentWhite,doxygenSmallSpecial,doxygenHyperLink,doxygenHashLink,@doxygenHtmlGroup,@Spell  skipwhite keepend

"    syn sync match doxygenComment groupthere pythonComment "/\@<!/\*"
"    syn sync match doxygenSyncComment grouphere doxygenComment "/\@<!/\*[*!]"
"    syn sync match doxygenSyncEndComment groupthere NONE "\*/"



"    syn region doxygenComment	start="#" end="#" end="^#" end="$" end="^\ze[^#]*$" contains=doxygenSyncStart,doxygenStart,doxygenTODO,doxygenLeadingWhite keepend fold
"    syn region pythonComment	start="#" end="#" end="^#" end="$" end="^\ze[^#]*$" contains=doxygenComment keepend


"    syn region pythonComment	start="#" end="^#" end="$" end="^\ze[^#]*$" contains=doxygenBody keepend
"    syn region doxygenBody contained start=+\(/\*[*!]\)\@<!<\|[^<]\|$+ matchgroup=doxygenEndComment end="^\ze[^#]*$" end="#" end="$" end="^#" end=+\*/+re=e-2,me=e-2 contains=doxygenContinueCommentWhite,doxygenTODO,doxygenSpecial,doxygenSmallSpecial,doxygenHyperLink,doxygenHashLink,@doxygenHtmlGroup,@Spell
"    syn region pythonComment	start="#" end="#" end="$" end="^#" contains=@PCCluster keepend
"    syn region pythonComment	start="#" end="^[^#]*$" contains=@PCCluster keepend
"    syn region pythonComment	start="#" end="^[^#]*$" contains=doxygenBody keepend
"    syn region pythonComment	start="#" end="^\ze[^#]*$" contains=doxygenBody keepend
"    syn region pythonComment	start="#" end="^[^#]*$" contains=doxygenBody keepend
"    syn region pythonComment	start="#" end="^\ze[^#]*$" contains=doxygenBody keepend

"    syn cluster PCCluster contains=pythonComment,doxygenBody

"    syn match   pythonComment	"#.*$" contains=pythonTodo,@Spell,doxygenComment
    syn keyword pythonTodo		todo contained

    let doxygen_end_punctuation='[.]'

"    syn clear doxygenBrief
"    exe 'syn region doxygenBrief contained start=+[\\@]\([npcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>#]\)\|[^ \t\\@*]+ start=+\(^\s*\)\@<!\*/\@!+ start=+\<\k+ skip=+'.doxygen_end_punctuation.'\S\@=+ end=+'.doxygen_end_punctuation.'+ end=+\(\s*\(\n\s*\*\=\s*\)[@\\]\([npcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>#]\)\@!\)\@=+ contains=doxygenSmallSpecial,doxygenContinueCommentWhite,doxygenLeadingWhite,doxygenBriefEndComment,doxygenFindBriefSpecial,doxygenSmallSpecial,@doxygenHtmlGroup,doxygenTODO,doxygenHyperLink,doxygenHashLink,@Spell  skipnl nextgroup=doxygenBody'
"    exe 'syn region doxygenBriefL start=+@\k\@!\|[\\@]\([npcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>###]\)\|[^ \t\\@]+ start=+\<+ skip=+'.doxygen_end_punctuation.'\S+ end=+'.doxygen_end_punctuation.'\|$+ contained contains=doxygenSmallSpecial,doxygenHyperLink,doxygenHashLink,@doxygenHtmlGroup,@Spell keepend'
"    syn region doxygenLine start=+@\k\@!\|[\\@]\([npcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>###]\)\|[^ \t\\@<]+ start=+\<+ end='$' contained contains=doxygenSmallSpecial,doxygenHyperLink,doxygenHashLink,@doxygenHtmlGroup,@Spell keepend
"    syn region doxygenFindBriefSpecial start=+[@\\]brief\>+ skip=+^\s*\(\*/\@!\s*\)\=\(\<\|[@\\]\<\([npcbea]\>\|em\>\|ref\|link\>\>\|f\$\|[$\\&<>###]\)\|[^ \t\\@*]\)+ end=+^+ keepend contains=doxygenBriefSpecial nextgroup=doxygenBody keepend skipwhite skipnl contained
"    syn region doxygenBriefLine contained start=+\<\k+ skip=+^\s*\(\*/\@!\s*\)\=\(\<\|[@\\]\<\([npcbea]\>\|em\>\|ref\|link\>\>\|f\$\|[$\\&<>###]\)\|[^ \t\\@*]\)+ end=+^+  skipwhite keepend matchgroup=xxx contains=@Spell
"    syn region doxygenStartSpecial contained start=+[@\\]\([npcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>###]\)\@!+ end=+$+ end=+\*/+me=s-1,he=s-1  contains=doxygenSpecial nextgroup=doxygenSkipComment skipnl keepend

"    syn match doxygenSmallSpecial contained +[@\\]\(\<[npcbea]\>\|\<em\>\|\<ref\>\|\<link\>\|f\$\|[$\\&<>###]\)\@=+ nextgroup=doxygenOtherLink,doxygenHyperLink,doxygenHashLink,doxygenFormula,doxygenSymbol,doxygenSpecial.*Word
"    syn match doxygenSpecial contained +[@\\]\(\<[npcbea]\>\|\<em\>\|\<ref\|\<link\>\>\|\<f\$\|[$\\&<>###]\)\@!+ nextgroup=doxygenParam,doxygenTParam,doxygenRetval,doxygenBriefWord,doxygenBold,doxygenBOther,doxygenOther,doxygenOtherTODO,doxygenOtherWARN,doxygenOtherBUG,doxygenPage,doxygenGroupDefine,doxygenCodeRegion,doxygenVerbatimRegion,doxygenDotRegion
"    syn match doxygenLinkWord "[_a-zA-Z:###()][_a-z0-9A-Z:###()]*\>" contained skipnl nextgroup=doxygenLinkRest,doxygenContinueLinkComment

"    syn match doxygenHashLink /\(\h\w*\)\?###\(\.\w\@=\|\w\+\|::\|()\)\+/ contained contains=doxygenHashSpecial
"    syn match doxygenHashSpecial /###/ contained
"    syn match doxygenHyperLink /\(\s\|^\s*\*\?\)\@<=\(http\|https\|ftp\):\/\/[-0-9a-zA-Z_?&=+###%/.!':;@~]\+/ contained

"    syn clear doxygenSpecialMultilineDesc
"    syn region doxygenSpecialMultilineDesc  start=+.\++ skip=+^\s*\(\*/\@!\s*\)\=\(\<\|[@\\]\<\([npcbea]\>\|em\>\|ref\|link\>\>\|f\$\|[$\\&<>]\)\|[^ \t\\@*]\)+ end=+^+ contained contains=doxygenSpecialContinueCommentWhite,doxygenSmallSpecial,doxygenHyperLink,doxygenHashLink,@doxygenHtmlGroup,@Spell  skipwhite keepend
"    syn match doxygenSymbol contained +[$\\&<>###n]+






endfun

command! OldInspect :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')


"au BufWinEnter * call indent_guides#enable()
"au Syntax * call indent_guides#enablex()
":IndentGuidesEnable
au BufEnter *.tex let b:comments=&comments|se comments=:%
au BufEnter *.tex let b:formatoptions=&formatoptions|se formatoptions+=r
au BufEnter *.tex let b:tw=&tw|se tw=120
au BufEnter *.tex set syntax=tex
au BufLeave *.tex let &tw=b:tw
au BufLeave *.tex let &formatoptions=b:formatoptions
au BufLeave *.tex let &comments=b:comments
au BufEnter * call PreviewSpell()
au BufEnter *.cxx,*.cpp,*.cc,*.c,*.hpp,*.hh,*.h set spelllang=en_gb
au BufEnter *.cxx,*.cpp,*.cc,*.c,*.hpp,*.hh,*.h call AddCppSyntax()
au BufEnter *.cxx,*.cpp,*.cc,*.c,*.hpp,*.hh,*.h,*.pl,*.py set list
au Syntax cpp set spelllang=en_gb
au Syntax cpp call AddCppSyntax()
au Syntax cpp set list
"au Syntax python call AddPythonSyntax()
au Syntax dosini syn match dosiniComment "^[#;].*$"
au Syntax dosini syn region dosiniSpecialKey start="^%" end="%"
au Syntax json syn match CfgComment "#.*"
au Syntax json hi link CfgComment Comment
hi link dosiniSpecialKey Constant
"source ~/.vim/scripts/CTree.vim
set mouse=a
set modelines=10
set hls
set is
set history=5000
set listchars=tab:>-,trail:-
set viminfo='1000,<1000,:1000,@1000,/1000,f1
set ignorecase smartcase
set path+=~/include
set path+=./include
set path+=libs
set path+=./libs
set path+=../libs
set path+=.
set path+=..
set path+=../
set path+=./../include
set path+=externals
set path+=./externals
set path+=../externals
set path+=externals/INCLUDE
set path+=./externals/INCLUDE
set path+=../externals/INCLUDE
set path+=externals/LIBRARY
set path+=./externals/LIBRARY
set path+=../externals/LIBRARY
set path+=../../externals
set path+=../../externals/INCLUDE
set path+=../../externals/LIBRARY
set path+=../../INCLUDE
set path+=../../LIBRARY
set path+=../INCLUDE
set path+=../LIBRARY
set tags+=~/.vim/systags
set infercase
set so=2
set autoindent
set ai
set si
set smarttab
set foldopen+=search
set ruler
set spellsuggest=10
set wim=longest:full
set wildmenu
set visualbell
set ts=8
set title
"set titleold="..."
set hidden
set shortmess=atIoOT
set shiftround
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif

set cino=N-s,g0,t0,+0
set foldlevel=42
set foldlevelstart=42
" set inex as a workaround for vim not correctly searching for files that
" consist of a multiple level path
"set inex=substitute(v:fname,'^','../','g')

command DiffOrig let ftype=&filetype | vert new | set bt=nofile |call setbufvar('%','&filetype',ftype)| r # | 0d_ | diffthis | wincmd p | diffthis
command DO DiffOrig
command RELOAD bfirst | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e | bnext | :e

let perl_extended_vars=1
let php_extended_vars=1
let g:patchreview_tmpdir="/tmp"

let Tlist_Exit_OnlyWindow=1
let Tlist_Inc_WinWidth=0
let treeExplVertical=1

"let OmniCpp_ShowScopeInAbbr = 1
"let OmniCpp_ShowPrototypeInAbbr = 1
"let OmniCpp_GlobalScopeSearch = 0
"let OmniCpp_NamespaceSearch = 2
"let OmniCpp_SelectFirstItem = 2
"let OmniCpp_LocalSearchDecl = 1
"let OmniCpp_MayCompleteDot = 0
"let OmniCpp_MayCompleteArrow = 0

"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabMappingForward = '¬'
"let g:SuperTabMappingForward = '<tab>'
"let g:SuperTabMappingTabLiteral = '<tab>'

"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

let g:miniBufExplVSplit = 30   " column width in chars
"map <silent> <F10> :TMiniBufExplorer<CR>
map <silent> <F10> :MBEToggle<CR>:MBEFocus<CR>:<BS>
nmap <C-Down>  <C-W><Down>
nmap <C-Up>    <C-W><Up>
nmap <C-Left>  <C-W><Left>
nmap <C-Right> <C-W><Right>


tmap <C-Down>  <C-W><Down>
tmap <C-Up>    <C-W><Up>
tmap <C-Left>  <C-W><Left>
tmap <C-Right> <C-W><Right>


nmap <F12> :set syntax=off<CR>ebi/*ea*/:set syntax=on<CR>
"vmap <F12> `<i/*`>lla*/
vmap <F12> :s@\%V.*\%V.@/*&*/<CR>`<

"nmap <F11> :TC<CR>
"vmap <F11> :TC<CR>
nmap <F11> <Plug>NERDCommenterToggle
vmap <F11> <Plug>NERDCommenterToggle

let g:FTCOperateOnFirstColumnOnly = 2
"nmap dx d/\ze[A-Z_]:nohl
nmap dx :let dxp=histget("/",-1)d/\ze[A-Z_]:call histadd("/",dxp):let @/=histget("/",-1)
nmap  :nohl:redraw!
set autoread
au InsertEnter * checktime
nmap <C-Y> :YRShow<CR>


"set fileencodings=latin9,ucs-bom,utf-8,default,latin1

"let g:miniBufExplorerDebugMode  = 2  " Errors will show up in 
"let g:miniBufExplorerDebugLevel = 10 " MBE reports everything
let g:miniBufExplBuffersNeeded = 0
let g:miniBufExplorerAutoStart = 0

"map <F1> :tabp<CR>
map <F2> :tabnew<CR>
map <F3> :cp<CR>
map <F4> :cn<CR>

nnoremap <silent> <F6> :NERDTreeToggle<CR>
"nnoremap <silent> <F7> :TlistToggle<CR>
"nnoremap <silent> <F7> :TagbarToggle<CR>
nnoremap <silent> <S-F7> :TagbarOpen f<CR>
"map <C-F12> :!ctags -R --links=no --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++ --exclude=externals/boost .<CR>
au FileType qf set nospell
au FileType dot set nospell
au FileType cpp set spell
func OpenFullQuicklist()
    for x in getqflist()
"       echo x.bufnr
"       echo x.lnum
"       echo x.col
"       echo x.vcol
"       echo x.nr
"       echo x.pattern
"       echo x.text
"       echo x.type
"	echo x.valid
        if( x.valid == 1)
            :copen
            break
        endif
    endfor
"    sleep 10
endfun

function HtmlEscape()
    silent s/&/\&amp;/eg
    silent s/"/\&quot;/eg
    silent s/</\&lt;/eg
    silent s/>/\&gt;/eg
endfunction

command -range HESC :<line1>,<line2>call HtmlEscape()

set spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+

let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_returnTag="@returns "
let g:DoxygenToolkit_compactDoc="yes"

au QuickFixCmdPost make call OpenFullQuicklist()
"command Make :make -j 16 CC=distcc CXX="distcc g++"<CR>
"command Make :make<CR>


"map <silent> <F10> :call ToggleBufferExplorer()<CR>
map <silent> <F5> :FilesystemExplorer<CR>
"map <esc>r <A-r>
let SVNAutoCommitDiff='1'
"let SVNCommandSplit='vertical'
"let SVNCommandDiffSplit='vertical'
let SVNCommandEnableBufferSetup='1'
let SVNCommandEdit='split'
let SVNCommandNameResultBuffers='1'

let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<c-tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:UltiSnipsDoHash=1
let g:UltiSnipsEditSplit="vertical"

set completeopt=menuone,menu,popup
"let g:clang_complete_auto=0
"let g:clang_snippets=1
"let g:clang_conceal_snippets=1
"let g:clang_snippets_engine='ultisnips'
"let g:clang_auto_select=1
"let g:clang_use_library=1
"let g:clang_library_path='/home/plasmahh/opt/clang/lib/'
"let g:clang_library_path='/usr/lib64/'
"let g:clang_user_options="-stdlib=libc++ -isystem /home/plasmahh/svn/libcxx/include"
"let g:clang_user_options="-x c++ -std=gnu++11 -I.. -I../.. -Iexternals -Iexternals/xerces-c/xerces_3_1_1/include -Iexternals/boost/boost_1_51_0/include/" 
"-stdlib=libstdc++ -isystem /home/plasmahh/opt/gcc472/include/c++/4.7.2/ -isystem /home/plasmahh/opt/gcc472/include/c++/4.7.2/x86_64-unknown-linux-gnu -isystem /home/plasmahh/opt/gcc472/lib64/gcc/x86_64-unknown-linux-gnu/4.7.2/include/"
"let g:clang_sort_algo='alpha'
"let g:clang_complete_macros=1
"let g:clang_periodic_quickfix = 1
"let g:clang_complete_copen = 1

"setlocal completefunc=ClangComplete                                                                                   
"setlocal omnifunc=ClangComplete

"command CE call g:ClangUpdateQuickFix()
let g:clang_debug = 1

let g:Imap_UsePlaceHolders=0

fun Autoconst()
    :normal! yy
    :s /autoconst\s*//g
    :normal! p
    :s /autoconst/const/g
endfun

command Ac call Autoconst()

fun Seq()
    let ret = g:i
    let g:i = g:i + 1
    return ret
endfun

func Ocsearch(sval)
"    :let @/ = a:0
    :let @/ = a:sval
    :normal! /a:sval
    :normal! n
    :Occur
endfun
command -nargs=1 Oc call Ocsearch('<args>')
"map <F1> :execute "noautocmd vimgrep /" . expand("<cword>") . "/j " . expand("*.c *.cc *.cxx *.cpp *.h *.hpp *.pl *.py") <Bar> cw<CR>
map <F1> :execute "Grep " . expand("<cword>") . " *.c *.cc *.cxx *.cpp *.h *.hpp *.pl *.py" <Bar> cw<CR>
map <F1> :Rg<CR>
let g:rg_highlight=1
let g:rg_derive_root=1

set laststatus=1
"function! InsertStatuslineColor(mode)
"  if a:mode == 'i'
"    hi StatusLine term=bold,reverse cterm=bold ctermfg=237 ctermbg=157 gui=bold guifg=#3a3a3a guibg=#afffaf
"  elseif a:mode == 'r'
"    hi statusline guibg=blue
"    hi StatusLine term=bold,reverse cterm=bold ctermfg=237 ctermbg=153 gui=bold guifg=#3a3a3a guibg=#afafff
"  else
"    hi statusline guibg=red
"    hi StatusLine term=bold,reverse cterm=bold ctermfg=237 ctermbg=223 gui=bold guifg=#3a3a3a guibg=#ffafaf
"  endif
"endfunction
"
"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi StatusLine term=bold,reverse cterm=bold ctermfg=237 ctermbg=15 gui=bold guifg=#3a3a3a guibg=#ffffff
"hi StatusLine term=bold,reverse cterm=bold ctermfg=237 ctermbg=15 gui=bold guifg=#3a3a3a guibg=#ffffff

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" find a way to make this be not so super incredibly slow. It was faster in
" 7.1, but somewhere the someone put in some security patch which made
" everything go like melassis

func Re_fold()
    :setlocal nofen
    :setlocal fdm=syntax
    :normal! zx
    :setlocal fdm=manual
    :setlocal fen
endfun

"set fdm=syntax

command Refold call Re_fold()

"perl << EOF
"sub Perl_Re_Place{
"local $f=VIM::Eval('a:from');
"local $t=VIM::Eval('a:to');
"s/($f)/$1 ^ uc $1 ^ $t/gei
"}
"EOF

"func Re_Place(from,to)
"    perl Perl_Re_Place
"endfun

"command -nargs=* Replace call Re_Place(<f-args>)

"nnoremap <expr> <c-x> match(expand('<cword>'), '[-+]\?\d\+') == -1 ? ":call Toggle()<CR>" : ":normal! \<c-x>\<cr>"
"nnoremap <expr> <c-a> match(expand('<cword>'), '[-+]\?\d\+') == -1 ? ":call Toggle()<CR>" : ":normal! \<c-a>\<cr>"

"nnoremap <c-a> ":normal! \<c-a><cr>"

let g:speeddating_no_mappings = 1
function! Sincrement()
    let save_pos = getcurpos()
    :execute "normal! " . v:count . "\<c-a>\<cr>"
    call setpos(".",save_pos)
endfunction

function! Sdecrement()
    let save_pos = getcurpos()
    :execute "normal! " . v:count . "\<c-x>\<cr>"
    call setpos(".",save_pos)
endfunction



nmap <Plug>SwapItFallbackIncrement <Plug>SpeedDatingUp
nmap <Plug>SwapItFallbackDecrement <Plug>SpeedDatingDown

"nmap <Plug>SpeedDatingFallbackUp :<C-U>normal! <C-A><CR>
nmap <Plug>SpeedDatingFallbackUp :<C-U>call Sincrement()<CR>
nmap <Plug>SpeedDatingFallbackDown :<C-U>call Sdecrement()<CR>

"nmap <Plug>SpeedDatingFallbackDown :<C-U>normal! <C-X><CR>

"autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
"autocmd Syntax        *.cxx,*.cpp,*.cc,*.c,*.hpp,*.hh,*.h *.cxx,*.cpp call Re_fold()
autocmd BufWritePost  *.cxx,*.cpp,*.cc,*.c,*.hpp,*.hh,*.h call Re_fold()
autocmd BufEnter      *.cxx,*.cpp,*.cc,*.c,*.hpp,*.hh,*.h call Re_fold()
"autocmd InsertLeave   *.cxx,*.cpp,*.cc,*.c,*.hpp,*.hh,*.h call Re_fold()
"autocmd InsertEnter   *.cxx,*.cpp,*.cc,*.c,*.hpp,*.hh,*.h call Re_fold()


"autocmd BufEnter      *.cxx,*.cpp,*.cc,*.c,*.hpp,*.hh,*.h call UltiSnips_FileTypeChanged()
au BufEnter svn-commit*.tmp :1
au BufEnter *.idl set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
au BufEnter *.idl set formatoptions=croql

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd  ctermbg=232 ctermfg=234 guifg=#222222 guibg=#000000
hi IndentGuidesEven ctermbg=233 ctermfg=234 guifg=#222222 guibg=#151515

call pathogen#infect()

" removed / from default
let g:yankring_zap_keys = 'f F t T ? @'
"let g:yankring_min_element_length = 2

set colorcolumn=80,120
set textwidth=120
"set textwidth=0

nnoremap <expr> sp '`[' . strpart(getregtype(), 0, 1) . '`]'
set fileformats=unix,dos,mac
set nojoinspaces


let g:sparkupExecuteMapping = '<c-g>'
"g:sparkupExecuteMapping (Default: '<c-e>') -
"Mapping used to execute sparkup.

let g:sparkupNextMapping = '<c-b>'
"g:sparkupNextMapping (Default: '<c-n>') -
"Mapping used to jump to the next empty tag/attribute.

let g:gundo_prefer_python3 = 1
nnoremap <F5> :GundoToggle<CR>
let b:txtfmtNested=1
let b:txtfmtConceal=1
"au BufNewFile,BufNew,BufRead *.otl set ft=vo_base.txtfmt
au BufNewFile,BufNew,BufRead *.otl colorscheme vo_dark
au BufNewFile,BufNew,BufRead *.html let g:ycm_auto_trigger=0
au BufNewFile,BufNew,BufRead *.html imap <C-SPACE> <c-x><c-u>
au BufNewFile,BufNew,BufRead *.html imap <Nul> <c-x><c-u>
"au BufNewFile,BufNew,BufRead *.md set conceallevel=2
au BufNewFile,BufNew,BufRead *.json set conceallevel=0


let g:alternateNoDefaultAlternate = 1

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_echo_current_diagnostic = 0

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 1
let g:ycm_server_python_interpreter = "/usr/bin/python3"
let g:ycm_python_binary_path = "/usr/bin/python3"
let g:ycm_ultisnips_completer = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_max_num_candidates = 42
let g:ycm_max_num_identifier_candidates = 10

let g:ycm_enable_inlay_hints = 1
let g:ycm_echo_current_diagnostic = 1
let g:ycm_enable_semantic_highlighting=1

let g:ycm_extra_conf_globlist = [ '/home/lbt/git/nextgen*/*', '/home/lbt/git/alt.tools/*' ]


nnoremap <S-F10> :YcmCompleter GoToReferences<CR>
nnoremap <C-F10> :YcmCompleter RecatorRename<SPACE>
nnoremap <S-F11> :YcmCompleter GoToInclude<CR>
nnoremap <C-F11> :YcmCompleter GoToAlternateFile<CR>
nnoremap <S-F12> :YcmCompleter GoToDefinition<CR>
nnoremap <C-F12> :YcmCompleter GoToDeclaration<CR>

nnoremap <silent> <leader>h <Plug>(YCMToggleInlayHints)

nmap <Leader>F :YcmCompleter FixIt<CR>
nmap <silent> <leader>f <Plug>(YCMFindSymbolInWorkspace)
nmap <silent> <leader>fw <Plug>(YCMFindSymbolInWorkspace)
nmap <silent> <leader>fd <Plug>(YCMFindSymbolInDocument)

nmap <silent> <leader>yh <Plug>(YCMTypeHierarchy)
nmap <silent> <leader>yc <Plug>(YCMCallHierarchy)
nmap <silent> <leader>yr :YcmCompleter RefactorRename

let MY_YCM_HIGHLIGHT_GROUP = {
\			'namespace': 'cppSTD',
\			'type':	'Type',
\			'class':	'cppType',
\			'enum':	'cppEnum',
\			'interface':	'ChooseMe',
\			'struct':	'cppType',
\			'typeParameter':	'cppParam',
\			'parameter':	'cppParam',
\			'variable':	'Normal',
\			'property':	'cppMember',
\			'enumMember':	'cppEnum',
\			'enumConstant':	'ChooseMe',
\			'event':	'ChooseMe',
\			'function':	'Normal',
\			'member':	'ChooseMe',
\			'macro':	'PreProc',
\			'method':	'cppMember',
\			'keyword':	'ChooseMe',
\			'modifier':	'cppOverride',
\			'comment':	'Comment',
\			'string':	'ChooseMe',
\			'number':	'ChooseMe',
\			'regexp':	'ChooseMe',
\			'operator':	'cppMember',
\			'unknown':	'Normal',
\			'annotation':   'PreProc'
      \ }


for tokenType in keys( MY_YCM_HIGHLIGHT_GROUP )
  call prop_type_add( 'YCM_HL_' . tokenType,
                    \ { 'highlight': MY_YCM_HIGHLIGHT_GROUP[ tokenType ] } )
endfor


let g:bookmark_highlight_lines = 0
"let g:bookmark_display_annotation = 1
let g:bookmark_location_list = 1
let g:bookmark_auto_save = 1
let g:bookmark_manage_per_buffer = 1 

" Finds the Git super-project directory based on the file passed as an argument.
function! g:BMBufferFileLocation(file)
    let filename = 'vim-bookmarks'
    let location = ''
    if isdirectory(fnamemodify(a:file, ":p:h").'/.git')
        " Current work dir is git's work tree
        let location = fnamemodify(a:file, ":p:h").'/.git'
    else
        " Look upwards (at parents) for a directory named '.git'
        let location = finddir('.git', fnamemodify(a:file, ":p:h").'/.;')
    endif
    if len(location) > 0
        return simplify(location.'/.'.filename)
    else
        return simplify(fnamemodify(a:file, ":p:h").'/.'.filename)
    endif
endfunction

"inoremap <C-SPACE> call s:InvokeCompletion()

"let g:ycm_server_log_level = 'debug'
"let g:ycm_server_keep_logfiles = 1
if has('nvim')
    set undodir=~/.nvimundo/
else
    set undodir=~/.vimundo/
endif
set undofile

" A function to clear the undo history
function! <SID>ForgetUndo()
    let old_undolevels = &undolevels
    set undolevels=-1
"    exe "normal a \<BS>\<Esc>"
    edit!
"    exe "normal m-1"
    let &undolevels = old_undolevels
    unlet old_undolevels
    edit!
endfunction
command -nargs=0 ClearUndo call <SID>ForgetUndo()

nnoremap <a-up> 4<c-y>
nnoremap <a-down> 4<c-e>

xnoremap <silent> DO :diffget<CR>
xnoremap <silent> DP :diffput<CR>

vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

let g:easy_align_delimiters = {}
let g:easy_align_delimiters['d'] = {
\ 'pattern': ' \(\S\+\s*[;=]\)\@=',
\ 'left_margin': 0, 'right_margin': 0
\ }

let g:c_no_cformat=1

let g:netrw_liststyle=3
let g:netrw_banner = 0
let g:netrw_altv = 1

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_time_format = "%Y.%m.%d %H:%M:%S"


:nnoremap <MiddleMouse> <LeftMouse><MiddleMouse>
if !has('nvim')
    set ttymouse=sgr
endif
let g:airline_powerline_fonts = 1

let g:csv_delim = ';'
let g:csv_delim_test = ';,|'
let g:csv = '%1*%{&ft=~"csv" ? CSV_WCol("Name") . " " . CSV_WCol() : ""}%*'
let g:airline#extensions#csv#column_display = "Name"
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent' ]

let g:airline#extensions#ycm#enabled = 1
let g:csv_no_conceal = 1



"function! VisualSelectionSize()
"    if mode() == "v"
"	" Exit and re-enter visual mode, because the marks
"	" ('< and '>) have not been updated yet.
"	exe "normal \<ESC>gv"
"	if line("'<") != line("'>")
"	    return (line("'>") - line("'<") + 1) " . ' lines'
"	else
"	    return (col("'>") - col("'<") + 1) " . ' chars'
"	endif
"    elseif mode() == "V"
"	exe "normal \<ESC>gv"
"	return (line("'>") - line("'<") + 1) " . ' lines'
"    elseif mode() == "\<C-V>"
""	exe "normal \<ESC>gv"
"	return (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) " . ' block'
"    else
"	return ''
"    endif
"endfunction
"
"function! AirlineInit()
"    let spc = g:airline_symbols.space
""    call airline#parts#define_raw('linenr', '%l')
""    call airline#parts#define_accent('linenr', 'bold')
""    let g:airline_section_z = airline#section#create(['%3p%%', g:airline_symbols.linenr, 'linenr', ':%c'])
""    call airline#parts#define('linenr', { 'raw': '%{g:airline_symbols.linenr}%4l', 'accent': 'bold'})
"    call airline#parts#define('linenr', { 'raw': '%{g:airline_symbols.linenr}%{VisualSelectionSize()}%4l', 'accent': 'bold'})
"    if winwidth(0) > 80
"      let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%3p%%'.spc, 'linenr', 'maxlinenr', '%5(%c%V%)'])
"    else
"      let g:airline_section_z = airline#section#create(['%3p%%'.spc, 'linenr',  'S:%3v'])
"    endif
"
""    let g:airline_section_z = "%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# X:%3v"
"    call airline#update_statusline()
"endfunction
"
"autocmd VimEnter * call	 AirlineInit()

function! VisualSelectionSize()
	let spc = g:airline_symbols.space
	if mode() ==# "\<C-V>"
		return (abs(line('v') - line('.')) + 1) . 'x' . (abs(virtcol('v') - virtcol('.')) + 1) . spc . (airline#util#winwidth() > 79 ? 'block' . spc : '')
	elseif mode() ==# 'V' || line('v') != line('.')
		return (abs(line('v') - line('.')) + 1) . spc  . (airline#util#winwidth() > 79 ? 'lines' . spc : '')
	else
		return (abs(virtcol('v') - virtcol('.')) + 1)   . spc  . (airline#util#winwidth() > 79 ? 'chars' . spc : '')
	endif
endfunction

function! MyColumnFuncLong()
	return col('.') . (virtcol('.')==col('.') ? '' : '-' . virtcol('.'))
endfunction

function! MyColumnFuncShort()
	return virtcol('.')
endfunction

function! AirlineInit()
	let spc = g:airline_symbols.space
	call airline#parts#define_function('MyVisualSelection','VisualSelectionSize')
	call airline#parts#define_condition('MyVisualSelection', 'mode() =~? "v" || mode() ==# "\<C-V>"')	
	call airline#parts#define_function('MyColumnLong','MyColumnFuncLong')
	call airline#parts#define_condition('MyColumnLong','airline#util#winwidth() > 79')
	call airline#parts#define_minwidth('MyColumnLong',5)
	call airline#parts#define_function('MyColumnShortNum','MyColumnFuncShort')
	call airline#parts#define_condition('MyColumnShortNum','airline#util#winwidth() <= 79')
	call airline#parts#define_minwidth('MyColumnShortNum',3)
	call airline#parts#define_text('MyColumnShortText','S:')
	call airline#parts#define_condition('MyColumnShortText','airline#util#winwidth() <= 79')
	let g:airline_section_z = airline#section#create(['MyVisualSelection']) . split(g:airline_section_z,'%v')[0] . airline#section#create(['MyColumnLong','MyColumnShortText','MyColumnShortNum'])
	:AirlineRefresh
endfun

augroup AirlineCustomization
	au!
	au User AirlineAfterInit ++once call AirlineInit()
augroup END

let g:airline_mode_map = {
        \ '__' : '--',
        \ 'c'  : 'C',
        \ 'i'  : 'I',
        \ 'ic' : 'IC',
        \ 'ix' : 'IX',
        \ 'n'  : 'N',
        \ 'ni' : 'NI)',
        \ 'no' : 'NO',
        \ 'R'  : 'R',
        \ 'Rv' : 'Rv',
        \ 's'  : 'S',
        \ 'S'  : 'SL',
        \ '' : 'SB',
        \ 't'  : 'T',
        \ 'v'  : 'V',
        \ 'V'  : 'VL',
        \ '' : 'VB',
        \ }

let g:airline_symbols =  { 'spell' : 'S', 'colnr' : ' N:' }
let g:airline#extensions#whitespace#mixed_indent_format = 'mixed[%s]'
let g:airline#extensions#whitespace#mixed_indent_algo = 1


function! WindowNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
    return 0
endfunction

call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')

let g:VM_mouse_mappings = 1
let g:VM_default_mappings = 0
let g:VM_no_meta_mappings = 0

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

set rtp+=~/.fzf
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

set formatoptions-=r
set formatoptions-=t

let g:vmt_include_headings_before = 1

map <Leader> <Plug>(easymotion-prefix)

" <Leader>f{char} to move to {char}
"map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
"map <Leader>s <Plug>(easymotion-overwin-f2)
"nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

hi link EasyMotionIncSearch Search

hi link StartifyBracket Repeat
hi link StartifyFooter  Repeat
hi link StartifyHeader  Constant
hi link StartifyNumber  Typedef
hi link StartifyPath    cppSTD
hi link StartifySlash   cppSTD
hi link StartifySpecial Title

hi link StartifyFile    TabLineSel
hi link StartifySection Structure
hi link StartifySelect  Define
hi link StartifyVar     Repeat


let g:startify_session_autoload = 1
let g:startify_session_sort = 1
let g:startify_session_persistence = 1

let g:tagbar_width = 42

let g:webdevicons_enable_vimfiler = 1
let g:webdevicons_enable = 1

let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = '📓'
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '📁'

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['mp3'] = ' ♫'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['mp4'] = '🎬'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['zip'] = 'xx'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ini'] = '🔧'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cfg'] = '🔧'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['conf'] = '🔧'

let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = { }
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.vimrc'] =  '🔧'

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = { }
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*.vimrc$'] =  '🔧'


let g:startify_fortune_use_unicode = 1
let g:startify_custom_header = map( startify#fortune#boxed(), '"   ".v:val')
let g:startify_change_to_vcs_root = 1
let g:startify_session_before_save = [ 'silent! tabdo NERDTreeClose' ]
"let g:startify_use_env = 1


let g:NERDTreeGitStatusConcealBrackets = 1
let NERDTreeHijackNetrw = 0
let g:NERDTreeGitStatusUseNerdFonts = 0
"let g:NERDTreeGitStatusConcealBrackets = 0
"let g:NERDTreeLimitedSyntax = 0
"let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
"let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', "c++", "cxx", "hpp", "tcc", "py", "md", "txt", "ini", "png", "jpg", "dot", 'cpp', 'php', 'rb', 'js', 'css', 'html',"cfg", "bmp", "vim", "java","xml"]
let g:NERDTreeSyntaxEnabledExactMatches = [ "Makefile", "makefile", "Makefile.definition"]

let g:NERDDefaultAlign = "start"
let g:NERDSpaceDelims = 0
let g:NERDCustomDelimiters = { "python": { "left" : "#" } }

let g:rainbow_active = 1
"\    'parentheses': ['start=/{/ end=/}/ fold', 'start=/</ end=/>/ fold'],
let g:rainbow_conf = {
\    "guifgs" : [ "white", "lightred", "lightcyan", "lightblue", "lightyellow", "lightgreen", "grey", "lightgrey", "magenta", "yellow", "green", "cyan", "darkcyan", "darkgrey", "blue" ],
\	"operators": 0,
\	"separately": {
    \ "nerdtree": 0,
    \    "cpp" : {
\    'parentheses': ['start=/{/ end=/}/ fold' ],
\	}
	    \    }
\    }


"let g:vista_default_executive = 'ale'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1


"nnoremap <silent> <F7> :Vista!!<CR>
nnoremap <silent> <F7> :TagbarToggle<CR>
let g:ale_linters = { 'cpp' : ['clangd'] }
let g:ale_linters_explicit = 1

let g:ale_completion_enabled = 0
"let g:ale_cpp_clangcheck_options = '--extra-arg=-std=gnu++2b --extra-arg=-Wall --extra-arg=-Wextra'
"let g:ale_cpp_clangd_options = 

let g:ale_echo_msg_format = '%linter%:%s'
let g:ale_loclist_msg_format = '%linter%:%s'
let g:ale_virtualtext_prefix = '%linter%:%type%:'

let g:ale_enabled = 1

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0

set updatetime=500
fun SamsonCpp()
    if( expand('%:p:h') =~ '.*git/nextgen.*' )
	set ft=cpp tabstop=4 shiftwidth=4 noexpandtab spelllang=de,en
    endif
endfun

au BufEnter *.cpp,*.h,*.c,*.cxx,*.hpp.*.hxx call SamsonCpp()
command A SHSwitch

let g:PreviewBrowsers    = 'google-chrome,google-chrome-stable'

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

"    let cmd = printf('%s --git-dir="%s" rev-parse --show-toplevel', g:committia#git#cmd, escape(git_dir, '\'))
"    let out = s:system(cmd)

    let out = system('git rev-parse --abbrev-ref HEAD')
    let replacement = out[:-2] " what is that char at the end? really a NUL?

    call setline(1, map(getline(1,'$'), {k,v -> substitute(v, '<CURRENT-BRANCH>', replacement,'g' )}))
    " If no commit message, start with insert mode
"    if a:info.vcs ==# 'git' && getline(1) ==# ''
"        startinsert
"    endif
    startinsert!

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

au VimEnter * silent call doge#install({ 'headless': 1 })
let g:doge_doxygen_settings = {
    \    'char' : '\'
    \}
let g:doge_doc_standard_python = "doxygen"

com! CheckHighlightUnderCursor echo {l,c,n ->
        \   'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
        \  .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
        \  .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
        \ }(line("."), col("."), "name")

let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_anchorexpr = "'# '.substitute(v:anchor,'-',' ','').''"

set ttimeoutlen=10
call execute('imap <Esc>')->split("\n")->map({k,v -> 'iunmap '.split(v)[1]})->execute()

command Color source ~/vimcol.vim



let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Staged'    :'✹',
                \ 'Modified'  :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }


let g:nerdtree_vis_confirm_open = 0
"let g:NERDTreeGitStatusUseNerdFonts = 1 " you should install nerdfonts by yourself. default: 0

nmap <C-W>o <Plug>(zoom-toggle)

let g:markdown_minlines=200
let g:rainbow_active = 0

au BufNewFile,BufNew,BufRead *.cpp,*.h,*.hpp,*.c,*.cxx RainbowToggle
au BufNewFile,BufNew,BufRead *.py RainbowToggle
au BufNewFile,BufNew,BufRead *.json RainbowToggle
au BufNewFile,BufNew,BufRead *.html,*.xml,*.xhtml RainbowToggle

au BufNewFile,BufNew,BufRead /home/lbt/*.cpp,/home/lbt/*.h,/home/lbt/*.hpp,/home/lbt/*.c,/home/lbt/*.cxx set ts=4
"autocmd BufNewFile,BufRead,BufReadPre,BufAdd,BufNew ~/git/devdoc/docs/* set dir=/tmp//
"autocmd BufNewFile,BufRead,BufReadPre,BufAdd,BufNew ~/git/devdoc/docs/* noswapfile

let g:ollama_host = 'http://localhost:11434'

let g:ollama_chat_model = 'qwen2.5-coder:7b-instruct-q6_K'
let g:ollama_model = 'qwen2.5-coder:7b-instruct-q6_K'
let g:ollama_fim_prefix = '<|fim_prefix|>'
let g:ollama_fim_middle = '<|fim_middle|>'
let g:ollama_fim_suffix = '<|fim_suffix|>'

packadd helptoc
packadd matchit
"let g:ale_set_quickfix = 0
"let g:ale_set_loclist = 0
"let g:ale_open_list = 1
"imap <c-x><c-f> <plug>(fzf-complete-path)
"let g:NERDRemoveExtraSpaces = 1
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

"inoremap <silent><expr> ( complete_parameter#pre_complete("()")

"nmap <c-j> <Plug>(complete_parameter#goto_next_parameter)
"smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
"imap <c-j> <Plug>(complete_parameter#goto_next_parameter)

"nmap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
"smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
"imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

"let g:complete_parameter_use_ultisnips_mapping = 1
"autocmd FuncUndefined * exe 'runtime autoload/' . expand('<afile>') . '.vim'
" ~/.vimrc ends here
