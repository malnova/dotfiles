"------------------------------------------------------------
" Plugins

" Plugin vim-plug (https://github.com/junegunn/vim-plug) pour
" installer facilement les plugins et les thèmes
" Commandes :
" :PlugInstall : installer les plugins
" :PlugUpgrade : mettre à jour vim-plug
" :PlugStatus : vérifier si des mises à jour des plugins sont disponibles
" :PlugUpdate : mettre à jour les plugins
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
endif
source ~/.config/nvim/autoload/plug.vim

" Liste des plugins à installer automatiquement avec vim-plug
call plug#begin('~/.config/nvim/bundle')
    " Plugin Buftabline, pour afficher la liste des buffers (fichiers)
    " ouverts dans la tabline (par défaut, il n'est pas visible du tout
    " si plusieurs fichiers sont ouverts dans vim) :
    Plug 'https://github.com/ap/vim-buftabline.git'

    " Plugin Searchant, pour mettre en surbrillance de couleur différente
    " le résultat de recherche actif/sous lequel se trouve le curseur
    " (par défaut, tous les résultats de recherche sont surlignés de la
    " même couleur) (la couleur du paramètre SearchCurrent est définie
    " plus bas) :
    Plug 'https://github.com/timakro/vim-searchant.git'

    " Plugin Goyo, pour écrire sans distraction (en masquant les différentes
    " barres, horizontales et verticales, de vim et de tmux) :
    Plug 'https://github.com/junegunn/goyo.vim.git'

    " Plugin VIM Table Mode, pour aligner automatiquement les colonnes
    " des tableaux, y compris en Markdown :
    Plug 'https://github.com/dhruvasagar/vim-table-mode.git'

    " Plugin Vim Tmux Navigator, pour pouvoir utiliser les mêmes raccourcis
    " pour passer d'un panneau (split) à l'autre dans vim et dans Tmux
    Plug 'https://github.com/christoomey/vim-tmux-navigator'

    " Plugin suda pour travailler sur des fichiers en lecture seule
    Plug 'https://github.com/lambdalisue/suda.vim'
call plug#end()

"------------------------------------------------------------
" Choix du thème
" On peut voir et appliquer les thèmes déjà installés en tapant
" :colo (ou :colorscheme) puis <Tab> jusqu'au thème voulu et <Entrée>
" Les thèmes par défaut (ceux installés en même temps que neovim)
" se trouvent dans $VIMRUNTIME/colors/
colorscheme peachpuff

"------------------------------------------------------------
" Options de base

" Reset / désactiver les options par défaut de Vi
set nocompatible

" Permettre de changer de buffer sans demander systématiquement
" à sauvegarder au préalable en cas de modification effectuée
set hidden

" Recherche insensible à la casse, sauf si elle contient des majuscules
set ignorecase
set smartcase

" Demander à enregistrer le fichier au lieu d'afficher une erreur
" en cas de modification non enregistrée
set confirm

" Avertissement visuel au lieu de beep en cas de problème
set visualbell

"------------------------------------------------------------
" Options d'indentation
set tabstop=4 " Largeur d'une tabulation
set softtabstop=4 " Ignoré avec expandtab, sauf pour un delete dans une ligne
set expandtab " Espaces au lieu des tabulations (inverse : set noexpandtab)
set shiftwidth=4 " Largeur de l'indentation (<< ou >> en modes normal et visuel)

"------------------------------------------------------------
" Autres options utiles
set breakindent breakindentopt=shift:1,sbr " Décalage des lignes en cas de wrap
set linebreak " Ne pas revenir à la ligne au milieu d'un mot
set scrolloff=2 " Minimum de 2 lignes autour du curseur en cas de scroll
set noincsearch " Pas de recherche pendant la frappe
set noerrorbells " Empêche vim de beeper

"------------------------------------------------------------
" Ne pas rechercher dans tous les fichiers pour l'autocomplétion
set complete-=i

"------------------------------------------------------------
" Pas de coloration syntaxique en mode diff
if &diff
    syntax off
endif

"------------------------------------------------------------
" Surlignement des espaces insécables
au VimEnter,BufWinEnter * syn match ErrorMsg " "

