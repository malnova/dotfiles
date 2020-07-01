"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" T H È M E   D ' O R I G I N E                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Le thème d'origine se trouve à l'emplacement suivant :
" $VIMRUNTIME/colors/peachpuff.vim
" TOUTES les références à une version gui (guifg, guibg...) ont été
" supprimées.
" Les autres modifications au thème d'origine sont signalées par "!!!
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
"!!! set background=dark " Inutile, et entraîne un 2e chargement de syncolor.vim
"!!! hi clear " Si actif, surlignage incorrect des erreurs (ou des problèmes de fichier swap, etc.) en blanc sur rouge avant l'ouverture de vim
"!!! if exists("syntax_on") " Inutile ? Entraîne un 2e chargement de syncolor.vim
"!!!   syntax reset
"!!! endif

"!!! let colors_name = "peachpuff"
let colors_name = "mytheme"

"!!! hi Normal guibg=PeachPuff guifg=Black

hi SpecialKey term=bold ctermfg=4
hi NonText term=bold cterm=bold ctermfg=4
hi Directory term=bold ctermfg=4
"!!! hi ErrorMsg term=standout cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi IncSearch term=reverse cterm=reverse
"!!! hi Search term=reverse ctermbg=3 guibg=Gold2
hi MoreMsg term=bold ctermfg=2
"!!! hi ModeMsg term=bold cterm=bold gui=bold
"!!! hi LineNr term=underline ctermfg=3 guifg=Red3
hi Question term=standout ctermfg=2
"!!! hi StatusLine term=bold,reverse cterm=bold,reverse gui=bold guifg=White guibg=Black
"!!! hi StatusLineNC term=reverse cterm=reverse gui=bold guifg=PeachPuff guibg=Gray45
"!!! hi VertSplit term=reverse cterm=reverse gui=bold guifg=White guibg=Gray45
hi Title term=bold ctermfg=5
"!!! hi Visual term=reverse cterm=reverse gui=reverse guifg=Grey80 guibg=fg
hi WarningMsg term=standout ctermfg=1
hi WildMenu term=standout ctermfg=0 ctermbg=3
"!!! hi Folded term=standout ctermfg=4 ctermbg=7 guifg=Black guibg=#e3c1a5
"!!! hi FoldColumn term=standout ctermfg=4 ctermbg=7 guifg=DarkBlue guibg=Gray80
"!!! hi DiffAdd term=bold ctermbg=4 guibg=White
"!!! hi DiffChange term=bold ctermbg=5 guibg=#edb5cd
"!!! hi DiffDelete term=bold cterm=bold ctermfg=4 ctermbg=6 gui=bold guifg=LightBlue guibg=#f6e8d0
"!!! hi DiffText term=reverse cterm=bold ctermbg=1 gui=bold guibg=#ff8060
"!!! hi Cursor guifg=bg guibg=fg
"!!! hi lCursor guifg=bg guibg=fg

" Colors for syntax highlighting
hi Comment term=bold ctermfg=4
hi Constant term=underline ctermfg=1
hi Special term=bold ctermfg=5
"!!! hi Identifier term=underline ctermfg=6 guifg=DarkCyan
hi Statement term=bold ctermfg=3
hi PreProc term=underline ctermfg=5
hi Type term=underline ctermfg=2
hi Ignore cterm=bold ctermfg=7
"!!! hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1 gui=bold guifg=White guibg=Red
hi Todo term=standout ctermfg=0 ctermbg=3


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" M O D I F I C A T I O N S   P E R S O N N E L L E S "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Couleurs différentes pour vimdiff
hi DiffChange ctermfg=white ctermbg=black
hi DiffText ctermfg=darkblue ctermbg=black cterm=underline,bold
hi DiffAdd ctermfg=darkgreen ctermbg=black cterm=bold
hi DiffDelete ctermfg=red ctermbg=black
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
" Couleurs de la tabline
hi TabLine ctermfg=5 ctermbg=black cterm=none
hi TabLineSel ctermfg=white ctermbg=black cterm=underline,bold
" Autres couleurs de la tabline pour le plugin Vem Tabline
if !empty(glob("~/.config/nvim/bundle/vem-tabline"))
    hi VemTablineTabNormal ctermfg=5 ctermbg=black cterm=none
    hi VemTablineTabSelected ctermfg=white ctermbg=black cterm=underline,bold
endif
" Couleurs de la barre de statut
hi StatusLineNC ctermfg=5 ctermbg=black cterm=none
function! SetWindowFocused()
    if !exists('#goyo')
        hi clear StatusLine
        hi StatusLine ctermfg=black ctermbg=5 cterm=bold
    endif
endfunction
function! SetWindowUnfocused()
    if !exists('#goyo')
        hi clear StatusLine
        hi StatusLine ctermfg=5 ctermbg=black cterm=none
    endif
endfunction
augroup BgHighlight
    autocmd!
    autocmd BufEnter,FocusGained * call SetWindowFocused()
    autocmd BufLeave,FocusLost * call SetWindowUnfocused()
    autocmd User GoyoLeave nested call SetWindowFocused()
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
