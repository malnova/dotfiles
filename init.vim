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
if filereadable( expand("$HOME/.config/nvim/colors/mytheme.vim") )
    colorscheme mytheme
else
    colorscheme peachpuff
endif

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
autocmd VimResized * exe "normal! \<c-w>="

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
function! SaveMark(...)
    let l:name = a:0 ? a:1 : 'm'
    let s:save_mark = getpos("'" . l:name)
endfunction
function! RestoreMark(...)
    let l:name = a:0 ? a:1 : 'm'
    call setpos("'" . l:name, s:save_mark)
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
nmap <silent> <End> :call SmartEnd("n")<CR>
imap <silent> <End> <C-r>=SmartEnd("i")<CR>
vmap <silent> <End> <Esc>:call SmartEnd("v")<CR>
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
" Pas de coloration syntaxique en mode diff
if &diff
    syntax off
endif

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
    exe "normal! \<c-w>="
endfunction
function! s:goyo_leave()
    if exists('$TMUX')
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    "set showmode
    set showcmd
    set scrolloff=3
endfunction
if !empty(glob("~/.config/nvim/bundle/goyo.vim"))
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()
    autocmd VimLeave * call <SID>goyo_leave()
endif

"------------------------------------------------------------
" Plugin Vim Tmux Navigator
if !empty(glob("~/.config/nvim/bundle/vim-tmux-navigator"))
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <S-Left> :TmuxNavigateLeft<cr>
    nnoremap <silent> <S-Down> :TmuxNavigateDown<cr>
    nnoremap <silent> <S-Up> :TmuxNavigateUp<cr>
    nnoremap <silent> <S-Right> :TmuxNavigateRight<cr>
endif

"------------------------------------------------------------
" Plugin suda
if !empty(glob("~/.config/nvim/bundle/suda.vim"))
    let g:suda#prompt = "[sudo] Mot de passe de ".$USER." : "
    " Préfixe à utiliser pour les commandes nécessitant sudo ; un ou plusieurs
    " préfixes sont possibles : let g:suda#prefix = 'suda://' OU
    " let g:suda#prefix = ['suda://', 'sudo://', '_://']
    " Par exemple : :w sudo:% pour enregistrer le fichier courant avec sudo
    " ou :e sudo:<fichier> pour ouvrir un fichier avec sudo
    let g:suda#prefix = 'sudo:'
    " Enregistrer les fichiers protégés en écriture avec W et Wq
    autocmd BufEnter * set noro " Ne pas avertir
    command W :execute ':w '.g:suda#prefix.'%'
    command Wq :execute ':w '.g:suda#prefix.'%' | :q
endif

"------------------------------------------------------------
" Options pour les fichiers markdown

" Correcteur d'orthographe
if !&diff
    autocmd BufEnter *.md,*.mkd,*.mkdwn,*.markdown set spell spelllang=fr
endif

" N'afficher les symboles, liens... qu'en cas de survol (replis internes)
autocmd BufEnter *.md,*.mkd,*.mkdwn,*.markdown set conceallevel=2

function! s:typography()
    write! ~/.cache/%:t:r.md
    " Remplacer les guillemets simples par des guillemets français
    ! sed -i -Ee '/(^|\s|\(|\[)"/ s//\1« /g' ~/.cache/%:t:r.md
    ! sed -i -Ee '/(\S)"/ s//\1 »/g' ~/.cache/%:t:r.md
    " Remplacer les espaces devant les poncutations doubles par des
    " espaces insécables
    ! sed -i -Ee '/ ([:;?\!])/ s// \1/g' ~/.cache/%:t:r.md
    " Remplacer trois points par le signe correspondant
    ! sed -i -Ee '/\.{3,}/ s//…/g' ~/.cache/%:t:r.md
