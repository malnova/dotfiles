"------------------------------------------------------------
" Options de base

" Reset / désactiver les options par défaut de Vi
set nocompatible

" Plugin Pathogen pour installer facilement les plugins
if !empty(glob("~/.config/vim/autoload/pathogen.vim"))
source ~/.config/vim/autoload/pathogen.vim
execute pathogen#infect('bundle/{}', '~/.config/vim/bundle/{}')
endif

" Activer les plugins et l'indentation selon le type de fichier
filetype indent plugin on

" Activer la coloration syntaxique
syntax on

" Permettre de changer de buffer sans demander systématiquement
" à sauvegarder au préalable en cas de modification effectuée
set hidden

" Menu pour l'auto-complétion avec C-n et C-p au lieu de la barre de statut
set wildmenu

" Montrer les commandes partielles en bas de l'écran
set showcmd

" Mettre les recherches en surbrillance
set hlsearch

" Recherche insensible à la casse, sauf si elle contient des majuscules
set ignorecase
set smartcase

" Autoriser la touche delete sur du texte indenté, les fins de lignes
" et le début de l'insertion
set backspace=indent,eol,start

" Conserver l'alignement lors d'un retour à la ligne
set autoindent

" Ne pas retourner au début de ligne en cas de changement de ligne
set nostartofline

" Afficher la position du curseur en bas de l'écran
set ruler

" Toujours montrer la ligne d'état, même avec une seule fenêtre
set laststatus=2

" Demander à enregistrer le fichier au lieu d'afficher une erreur
" en cas de modification non enregistrée
set confirm

" Avertissement visuel au lieu de beep en cas de problème
set visualbell

" Et désactiver aussi l'avertissement visuel
set t_vb=

" Permettre l'utilisation de la souris dans tous les modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
"set cmdheight=2

" Afficher les numéros des lignes
set number

" Pas de timeout pour les mappings et timeout rapide pour les codes touches
set notimeout ttimeout ttimeoutlen=50

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
set wrap " Lignes trop longues sur plusieurs lignes (soft wrap)
set breakindent breakindentopt=shift:1,sbr " Décalage des lignes en cas de wrap
set linebreak " Ne pas revenir à la ligne au milieu d'un mot
set scrolloff=3 " Minimum de 3 lignes autour du curseur en cas de scroll
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
set statusline=%f " nom du fichier
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}] " encodage du fichier
set statusline+=%h "help file flag
set statusline+=%m "modified flag
set statusline+=%r "read only flag
set statusline+=\ %= " aligné à droite
set statusline+=%l/%L, " ligne X de Y
set statusline+=%c " colonne actuelle
set statusline+=\ [%p%%] " [pourcentage du fichier]

"------------------------------------------------------------
" UTF-8 par défaut
set encoding=utf-8
set fileencoding=utf-8

"------------------------------------------------------------
" Surlignement des espaces insécables
au VimEnter,BufWinEnter * syn match ErrorMsg " "

"------------------------------------------------------------
" Pas de coloration syntaxique en mode diff
if &diff
syntax off
endif

"------------------------------------------------------------
" Fichiers temporaires en cache
set undodir=~/.cache
set directory=~/.cache
set backupdir=~/.cache
set viminfo+=n~/.cache/viminfo
let g:netrw_home='~/.cache'

"------------------------------------------------------------
" Enregistrer avec W pour les fichiers en lecture seule
au BufEnter * set noro " Ne pas avertir
command W :execute ':silent w !sudo /usr/bin/tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo /usr/bin/tee % > /dev/null' | :edit! | :q