"------------------------------------------------------------
" Format de la barre de statut
set statusline=%F " chemin complet et nom du fichier
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}] " encodage du fichier
set statusline+=%h "help file flag
set statusline+=%m "modified flag
set statusline+=\ %= " aligné à droite
set statusline+=%l/%L, " ligne X de Y
set statusline+=%c " colonne actuelle
set statusline+=\ [%p%%] " [pourcentage du fichier]

"------------------------------------------------------------
" Numéros de lignes relatifs
set number
set relativenumber

"------------------------------------------------------------
" Ouvrir les splits en bas et à droite par défaut
set splitright
set splitbelow

"------------------------------------------------------------
" Redimensionnement automatique des splits
autocmd VimResized * wincmd =
autocmd VimResized * exe "normal \<c-w>="

"------------------------------------------------------------
" Commande DiffOrig pour afficher les différences entre le fichier modifié
" et le fichier d'origine sur le disque
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

"------------------------------------------------------------
" Y pour agir comme D et C, i.e. copier jusqu'à la fin de la ligne
" au lieu de copier la ligne entière par défaut
map Y y$

"------------------------------------------------------------
" Activer / désactiver le correcteur d'orthographe avec zs
" Créer le dossier spell/ dans le dossier .config permet que le
" téléchargement automatique des fichiers de langue se fasse dans ce dossier
if !isdirectory($HOME."/.config/nvim/spell")
    call mkdir($HOME."/.config/nvim/spell", "p", 0755)
endif
nnoremap <silent> zs :setlocal spell! spell? spelllang=fr<Return>

"------------------------------------------------------------
" Comportement normal des touches de direction (ligne par ligne
" en cas de wrap)
inoremap <silent> <Down> <C-o>gj
inoremap <silent> <Up> <C-o>gk
nnoremap <silent> <Down> gj
nnoremap <silent> <Up> gk
vnoremap <silent> <Down> gj
vnoremap <silent> <Up> gk

"------------------------------------------------------------
" Ctrl-flèche droite|gauche avec b et w au lieu de B et W
inoremap <silent> <C-Left> <C-o>b
inoremap <silent> <C-Right> <C-o>w
nnoremap <silent> <C-Left> b
nnoremap <silent> <C-Right> w
nnoremap <silent> <C-h> b
nnoremap <silent> <C-l> w
vnoremap <silent> <C-Left> b
vnoremap <silent> <C-Right> w
vnoremap <silent> <C-h> b
vnoremap <silent> <C-l> w

"------------------------------------------------------------
" Ligne précédente/suivante pour touches gauches/droites
silent! set whichwrap+=<,>,h,l,[,]

"------------------------------------------------------------
" Déplacement de l'écran avec Ctrl-flèche haut|bas
inoremap <silent> <C-Down> <C-o><C-e>
inoremap <silent> <C-Up> <C-o><C-y>
nnoremap <silent> <C-Down> <C-e>
nnoremap <silent> <C-Up> <C-y>
vnoremap <silent> <C-Down> <C-e>
vnoremap <silent> <C-Up> <C-y>

"------------------------------------------------------------
" Touche home pour début du texte OU de la ligne en cas de wrap
nmap <silent> <Home> :call SmartHome("n")<CR>
imap <silent> <Home> <C-r>=SmartHome("i")<CR>
vmap <silent> <Home> <Esc>:call SmartHome("v")<CR>
function SmartHome(mode)
    let curcol = col(".")
    if curcol > indent(".") + 2
        call cursor(0, curcol - 1)
    endif
    if curcol == 1 || curcol != indent(".") + 1
        if &wrap
            normal g^
        else
            normal ^
        endif
    else
        if &wrap
            normal g0
        else
            normal 0
        endif
    endif
    if a:mode == "v"
        normal msgv`s
    endif
    return ""
endfunction

"------------------------------------------------------------
" Touche end pour fin du texte OU de la ligne en cas de wrap
nmap <silent> <End> :call SmartEnd("n")<CR>
imap <silent> <End> <C-r>=SmartEnd("i")<CR>
vmap <silent> <End> <Esc>:call SmartEnd("v")<CR>
function SmartEnd(mode)
    let curcol = col(".")
    let lastcol = a:mode == "i" ? col("$") : col("$") - 1
    if curcol < lastcol - 1
        call cursor(0, curcol + 1)
    endif
    if curcol < lastcol
        if &wrap
            normal g$
        else
            normal $
        endif
    else
        normal g_
    endif
    if a:mode == "i"
        call cursor(0, col(".") + 1)
    endif
    if a:mode == "v"
        normal msgv`s
    endif
    return ""
