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
" (par défaut, tous les résultats de recherche sont surlignés de la même
" couleur) (la couleur du paramètre SearchCurrent est définie plus bas) :
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
" :colo puis <Tab> jusqu'au thème voulu et <Entrée>
" Les thèmes par défaut (ceux installés en même temps que neovim)
" se trouvent dans /usr/share/nvim/runtime/colors/
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

" <F11> en mode insertion pour activer / désactiver le collage de texte
" en respectant l'indentation correcte
set pastetoggle=<F11>

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
" Y pour agir comme D et C, i.e. copier jusqu'à la fin de la ligne
" au lieu de copier la ligne entière par défaut.
map Y y$

"------------------------------------------------------------
" Ne pas rechercher dans tous les fichiers pour l'autocomplétion
set complete-=i

"------------------------------------------------------------
" Activer / désactiver le correcteur d'orthographe avec zs
nnoremap <silent> zs :setlocal spell! spell?<Return>

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
" Surlignement des espaces insécables
au VimEnter,BufWinEnter * syn match ErrorMsg " "

"------------------------------------------------------------
" Pas de coloration syntaxique en mode diff
if &diff
syntax off
endif

"------------------------------------------------------------
" Comportement normal des touches de direction (ligne par ligne en cas de wrap)
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
normal yl
let l:charlen = byteidx(getreg(), 1)
call cursor(0, curcol + l:charlen)
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
normal yl
let l:charlen = byteidx(getreg(), 1)
call cursor(0, col(".") + l:charlen)
endif
if a:mode == "v"
normal msgv`s
endif
return ""
endfunction

"------------------------------------------------------------
" Ctrl-Home et gg devraient aussi amener en début de ligne
inoremap <silent> <C-Home> <C-o>gg<C-o>0
nnoremap <silent> <C-Home> gg0
vnoremap <silent> <C-Home> gg0
nmap <silent> gg gg0
vmap <silent> gg gg0

"------------------------------------------------------------
" PageUp et PageDown correctes
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
" Insérer une espace avec la barre d'espace en mode normal
nnoremap <Space> i<Space><Right><ESC>

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

function SetWindowFocused()
hi clear StatusLine
hi StatusLine ctermfg=black ctermbg=5 cterm=bold
endfunction

function SetWindowUnfocused()
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
hi htmlBold cterm=bold
hi htmlItalic cterm=italic
hi htmlBoldItalic cterm=bold,italic
hi Title ctermfg=blue

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
hi VertSplit ctermfg=black ctermbg=none cterm=none
set fillchars+=vert:\ 
hi FoldColumn ctermfg=white ctermbg=black cterm=bold
hi Folded ctermfg=black ctermbg=green cterm=bold
hi ModeMsg ctermfg=white
hi ColorColumn ctermfg=black

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
let g:suda#prompt = 'Mot de passe : '
" Préfixe à utiliser pour les commandes nécessitant sudo ; un ou plusieurs
" préfixes sont possibles : let g:suda#prefix = 'suda://' OU
" let g:suda#prefix = ['suda://', 'sudo://', '_://']
" Par exemple : :w sudo:% pour enregistrer le fichier courant avec sudo
" ou :e sudo:<fichier> pour ouvrir un fichier avec sudo
let g:suda#prefix = 'sudo:'
" Smart edit : un fichier protégé en écriture s'ouvre automatiquement avec sudo
let g:suda_smart_edit = 1

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
" Options pour les fichiers markdown

" Correcteur d'orthographe
"autocmd BufEnter *.md set spell spelllang=fr

" N'afficher les symboles, liens... qu'en cas de survol (replis internes)
autocmd BufEnter *.md set conceallevel=2

" Repli dans les fichiers en markdown -> trop lent
"let g:markdown_folding = 1
"set foldlevelstart=1
"set nofoldenable

command ConvertToOdt !pandoc -s % -f markdown -t odt -o %:r.odt
command ConvertToPdf !pandoc -s % -f markdown -t odt -o ~/.cache/%:t:r.odt | soffice --headless --convert-to pdf --outdir %:p:h ~/.cache/%:t:r.odt
"autocmd BufReadPost *.docx :%!pandoc -f docx -t markdown
"autocmd BufReadPost *.odt :%!pandoc -f odt -t markdown
"autocmd BufReadPost *.pdf :%!pandoc -f pdf -t markdown
