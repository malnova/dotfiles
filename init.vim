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
    let homedir = fnameescape(expand("~"))
    let filebase = fnameescape(expand("%:t:r"))
    execute 'write! ' . homedir . '/.cache/' . filebase . '.md'
    " Remplacer les guillemets simples par des guillemets français
    execute '! sed -i -Ee "/(^|\s|\(|\[)\"/ s//\1« /g" ' . homedir . '/.cache/' . filebase . '.md'
    execute '! sed -i -Ee "/(\S)\"/ s//\1 »/g" ' . homedir . '/.cache/' . filebase . '.md'
    " Remplacer les espaces devant les poncutations doubles par des
    " espaces insécables
    execute '! sed -i -Ee "/ ([:;?\!])/ s// \1/g" ' . homedir . '/.cache/' . filebase . '.md'
    " Remplacer trois points par le signe correspondant
    execute '! sed -i -Ee "/\.{3,}/ s//…/g" ' . homedir . '/.cache/' . filebase . '.md'
endfunction
function! s:convert_to_doc()
    " La conversion en doc directement avec Pandoc n'est pas possible ;
    " Pandoc ne gère que le docx
    call s:typography()
    let homedir = fnameescape(expand("~"))
    let filebase = fnameescape(expand("%:t:r"))
    execute '! pandoc ' . homedir . '/.cache/' . filebase . '.md --data-dir=' . homedir . '/documents/configurations/ressources -s -f markdown -t odt -o ' . homedir . '/.cache/' . filebase . '.odt > ' . homedir . '/.cache/' . filebase . '_ConvToDoc_log.txt 2>&1'
    execute '! soffice --headless --convert-to doc --outdir ' . fnameescape(expand("%:p:h")) . ' ' . homedir . '/.cache/' . filebase . '.odt >> ' . homedir . '/.cache/' . filebase . '_ConvToDoc_log.txt 2>&1'
    execute '! rm ' . homedir . '/.cache/' . filebase . '.md ' . homedir . '/.cache/' . filebase . '.odt >> ' . homedir . '/.cache/' . filebase . '_ConvToDoc_log.txt 2>&1'
endfunction
function! s:convert_to_docx()
    " On convertit d'abord en odt pour un meilleur résultat grâce au
    " fichier de référence
    " La conversion en docx est beaucoup mieux gérée par LibreOffice
    " que par pandoc
    call s:typography()
    let homedir = fnameescape(expand("~"))
    let filebase = fnameescape(expand("%:t:r"))
    execute '! pandoc ' . homedir . '/.cache/' . filebase . '.md --data-dir=' . homedir . '/documents/configurations/ressources -s -f markdown -t odt -o ' . homedir . '/.cache/' . filebase . '.odt > ' . homedir . '/.cache/' . filebase . '_ConvToDocx_log.txt 2>&1'
    execute '! soffice --headless --convert-to docx --outdir ' . fnameescape(expand("%:p:h")) . ' ' . homedir . '/.cache/' . filebase . '.odt >> ' . homedir . '/.cache/' . filebase . '_ConvToDocx_log.txt 2>&1'
    execute '! rm ' . homedir . '/.cache/' . filebase . '.md ' . homedir . '/.cache/' . filebase . '.odt >> ' . homedir . '/.cache/' . filebase . '_ConvToDocx_log.txt 2>&1'
endfunction
function! s:convert_to_odt()
    call s:typography()
    let homedir = fnameescape(expand("~"))
    let filebase = fnameescape(expand("%:t:r"))
    execute '! pandoc ' . homedir . '/.cache/' . filebase . '.md --data-dir=' . homedir . '/documents/configurations/ressources -s -f markdown -t odt -o ' . fnameescape(expand("%:r")) . '.odt > ' . homedir . '/.cache/' . filebase . '_ConvToOdt_log.txt 2>&1'
    execute '! rm ' . homedir . '/.cache/' . filebase . '.md >> ' . homedir . '/.cache/' . filebase . '_ConvToOdt_log.txt 2>&1'
endfunction
function! s:convert_to_pdf()
    " La conversion en pdf directement avec Pandoc nécessiterait
    " d'installer un processeur LaTeX
    call s:typography()
    let homedir = fnameescape(expand("~"))
    let filebase = fnameescape(expand("%:t:r"))
    execute '! pandoc ' . homedir . '/.cache/' . filebase . '.md --data-dir=' . homedir . '/documents/configurations/ressources -s -f markdown -t odt -o ' . homedir . '/.cache/' . filebase . '.odt > ' . homedir . '/.cache/' . filebase . '_ConvToPdf_log.txt 2>&1'
    execute '! soffice --headless --convert-to pdf --outdir ' . fnameescape(expand("%:p:h")) . ' ' . homedir . '/.cache/' . filebase . '.odt >> ' . homedir . '/.cache/' . filebase . '_ConvToPdf_log.txt 2>&1'
    execute '! rm ' . homedir . '/.cache/' . filebase . '.md ' . homedir . '/.cache/' . filebase . '.odt >> ' . homedir . '/.cache/' . filebase . '_ConvToPdf_log.txt 2>&1'
