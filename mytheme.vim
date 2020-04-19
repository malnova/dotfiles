"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" T H È M E   D ' O R I G I N E                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Le thème d'origine se trouve à l'emplacement suivant :
" $VIMRUNTIME/colors/peachpuff.vim
" Les modifications au thème d'origine sont signalées par "!!!
"
" Pour afficher la liste des numéros et noms de couleurs disponibles,
" utiliser la commande :h cterm-colors
" Pour afficher la liste des arguments disponibles pour cterm, utiliser
" la commande :h highlight-args
" Pour afficher la liste des groupes (highlighting groups) disponibles
" par défaut, utiliser la commande :h highlight-groups
" Pour afficher la liste de tous les groupes actuellement définis
" dans leur configuration présente, utiliser la commande :highlight

" Vim color file
" Maintainer: David Ne\v{c}as (Yeti) <yeti@physics.muni.cz>
" Last Change: 2003-04-23
" URL: http://trific.ath.cx/Ftp/vim/colors/peachpuff.vim

" This color scheme uses a peachpuff background (what you've expected when it's
" called peachpuff?).
"
" Note: Only GUI colors differ from default, on terminal it's just `light'.

" First remove all existing highlighting.
"!!! set background=light
set background=dark
"!!! hi clear " Si actif, surlignage incorrect des erreurs (ou des problèmes de fichier swap, etc.) en blanc sur rouge avant l'ouverture de vim
if exists("syntax_on")
  syntax reset
endif

"!!! let colors_name = "peachpuff"
let colors_name = "mytheme"

hi Normal guibg=PeachPuff guifg=Black

hi SpecialKey term=bold ctermfg=4 guifg=Blue
hi NonText term=bold cterm=bold ctermfg=4 gui=bold guifg=Blue
hi Directory term=bold ctermfg=4 guifg=Blue
"!!! hi ErrorMsg term=standout cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi IncSearch term=reverse cterm=reverse gui=reverse
"!!! hi Search term=reverse ctermbg=3 guibg=Gold2
hi MoreMsg term=bold ctermfg=2 gui=bold guifg=SeaGreen
"!!! hi ModeMsg term=bold cterm=bold gui=bold
"!!! hi LineNr term=underline ctermfg=3 guifg=Red3
hi Question term=standout ctermfg=2 gui=bold guifg=SeaGreen
"!!! hi StatusLine term=bold,reverse cterm=bold,reverse gui=bold guifg=White guibg=Black
"!!! hi StatusLineNC term=reverse cterm=reverse gui=bold guifg=PeachPuff guibg=Gray45
"!!! hi VertSplit term=reverse cterm=reverse gui=bold guifg=White guibg=Gray45
hi Title term=bold ctermfg=5 gui=bold guifg=DeepPink3
"!!! hi Visual term=reverse cterm=reverse gui=reverse guifg=Grey80 guibg=fg
hi WarningMsg term=standout ctermfg=1 gui=bold guifg=Red
hi WildMenu term=standout ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow
"!!! hi Folded term=standout ctermfg=4 ctermbg=7 guifg=Black guibg=#e3c1a5
"!!! hi FoldColumn term=standout ctermfg=4 ctermbg=7 guifg=DarkBlue guibg=Gray80
"!!! hi DiffAdd term=bold ctermbg=4 guibg=White
"!!! hi DiffChange term=bold ctermbg=5 guibg=#edb5cd
"!!! hi DiffDelete term=bold cterm=bold ctermfg=4 ctermbg=6 gui=bold guifg=LightBlue guibg=#f6e8d0
"!!! hi DiffText term=reverse cterm=bold ctermbg=1 gui=bold guibg=#ff8060
hi Cursor guifg=bg guibg=fg
hi lCursor guifg=bg guibg=fg