endfunction

"------------------------------------------------------------
" PageUp et PageDown sans changer la position du curseur sur la page
map <silent> <PageUp> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-U>:set scroll=0<CR>
map <silent> <PageDown> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-D>:set scroll=0<CR>

"------------------------------------------------------------
" Ctrl-PageUp et Ctrl-PageDown pour paragraphe précédent / suivant
inoremap <silent> <C-PageUp> <C-o>{
inoremap <silent> <C-PageDown> <C-o>}
nnoremap <silent> <C-PageUp> {
nnoremap <silent> <C-PageDown> }
vnoremap <silent> <C-PageUp> {
vnoremap <silent> <C-PageDown> }

"------------------------------------------------------------
" Insérer une espace avec la barre d'espace en mode normal
nnoremap <Space> i<Space><Right><ESC>

"------------------------------------------------------------
" Undo / redo intelligents
function! s:start_delete(key)
    let l:result = a:key
    if !s:deleting
        let l:result = "\<C-G>u".l:result
    endif
    let s:deleting = 1
    return l:result
endfunction
function! s:check_undo_break(char)
    if s:deleting
        let s:deleting = 0
        call feedkeys("\<BS>\<C-G>u".a:char, 'n')
    endif
endfunction
augroup smartundo
    autocmd!
    autocmd InsertEnter * let s:deleting = 0
    autocmd InsertCharPre * call s:check_undo_break(v:char)
augroup END
inoremap <expr> <BS> <SID>start_delete("\<BS>")
inoremap <expr> <DEL> <SID>start_delete("\<DEL>")
inoremap <expr> <C-w> <SID>start_delete("\<C-w>")
inoremap <expr> <C-u> <SID>start_delete("\<C-u>")
inoremap <CR> <C-g>u<CR>
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap : :<C-g>u
inoremap ; ;<C-g>u
inoremap , ,<C-g>u

"------------------------------------------------------------
" Naviguer entre les buffers avec la touche <Tab>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

"------------------------------------------------------------
" Diviser les fenêtres horizontalement et verticalement
" Imite les raccourcis de tmux
nnoremap <C-w>- <C-w>s
nnoremap <C-w>\| <C-w>v

"------------------------------------------------------------
" Redimensionner les fenêtres en continu avec <C-w> puis <S-flèches>
" Imite les raccourcis de tmux
nmap <C-w><S-Up> <C-w>+<SID>ws
nmap <C-w><S-Down> <C-w>-<SID>ws
nmap <C-w><S-Left> <C-w>><SID>ws
nmap <C-w><S-Right> <C-w><<SID>ws
nn <script> <SID>ws<S-Up> <C-w>+<SID>ws
nn <script> <SID>ws<S-Down> <C-w>-<SID>ws
nn <script> <SID>ws<S-Left> <C-w>><SID>ws
nn <script> <SID>ws<S-Right> <C-w><<SID>ws
nmap <SID>ws <Nop>

"------------------------------------------------------------
" Fonction pour les changements de couleurs
" L'utilisation d'une fonction est nécessaire, pour que cette fonction
" puisse être appelée de nouveau en quittant le mode de Goyo
" Pour afficher la liste des numéros et noms de couleurs disponibles,
" utiliser la commande :h cterm-colors
" Pour afficher la liste des arguments disponibles pour cterm, utiliser
" la commande :h highlight-args
" Pour afficher la liste des groupes (highlighting groups) disponibles
" par défaut, utiliser la commande :h highlight-groups
" Pour afficher la liste de tous les groupes actuellement définis
" dans leur configuration présente, utiliser la commande :highlight
" Pour afficher le nom du fichier de syntaxe appliqué dans le fichier
" actuel, utiliser la commande :setlocal syntax?
" Ces fichiers de syntaxe se situent dans le dossier $VIMRUNTIME/syntax/
function! s:highlighting()

"------------------------------------------------------------
" Couleurs différentes pour vimdiff
hi DiffChange ctermfg=white ctermbg=none
hi DiffText ctermfg=darkblue ctermbg=none cterm=underline,bold 
hi DiffAdd ctermfg=darkgreen ctermbg=none cterm=bold
hi DiffDelete ctermfg=red ctermbg=none

"------------------------------------------------------------
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

