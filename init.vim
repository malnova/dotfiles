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
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Liste des plugins à installer automatiquement avec vim-plug
call plug#begin('~/.config/nvim/bundle')
    " Plugin Vem Tabline, pour afficher la liste des tabs et des buffers
    " dans la tabline :
    Plug 'https://github.com/pacha/vem-tabline'

    " Plugin Searchant, pour mettre en surbrillance de couleur différente
    " le résultat de recherche actif/sous lequel se trouve le curseur
    " (par défaut, tous les résultats de recherche sont surlignés de la
    " même couleur) (la couleur du paramètre SearchCurrent est définie
    " plus bas) :
    Plug 'https://github.com/timakro/vim-searchant'

    " Plugin Goyo, pour écrire sans distraction (en masquant les différentes
    " barres, horizontales et verticales, de vim et de tmux) :
    Plug 'https://github.com/junegunn/goyo.vim', { 'on': 'Goyo' }

    " Plugin VIM Table Mode, pour aligner automatiquement les colonnes
    " des tableaux, y compris en Markdown :
    Plug 'https://github.com/dhruvasagar/vim-table-mode', { 'on': ['TableModeEnable', 'TableModeToggle', 'Tableize'] }

    " Plugin Vim Tmux Navigator, pour pouvoir utiliser les mêmes raccourcis
    " pour passer d'un panneau (split) à l'autre dans vim et dans Tmux
    Plug 'https://github.com/christoomey/vim-tmux-navigator'

    " Plugin (Better) Vim Tmux Resizer, pour pouvoir utiliser les mêmes
    " raccourcis pour redimensionner un panneau dans vim et dans Tmux
    Plug 'https://github.com/RyanMillerC/better-vim-tmux-resizer'
call plug#end()

"------------------------------------------------------------
" Ne pas montrer le message d'intro ("welcome screen", visible avec :intro)
" au démarrage de vim
set shortmess+=I

"------------------------------------------------------------
" Choix du thème
" On peut voir et appliquer les thèmes déjà installés en tapant
" :colo (ou :colorscheme) puis <Tab> jusqu'au thème voulu et <Entrée>
" Les thèmes par défaut (ceux installés en même temps que neovim)
" se trouvent dans $VIMRUNTIME/colors/
if filereadable( expand("$HOME/.config/nvim/colors/mytheme.vim") )
    colorscheme mytheme
else
    colorscheme peachpuff
endif

"------------------------------------------------------------
" Options de base

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
set scrolloff=3 " Minimum de 3 lignes autour du curseur en cas de scroll
set noincsearch " Pas de recherche pendant la frappe
set noerrorbells " Empêche vim de beeper

"------------------------------------------------------------
" Ne pas rechercher dans tous les fichiers pour l'autocomplétion
set complete-=i

"------------------------------------------------------------
" Format de la barre de statut
set statusline=%F " chemin complet et nom du fichier
set statusline+=\ [%{strlen(&fenc)?&fenc:'Aucun\ encodage'}] " encodage du fichier
set statusline+=\ %m " signal (flag) si fichier modifié
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
autocmd VimResized * wincmd = | exe "normal! \<C-w>="

"------------------------------------------------------------
" Y pour agir comme D et C, i.e. copier jusqu'à la fin de la ligne
" au lieu de copier la ligne entière par défaut
noremap Y y$

"------------------------------------------------------------
" Activer / désactiver le correcteur d'orthographe avec zs
nnoremap <silent> zs :setlocal spell! spell? spelllang=fr<CR>

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
nnoremap <silent> <Home> :call SmartHome("n")<CR>
inoremap <silent> <Home> <C-r>=SmartHome("i")<CR>
vnoremap <silent> <Home> <Esc>:call SmartHome("v")<CR>
function! SaveMark(...)
    let l:name = a:0 ? a:1 : 'm'
    let s:save_mark = getpos("'".l:name)
endfunction
function! RestoreMark(...)
    let l:name = a:0 ? a:1 : 'm'
    call setpos("'".l:name, s:save_mark)