"------------------------------------------------------------
" Séquences étendues de certaines touches avec TMUX
if (&term =~ '^screen' || &term =~ '^tmux') && exists('$TMUX')
execute "set <xUp>=\e[1;*A"
execute "set <xDown>=\e[1;*B"
execute "set <xRight>=\e[1;*C"
execute "set <xLeft>=\e[1;*D"
execute "set <xHome>=\e[1;*H"
execute "set <xEnd>=\e[1;*F"
execute "set <Insert>=\e[2;*~"
execute "set <Delete>=\e[3;*~"
execute "set <PageUp>=\e[5;*~"
execute "set <PageDown>=\e[6;*~"
execute "set <F1>=\eOP"
execute "set <F2>=\eOQ"
execute "set <F3>=\eOR"
execute "set <F4>=\eOS"
execute "set <xF1>=\e[1;*P"
execute "set <xF2>=\e[1;*Q"
execute "set <xF3>=\e[1;*R"
execute "set <xF4>=\e[1;*S"
execute "set <F5>=\e[15;*~"
execute "set <F6>=\e[17;*~"
execute "set <F7>=\e[18;*~"
execute "set <F8>=\e[19;*~"
execute "set <F9>=\e[20;*~"
execute "set <F10>=\e[21;*~"
execute "set <F11>=\e[23;*~"
execute "set <F12>=\e[24;*~"
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
" Montrer le début des lignes trop longues au lieu de les remplacer par @
set display=lastline

"------------------------------------------------------------
" Fonction pour les changements de couleurs
function! s:highlighting()

"------------------------------------------------------------
" Couleurs différentes pour vimdiff
hi DiffChange ctermfg=white ctermbg=none
hi DiffText ctermfg=blue ctermbg=none cterm=underline,bold 
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

"------------------------------------------------------------
" Couleurs de la barre de statut
hi clear StatusLine
hi clear StatusLineNC
hi StatusLine ctermfg=black ctermbg=5 cterm=bold
hi StatusLineNC ctermfg=5 ctermbg=black cterm=none

"------------------------------------------------------------
" Couleurs pour la syntaxe Markdown
hi htmlBold cterm=bold
hi htmlItalic cterm=italic
hi htmlBoldItalic cterm=bold,italic
hi Title ctermfg=blue

"------------------------------------------------------------
" Couleurs pour les plugins
if !empty(glob("~/.config/vim/bundle/vim-searchant"))
hi SearchCurrent ctermfg=black ctermbg=red
endif
if !empty(glob("~/.config/vim/bundle/vim-buftabline"))
hi BufTabLineCurrent ctermfg=white ctermbg=black cterm=underline,bold
hi BufTabLineActive ctermfg=white ctermbg=black cterm=bold
hi BufTabLineHidden ctermfg=5 ctermbg=black cterm=none
hi BufTabLineFill ctermbg=0
endif

"------------------------------------------------------------
" Autres changements de couleurs
hi clear Visual
hi Visual ctermfg=black ctermbg=blue
hi clear MatchParen
hi MatchParen ctermfg=black ctermbg=blue
hi Error ctermfg=black ctermbg=red cterm=bold
hi ErrorMsg ctermfg=black ctermbg=red cterm=bold
hi LineNr ctermfg=5 ctermbg=black
hi CursorLineNr ctermfg=white ctermbg=black
hi VertSplit ctermfg=black ctermbg=none cterm=none
set fillchars+=vert:\ 
hi FoldColumn ctermfg=white ctermbg=black cterm=bold
hi Folded ctermfg=black ctermbg=green cterm=bold
hi ModeMsg ctermfg=white
hi ColorColumn ctermfg=black

"------------------------------------------------------------
" Fin de la fonction pour les changements de couleurs
endfunc
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
if !empty(glob("~/.config/vim/bundle/goyo.vim"))
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
autocmd VimLeave * call <SID>goyo_leave()
endif

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
autocmd BufEnter *.md set spell spelllang=fr

" N'afficher les symboles, liens... qu'en cas de survol (replis internes)
autocmd BufEnter *.md set conceallevel=2

" Repli dans les fichiers en markdown -> trop lent
"let g:markdown_folding = 1
"set foldlevelstart=1
"set nofoldenable