"------------------------------------------------------------
" Couleurs différentes pour la recherche
hi Search ctermfg=black
if !empty(glob("~/.config/nvim/bundle/vim-searchant"))
    hi SearchCurrent ctermfg=black ctermbg=red cterm=bold
endif

"------------------------------------------------------------
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
    autocmd FocusGained * call SetWindowFocused()
    autocmd FocusLost * call SetWindowUnfocused()
augroup END

"------------------------------------------------------------
" Couleurs de la tabline (plugin Buftabline)
if !empty(glob("~/.config/nvim/bundle/vim-buftabline"))
    hi BufTabLineCurrent ctermfg=white ctermbg=black cterm=underline,bold
    hi BufTabLineActive ctermfg=white ctermbg=black cterm=bold
    hi BufTabLineHidden ctermfg=5 ctermbg=black cterm=none
    hi BufTabLineFill ctermbg=0
endif

"------------------------------------------------------------
" Couleurs pour la syntaxe Markdown
" Voir $VIMRUNTIME/syntax/markdown.vim pour la liste des groupes
function! MarkdownGroups()
    hi markdownH1 ctermfg=3 cterm=bold
    hi markdownH2 ctermfg=3 cterm=bold
    hi markdownH3 ctermfg=3 cterm=bold
    hi markdownH4 ctermfg=3 cterm=bold
    hi markdownH5 ctermfg=3 cterm=bold
    hi markdownH6 ctermfg=3 cterm=bold
    hi markdownHeadingDelimiter ctermfg=2
    hi markdownBlockquote ctermfg=3
    hi markdownCode ctermfg=white ctermbg=black
    hi markdownCodeDelimiter ctermfg=white ctermbg=black
    hi markdownFootnote ctermfg=red
    hi markdownFootnoteDefinition ctermfg=red
    hi markdownLink ctermfg=darkblue
    hi markdownLinkDelimiter ctermfg=darkblue
    hi markdownLinkTextDelimiter ctermfg=darkblue
    hi markdownLinkText ctermfg=darkblue
    hi markdownAutomaticLink ctermfg=darkblue
    hi markdownUrl ctermfg=darkblue
    hi markdownUrlTitle ctermfg=darkblue
    hi markdownUrlDelimiter ctermfg=darkblue
    hi markdownUrlTitleDelimiter ctermfg=darkblue
    hi markdownError ctermfg=black ctermbg=red cterm=bold
    " Ajout de groupes pour les formules mathématiques, les indices
    " et les exposants
    syn region markdownMath start=/\$\$/ end=/\$\$/
    syn match markdownMathBlock '\$[^$].\{-}\$'
    " Repris de https://github.com/vim-pandoc/vim-pandoc-syntax/blob/master/syntax/pandoc.vim
    syn region markdownSubscript start=/\~\(\([[:graph:]]\(\\ \)\=\)\{-}\~\)\@=/ end=/\~/ keepend
    syn region markdownSuperscript start=/\^\(\([[:graph:]]\(\\ \)\=\)\{-}\^\)\@=/ skip=/\\ / end=/\^/ keepend
    hi link markdownMath markdownCode
    hi link markdownMathBlock markdownCode
    hi markdownSubscript ctermfg=blue
    hi markdownSuperscript ctermfg=blue
endfunction
autocmd BufRead,BufNewFile,BufEnter *.md,*.mkd,*.mkdwn,*.markdown call MarkdownGroups()

"------------------------------------------------------------
" Autres changements de couleurs
hi clear Visual
hi Visual ctermfg=black ctermbg=blue
hi clear MatchParen
hi MatchParen ctermfg=black ctermbg=blue
hi Error ctermfg=black ctermbg=red cterm=bold
hi ErrorMsg ctermfg=black ctermbg=red cterm=bold
hi LineNr ctermfg=5 ctermbg=black cterm=none
hi CursorLineNr ctermfg=white ctermbg=black cterm=bold
hi FoldColumn ctermfg=white ctermbg=black cterm=bold
hi VertSplit ctermfg=black ctermbg=none cterm=none
set fillchars+=vert:\ 
hi Folded ctermfg=black ctermbg=green cterm=bold
hi ModeMsg ctermfg=white
hi ColorColumn ctermfg=black

"------------------------------------------------------------
" Fin de la fonction pour les changements de couleurs
endfunction
call s:highlighting()