endfunction
function! s:convert_to_text(...)
    let homedir = fnameescape(expand("~"))
    for file in a:000
        " Permettre d'utiliser des wildcards dans les noms de fichiers à convertir (https://vi.stackexchange.com/questions/2607/how-to-open-multiple-files-matching-a-wildcard-expression)
        for f in glob(file, 0, 1)
            if !empty(glob(expand(f)))
                let fileext = fnameescape(fnamemodify(expand(f), ":e"))
                let filebase = fnameescape(fnamemodify(expand(f), ":t:r"))
                if fileext ==? "pdf"
                    execute '! pdftotext ' . fnameescape(expand(f)) . ' ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file.txt > ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt 2>&1'
                    let fileistext = system("filecontent=$(cat " . homedir . "/.cache/" . filebase . "_ConvToTxt_file.txt); if [[ $filecontent =~ [0-9a-zA-Y] ]]; then echo '1'; else echo '0'; fi")
                    " https://stackoverflow.com/questions/2789319/file-content-into-unix-variable-with-newlines
                    let fileistext = substitute(fileistext, '\n\+$', '', '')
                    if fileistext ==? "0"
                        if !empty(glob('/usr/bin/tesseract'))
                            " On peut aussi utiliser pdfimages (sans possibilité de préciser la résolution en DPI)
                            execute '! pdftoppm -r 300 ' . fnameescape(expand(f)) . ' ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file >> ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt 2>&1'
                            execute '! i=0; j=$(ls ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file*.ppm | wc -l); for img in ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file*.ppm; do ((i++)); echo "Reconnaissance de la page ${i} sur ${j}."; tesseract -l fra --dpi 300 "$img" "$img" >> ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt 2>&1; done; cat ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file*.ppm.txt > ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file.txt 2>> ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt'
                            execute '! rm ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file*.ppm* >> ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt 2>&1'
                            execute 'e ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file.txt'
                        else
                            echohl ErrorMsg
                            echomsg "Erreur : tesseract n'est pas installé ; la reconnaissance du fichier \"" . expand(f) . "\" est impossible."
                            echohl None
                        endif
                    else
                        execute 'e ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file.txt'
                    endif
                elseif fileext ==? "ppm" || fileext ==? "bmp" || fileext ==? "jpg" || fileext ==? "jpeg" || fileext ==? "tif" || fileext ==? "tiff" || fileext ==? "webp" || fileext ==? "gif"
                    execute '! tesseract -l fra --dpi 300 ' . fnameescape(expand(f)) . ' ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file > ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt 2>&1'
                    execute 'e ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file.txt'
                elseif fileext ==? "rtf"
                    execute '! soffice --headless --convert-to odt --outdir ' . homedir . '/.cache ' . fnameescape(expand(f)) . ' > ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt 2>&1'
                    execute '! pandoc ' . homedir . '/.cache/' . filebase . '.odt -s --wrap=preserve -f odt -t markdown-smart -o ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file.md >> ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt 2>&1'
                    execute 'e ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file.md'
                    execute '! rm ' . homedir . '/.cache/' . filebase . '.odt >> ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt 2>&1'
                else
                    execute '! pandoc ' . fnameescape(expand(f)) . ' -s --wrap=preserve -t markdown-smart -o ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file.md > ' . homedir . '/.cache/' . filebase . '_ConvToTxt_log.txt 2>&1'
                    execute 'e ' . homedir . '/.cache/' . filebase . '_ConvToTxt_file.md'
                endif
            else
                echohl ErrorMsg
                echomsg "Erreur : le fichier \"" . expand(f) . "\" ne peut être lu."
                echohl None
            endif
        endfor
    endfor
endfunction
function! s:pdf_preview()
    call s:typography()
    let homedir = fnameescape(expand("~"))
    let filebase = fnameescape(expand("%:t:r"))
    execute '! pandoc ' . homedir . '/.cache/' . filebase . '.md --data-dir=' . homedir . '/documents/configurations/ressources -s -f markdown -t odt -o ' . homedir . '/.cache/' . filebase . '.odt > ' . homedir . '/.cache/' . filebase . '_Prev_log.txt 2>&1'
    execute '! soffice --headless --convert-to pdf --outdir ' . homedir . '/.cache ' . homedir . '/.cache/' . filebase . '.odt >> ' . homedir . '/.cache/' . filebase . '_Prev_log.txt 2>&1'
    execute '! zathura ' . homedir . '/.cache/' . filebase . '.pdf >> ' . homedir . '/.cache/' . filebase . '_Prev_log.txt 2>&1'
    execute '! rm ' . homedir . '/.cache/' . filebase . '.md ' . homedir . '/.cache/' . filebase . '.odt ' . homedir . '/.cache/' . filebase . '.pdf >> ' . homedir . '/.cache/' . filebase . '_Prev_log.txt 2>&1'
endfunction
" Les noms de commandes doivent commencer par une majuscule
command ConvToDoc call s:convert_to_doc()
command ConvToDocx call s:convert_to_docx()
command ConvToOdt call s:convert_to_odt()
command ConvToPdf call s:convert_to_pdf()
command! -complete=file -nargs=+ ConvToTxt call s:convert_to_text(<f-args>)
command Prev call s:pdf_preview()