endfunction
function! SmartHome(mode)
    let curcol = col(".")
    if curcol > indent(".") + 2
        call cursor(0, curcol - 1)
    endif
    if curcol == 1 || curcol > indent(".") + 1
        if &wrap
            normal! g^
        else
            normal! ^
        endif
    else
        if &wrap
            normal! g0
        else
            normal! 0
        endif
    endif
    if a:mode == "v"
        call SaveMark('m')
        call setpos("'m", getpos('.'))
        normal! gv`m
        call RestoreMark('m')
    endif
    return ""
endfunction

"------------------------------------------------------------
" Touche end pour fin du texte OU de la ligne en cas de wrap
nnoremap <silent> <End> :call SmartEnd("n")<CR>
inoremap <silent> <End> <C-r>=SmartEnd("i")<CR>
vnoremap <silent> <End> <Esc>:call SmartEnd("v")<CR>
function! SaveReg(...)
    let l:name = a:0 ? a:1 : v:register
    let s:save_reg = [getreg(l:name), getregtype(l:name)]
endfunction
function! RestoreReg(...)
    let l:name = a:0 ? a:1 : v:register
    if exists('s:save_reg')
        call setreg(l:name, s:save_reg[0], s:save_reg[1])
    endif
endfunction
function! SmartEnd(mode)
    let curcol = col(".")
    let lastcol = a:mode == "i" ? col("$") : col("$") - 1
    if curcol < lastcol - 1
        call SaveReg()
        normal! yl
        let l:charlen = byteidx(getreg(), 1)
        call cursor(0, curcol + l:charlen)
        call RestoreReg()
    endif
    if curcol < lastcol
        if &wrap
            normal! g$
        else
            normal! $
        endif
    else
        normal! g_
    endif
    if a:mode == "i"
        call SaveReg()
        normal! yl
        let l:charlen = byteidx(getreg(), 1)
        call cursor(0, col(".") + l:charlen)
        call RestoreReg()
    endif
    if a:mode == "v"
        call SaveMark('m')
        call setpos("'m", getpos('.'))
        normal! gv`m
        call RestoreMark('m')
    endif
    return ""
endfunction

"------------------------------------------------------------
" Fonctionnement normal des touches PageUp et PageDown
noremap <silent> <PageUp> 1000<C-U>
noremap <silent> <PageDown> 1000<C-D>
inoremap <silent> <PageUp> <C-O>1000<C-U>
inoremap <silent> <PageDown> <C-O>1000<C-D>

"------------------------------------------------------------
" Ctrl-PageUp et Ctrl-PageDown pour paragraphe précédent / suivant
inoremap <silent> <C-PageUp> <C-o>{
inoremap <silent> <C-PageDown> <C-o>}
nnoremap <silent> <C-PageUp> {
nnoremap <silent> <C-PageDown> }
vnoremap <silent> <C-PageUp> {
vnoremap <silent> <C-PageDown> }

"------------------------------------------------------------
" Pouvoir insérer une espace avec la barre d'espace en mode normal
nnoremap <Space> i<Space><Right><ESC>

"------------------------------------------------------------
" Remplacer le délimiteur de fenêtre (split) verticale par une espace
set fillchars+=vert:\ 

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
nmap <silent> <C-w><S-Up> :resize +1<CR><SID>ws
nmap <silent> <C-w><S-Down> :resize -1<CR><SID>ws
nmap <silent> <C-w><S-Left> :vertical resize -1<CR><SID>ws
nmap <silent> <C-w><S-Right> :vertical resize +1<CR><SID>ws
nnoremap <script> <SID>ws<S-Up> :resize +1<CR><SID>ws
nnoremap <script> <SID>ws<S-Down> :resize -1<CR><SID>ws
nnoremap <script> <SID>ws<S-Left> :vertical resize -1<CR><SID>ws
nnoremap <script> <SID>ws<S-Right> :vertical resize +1<CR><SID>ws
nmap <SID>ws <Nop>

"------------------------------------------------------------
" Mode diff : pas de coloration syntaxique ni de correcteur d'orthographe
" + algorithme plus juste + nombre de lignes réduit autour des lignes
" comportant des différences (par défaut : 6)
augroup diffmode
    autocmd!
    autocmd VimEnter * if &diff | syntax off | endif
    autocmd OptionSet diff if &diff | if exists("g:syntax_on") | let b:synstatus = '1' | setlocal syntax=off | else | let b:synstatus = '0' | endif | let b:spellstatus = &spell | setlocal nospell | else | if b:synstatus == "1" | setlocal syntax=on | endif | let &spell = b:spellstatus | endif
augroup END
"set diffopt+=algorithm:patience,context:3

"------------------------------------------------------------
" Utiliser xsel pour gérer les registres pour éviter les erreurs
" dues à xclip au cas où il est aussi installé (cf. :h g:clipboard)
let g:clipboard = { 'name': 'xsel_override', 'copy': { '+': 'xsel --input --clipboard', '*': 'xsel --input --primary', }, 'paste': { '+': 'xsel --output --clipboard', '*': 'xsel --output --primary', }, 'cache_enabled': 1, }

"------------------------------------------------------------
" Permettre l'enregistrement des fichiers en lecture seule avec Polkit
autocmd BufEnter * set noro " Ne pas avertir que le fichier est en lecture seule
command! -bang W silent exec 'w !pkexec tee %:p > /dev/null' | e!
command! -bang Wq silent exec 'w !pkexec tee %:p > /dev/null' | e! | q
command! -bang Wqa silent exec 'w !pkexec tee %:p > /dev/null' | e! | qa