"------------------------------------------------------------
" Plugin Goyo
function! s:goyo_enter()
    if exists('$TMUX')
        silent !tmux set status off
        silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    "set noshowmode
    set noshowcmd
    set scrolloff=999
    set showtabline=0
    exe "normal \<c-w>="
endfunction
function! s:goyo_leave()
    if exists('$TMUX')
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    "set showmode
    set showcmd
    set scrolloff=3
    call s:highlighting()
endfunction
if !empty(glob("~/.config/nvim/bundle/goyo.vim"))
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()
    autocmd VimLeave * call <SID>goyo_leave()
endif

"------------------------------------------------------------
" Plugin Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <S-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <S-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <S-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <S-Right> :TmuxNavigateRight<cr>

"------------------------------------------------------------
" Plugin suda
let g:suda#prompt = "[sudo] Mot de passe de ".$USER." : "
" Préfixe à utiliser pour les commandes nécessitant sudo ; un ou plusieurs
" préfixes sont possibles : let g:suda#prefix = 'suda://' OU
" let g:suda#prefix = ['suda://', 'sudo://', '_://']
" Par exemple : :w sudo:% pour enregistrer le fichier courant avec sudo
" ou :e sudo:<fichier> pour ouvrir un fichier avec sudo
let g:suda#prefix = 'sudo:'
" Enregistrer les fichiers protégés en écriture avec W et Wq
au BufEnter * set noro " Ne pas avertir
command W :execute ':w '.g:suda#prefix.'%'
command Wq :execute ':w '.g:suda#prefix.'%' | :q

"------------------------------------------------------------
" Options pour les fichiers markdown

" Correcteur d'orthographe
autocmd BufEnter *.md,*.mkd,*.mkdwn,*.markdown set spell spelllang=fr

" N'afficher les symboles, liens... qu'en cas de survol (replis internes)
autocmd BufEnter *.md,*.mkd,*.mkdwn,*.markdown set conceallevel=2

function! s:convert_to_doc()
    " La conversion en doc directement avec Pandoc n'est pas possible ;
    " Pandoc ne gère que le docx
    ! pandoc % -s -f markdown -t odt -o ~/.cache/%:t:r.odt > ~/.cache/%:t:r_ConvDoc_log.txt 2>&1
    ! soffice --headless --convert-to doc --outdir %:p:h ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_ConvDoc_log.txt 2>&1
    ! rm ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_ConvDoc_log.txt 2>&1
endfunction
function! s:convert_to_docx()
    ! pandoc % -s -f markdown -t docx -o %:r.docx > ~/.cache/%:t:r_ConvDocx_log.txt 2>&1
endfunction
function! s:convert_to_odt()
    ! pandoc % -s -f markdown -t odt -o %:r.odt > ~/.cache/%:t:r_ConvOdt_log.txt 2>&1
endfunction
function! s:convert_to_pdf()
    " La conversion en pdf directement avec Pandoc nécessiterait
    " d'installer un processeur LaTeX
    ! pandoc % -s -f markdown -t odt -o ~/.cache/%:t:r.odt > ~/.cache/%:t:r_ConvPdf_log.txt 2>&1
    ! soffice --headless --convert-to pdf --outdir %:p:h ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_ConvPdf_log.txt 2>&1
    ! rm ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_ConvPdf_log.txt 2>&1
endfunction
function! s:pdf_preview()
    write! ~/.cache/%:t:r.md > ~/.cache/%:t:r_Prev_log.txt 2>&1
    ! pandoc ~/.cache/%:t:r.md -s -f markdown -t odt -o ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_Prev_log.txt 2>&1
    ! soffice --headless --convert-to pdf --outdir ~/.cache ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_Prev_log.txt 2>&1
    ! zathura ~/.cache/%:t:r.pdf >> ~/.cache/%:t:r_Prev_log.txt 2>&1
    ! rm ~/.cache/%:t:r.md ~/.cache/%:t:r.odt ~/.cache/%:t:r.pdf >> ~/.cache/%:t:r_Prev_log.txt 2>&1
endfunction
" Les noms de commandes doivent commencer par une majuscule
command ConvDoc call s:convert_to_doc()
command ConvDocx call s:convert_to_docx()
command ConvOdt call s:convert_to_odt()
command ConvPdf call s:convert_to_pdf()
command Prev call s:pdf_preview()