endfunction
function! s:convert_to_doc()
    " La conversion en doc directement avec Pandoc n'est pas possible ;
    " Pandoc ne gère que le docx
    call s:typography()
    ! pandoc ~/.cache/%:t:r.md --data-dir=$HOME/documents/configurations/ressources -s -f markdown -t odt -o ~/.cache/%:t:r.odt > ~/.cache/%:t:r_ConvDoc_log.txt 2>&1
    ! soffice --headless --convert-to doc --outdir %:p:h ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_ConvDoc_log.txt 2>&1
    ! rm ~/.cache/%:t:r.md ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_ConvDoc_log.txt 2>&1
endfunction
function! s:convert_to_docx()
    " On convertit d'abord en odt pour un meilleur résultat grâce au
    " fichier de référence
    " La conversion en docx est beaucoup mieux gérée par LibreOffice
    " que par pandoc
    call s:typography()
    ! pandoc ~/.cache/%:t:r.md --data-dir=$HOME/documents/configurations/ressources -s -f markdown -t odt -o ~/.cache/%:t:r.odt > ~/.cache/%:t:r_ConvDocx_log.txt 2>&1
    ! soffice --headless --convert-to docx --outdir %:p:h ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_ConvDocx_log.txt 2>&1
    ! rm ~/.cache/%:t:r.md >> ~/.cache/%:t:r_ConvDocx_log.txt 2>&1
endfunction
function! s:convert_to_odt()
    call s:typography()
    ! pandoc ~/.cache/%:t:r.md --data-dir=$HOME/documents/configurations/ressources -s -f markdown -t odt -o %:r.odt > ~/.cache/%:t:r_ConvOdt_log.txt 2>&1
    ! rm ~/.cache/%:t:r.md >> ~/.cache/%:t:r_ConvOdt_log.txt 2>&1
endfunction
function! s:convert_to_pdf()
    " La conversion en pdf directement avec Pandoc nécessiterait
    " d'installer un processeur LaTeX
    call s:typography()
    ! pandoc ~/.cache/%:t:r.md --data-dir=$HOME/documents/configurations/ressources -s -f markdown -t odt -o ~/.cache/%:t:r.odt > ~/.cache/%:t:r_ConvPdf_log.txt 2>&1
    ! soffice --headless --convert-to pdf --outdir %:p:h ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_ConvPdf_log.txt 2>&1
    ! rm ~/.cache/%:t:r.md ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_ConvPdf_log.txt 2>&1
endfunction
function! s:pdf_preview()
    call s:typography()
    ! pandoc ~/.cache/%:t:r.md --data-dir=$HOME/documents/configurations/ressources -s -f markdown -t odt -o ~/.cache/%:t:r.odt > ~/.cache/%:t:r_Prev_log.txt 2>&1
    ! soffice --headless --convert-to pdf --outdir ~/.cache ~/.cache/%:t:r.odt >> ~/.cache/%:t:r_Prev_log.txt 2>&1
    ! zathura ~/.cache/%:t:r.pdf >> ~/.cache/%:t:r_Prev_log.txt 2>&1
    ! rm ~/.cache/%:t:r.md ~/.cache/%:t:r.odt ~/.cache/%:t:r.pdf >> ~/.cache/%:t:r_Prev_log.txt 2>&1
endfunction
function! s:convert_to_markdown(...)
    for file in a:000
        if filereadable(expand(file))
            let filebase = fnameescape(fnamemodify(expand(file), ":t:r"))
            execute '! pandoc ' . fnameescape(expand(file)) . ' -s --wrap=preserve -t markdown -o ~/.cache/' . filebase . '_ConvMd_file.md > ~/.cache/' . filebase . '_ConvMd_log.txt 2>&1'
            execute 'e ~/.cache/' . filebase . '_ConvMd_file.md'
        else
            echohl ErrorMsg
            echomsg 'Erreur : le fichier "' . expand(file) . '" ne peut être lu.'
            echohl None
        endif
    endfor
endfunction
" Les noms de commandes doivent commencer par une majuscule
command ConvDoc call s:convert_to_doc()
command ConvDocx call s:convert_to_docx()
command ConvOdt call s:convert_to_odt()
command ConvPdf call s:convert_to_pdf()
command Prev call s:pdf_preview()
command! -complete=file -nargs=+ ConvMd call s:convert_to_markdown(<f-args>)