" Colors for syntax highlighting
hi Comment term=bold ctermfg=4 guifg=#406090
hi Constant term=underline ctermfg=1 guifg=#c00058
hi Special term=bold ctermfg=5 guifg=SlateBlue
"!!! hi Identifier term=underline ctermfg=6 guifg=DarkCyan
hi Statement term=bold ctermfg=3 gui=bold guifg=Brown
hi PreProc term=underline ctermfg=5 guifg=Magenta3
hi Type term=underline ctermfg=2 gui=bold guifg=SeaGreen
hi Ignore cterm=bold ctermfg=7 guifg=bg
"!!! hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi Todo term=standout ctermfg=0 ctermbg=3 guifg=Blue guibg=Yellow


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" M O D I F I C A T I O N S   P E R S O N N E L L E S "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Couleurs différentes pour vimdiff
hi DiffChange ctermfg=white ctermbg=none
hi DiffText ctermfg=darkblue ctermbg=none cterm=underline,bold
hi DiffAdd ctermfg=darkgreen ctermbg=none cterm=bold
hi DiffDelete ctermfg=red ctermbg=none
" Couleurs différentes pour le correcteur d'orthographe
if has('spell')
    hi clear SpellBad
    hi SpellBad ctermfg=red cterm=underline
    hi clear SpellCap
    hi SpellCap ctermfg=white cterm=underline
    hi clear SpellRare
    hi SpellRare ctermfg=5 cterm=underline
    hi clear SpellLocal
    hi SpellLocal ctermfg=5 cterm=underline
endif
" Couleurs différentes pour la recherche
hi Search ctermfg=black ctermbg=3
if !empty(glob("~/.config/nvim/bundle/vim-searchant"))
    hi SearchCurrent ctermfg=black ctermbg=red cterm=bold
endif
" Couleurs de la tabline (plugin Buftabline)
if !empty(glob("~/.config/nvim/bundle/vim-buftabline"))
    hi BufTabLineCurrent ctermfg=white ctermbg=black cterm=underline,bold
    hi BufTabLineActive ctermfg=white ctermbg=black cterm=bold
    hi BufTabLineHidden ctermfg=5 ctermbg=black cterm=none
    hi BufTabLineFill ctermbg=0
endif
" Couleurs de la barre de statut
hi StatusLineNC ctermfg=5 ctermbg=black cterm=none
function! SetWindowFocused()
    hi clear StatusLine
    hi StatusLine ctermfg=black ctermbg=5 cterm=bold
endfunction
function! SetWindowUnfocused()
    hi clear StatusLine
    hi StatusLine ctermfg=5 ctermbg=black cterm=none
endfunction
augroup BgHighlight
    autocmd!
    autocmd BufEnter,FocusGained * call SetWindowFocused()
    autocmd BufLeave,FocusLost * call SetWindowUnfocused()
augroup END
" Couleurs pours les espaces surnuméraires en fin de ligne
hi ExtraWhitespace ctermbg=DarkGray
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter,WinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" Surlignement des espaces insécables
hi NonBreakingSpace ctermbg=DarkGray
2match NonBreakingSpace " "
autocmd BufWinEnter,WinEnter * 2match NonBreakingSpace " "
" Autres changements de couleurs
hi Visual ctermfg=black ctermbg=blue
hi clear MatchParen
hi MatchParen ctermfg=white ctermbg=DarkGray
hi Error ctermfg=black ctermbg=red cterm=bold
hi ErrorMsg ctermfg=black ctermbg=red cterm=bold
hi LineNr ctermfg=5 ctermbg=black cterm=none
hi CursorLineNr ctermfg=white ctermbg=black cterm=bold
hi FoldColumn ctermfg=white ctermbg=black cterm=bold
hi VertSplit ctermfg=black ctermbg=none cterm=none
hi Folded ctermfg=black ctermbg=green cterm=bold
hi ModeMsg ctermfg=white
hi ColorColumn ctermfg=black
hi Identifier ctermfg=6 cterm=none