"------------------------------------------------------------
" Plugin Vem Tabline
let g:vem_tabline_show = 2
let g:vem_unnamed_buffer_label = '[Aucun nom]'

"------------------------------------------------------------
" Plugin Goyo
if !empty(glob("~/.config/nvim/bundle/goyo.vim"))
    function! s:goyo_enter()
        if executable('tmux') && strlen($TMUX)
            silent !tmux set status off
            silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
        endif
        set noshowcmd
        set scrolloff=999
        set nolazyredraw
        set showtabline=0
        let g:vem_tabline_show = 0
        let b:fcstatus = &foldcolumn
        setlocal foldcolumn=0
    endfunction
    function! s:goyo_leave()
        if executable('tmux') && strlen($TMUX)
            silent !tmux set status on
            silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
        endif
        set showcmd
        set scrolloff=3
        let g:vem_tabline_show = 2
        let &foldcolumn = b:fcstatus
    endfunction
    augroup goyo-resize
        autocmd!
        autocmd User GoyoEnter nested call <SID>goyo_enter()
        autocmd User GoyoLeave nested call <SID>goyo_leave()
        autocmd VimLeave * call <SID>goyo_leave()
        autocmd VimResized * if exists('#goyo') | exe "normal \<C-w>=" | redraw! | endif
    augroup END
endif

"------------------------------------------------------------
" Plugin VIM Table Mode
if !empty(glob("~/.config/nvim/bundle/vim-table-mode"))
    let g:table_mode_corner='|'
    nnoremap <Leader>tm :TableModeToggle<CR>
endif

"------------------------------------------------------------
" Plugin Vim Tmux Navigator
if !empty(glob("~/.config/nvim/bundle/vim-tmux-navigator"))
    let g:tmux_navigator_no_mappings = 1
    " <C-o> retourne en mode normal pour une commande seulement
    "inoremap <silent> <C-Left> <C-o>:TmuxNavigateLeft<CR>
    "inoremap <silent> <C-Down> <C-o>:TmuxNavigateDown<CR>
    "inoremap <silent> <C-Up> <C-o>:TmuxNavigateUp<CR>
    "inoremap <silent> <C-Right> <C-o>:TmuxNavigateRight<CR>
    nnoremap <silent> <C-Left> :TmuxNavigateLeft<CR>
    nnoremap <silent> <C-Down> :TmuxNavigateDown<CR>
    nnoremap <silent> <C-Up> :TmuxNavigateUp<CR>
    nnoremap <silent> <C-Right> :TmuxNavigateRight<CR>
endif

"------------------------------------------------------------
" Plugin (Better) Vim Tmux Resizer
if !empty(glob("~/.config/nvim/bundle/better-vim-tmux-resizer"))
    let g:tmux_resizer_no_mappings = 1
    " Incrémentation horizontale
    let g:tmux_resizer_resize_count = 2
    " Incrémentation verticale
    let g:tmux_resizer_vertical_resize_count = 2
    nnoremap <silent> <S-Left> :TmuxResizeLeft<CR>
    nnoremap <silent> <S-Down> :TmuxResizeDown<CR>
    nnoremap <silent> <S-Up> :TmuxResizeUp<CR>
    nnoremap <silent> <S-Right> :TmuxResizeRight<CR>
endif

"------------------------------------------------------------
" Options pour les fichiers markdown
" N'afficher les symboles, liens... qu'en cas de survol (replis internes),
" et activer le correcteur d'orthographe (sauf en mode diff)
autocmd FileType markdown if !&diff | setlocal conceallevel=2 | setlocal spell spelllang=fr | endif
nnoremap <Leader>md :setlocal ft=markdown<CR>

"------------------------------------------------------------
" Commandes pour convertir en markdown, odt, doc, etc.
" Les noms de commandes doivent commencer par une majuscule
command! ConvToDoc call convertfiles#convert("doc", "1", "0")
command! ConvToDocx call convertfiles#convert("docx", "1", "0")
command! ConvToHtml call convertfiles#convert("html", "0", "0")
command! ConvToOdt call convertfiles#convert("odt", "0", "0")
command! ConvToPdf call convertfiles#convert("pdf", "1", "0")
command! ConvToRtf call convertfiles#convert("rtf", "1", "0")
command! Prev call convertfiles#convert("pdf", "1", "1")
command! -complete=file -nargs=+ ConvToMd call convertfiles#convert_to_text("1", <f-args>)
command! -complete=file -nargs=+ ConvToTxt call convertfiles#convert_to_text("0", <f-args>)
command! -complete=customlist,convertfiles#CompletionTest -nargs=* ConvToSlides call convertfiles#convert_to_slides(<f-args>)
