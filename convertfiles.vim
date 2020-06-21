function! s:typography(mdfile, errorfile)
    silent execute 'write! '.fnameescape(a:mdfile)
    " Remplacer les guillemets simples par des guillemets français
    let tmp=system("! gawk -i inplace -F '' ' { for (i=1;i<=NF;i++){ if ($i==\"{\") brace++; if ($i==\"}\") brace--; if (brace==0 && $i==\"\\\"\"){ printf \"%s\", (cquote ? \" »\" : \"« \"); cquote=!cquote; continue; } printf \"%s\", $i } print \"\" }' \"".a:mdfile.'" > "'.a:errorfile.'" 2>&1')
    " Remplacer les espaces devant les poncutations doubles par des
    " espaces insécables
    silent execute '! sed -i -Ee "/ ([:;?\!])/ s// \1/g" "'.a:mdfile.'" >> "'.a:errorfile.'" 2>&1'
    " Remplacer trois points par le signe correspondant
    silent execute '! sed -i -Ee "/\.{3,}/ s//…/g" "'.a:mdfile.'" >> "'.a:errorfile.'" 2>&1'
endfunction

function! s:convert_events(data, pdfpreview, mdfile, errorfile, exitfile, tempfile)
    if a:data == 0
        if a:pdfpreview == "0"
            echo "Conversion réussie vers \"".a:exitfile."\"."
        else
            echo "Conversion réussie."
            call jobstart (['bash', '-c', 'zathura "'.a:exitfile.'" >> "'.a:errorfile.'" 2>&1'], {'on_exit': {j,d,e -> execute('silent ! rm "'.a:exitfile.'"', '')}})
        endif
    else
        echohl ErrorMsg | echo "Erreur : la conversion a échoué." | echohl None
        execute 'e '.fnameescape(a:errorfile)
    endif
    silent execute '! rm "'.a:mdfile.'"'
    if !empty(glob(a:tempfile)) | silent execute '! rm "'.a:tempfile.'"' | endif
endfunction

function! convertfiles#convert(format, useoffice, pdfpreview)
    if !empty(bufname(''))
        echo "Conversion en cours..."
        let homedir = expand("~")
        if exists("*strftime") | let localtime = strftime("%Y-%m-%d_%H-%M-%S") | else | let localtime = localtime() | endif
        let filebase = expand("%:t:r").'_'.localtime
        let mdfile = homedir.'/.cache/'.expand("%:t:r").'_'.localtime.'.md'
        let errorfile = homedir.'/.cache/'.filebase.'_log.txt'
        if a:pdfpreview == "0" | let outdir = expand("%:p:h") | else | let outdir = homedir.'/.cache' | endif
        let exitfile = outdir."/".filebase.'.'.a:format
        let tempfile = homedir.'/.cache/'.filebase.'.odt'
        call s:typography(mdfile, errorfile)
        if a:useoffice == 1
            call jobstart (['bash', '-c', 'pandoc "'.mdfile.'" --data-dir="'.homedir.'/documents/configurations/ressources" -s -f markdown -t odt -o "'.tempfile.'" >> "'.errorfile.'" 2>&1 && soffice --headless --convert-to "'.a:format.'" --outdir "'.outdir.'" "'.tempfile.'" >> "'.errorfile.'" 2>&1'], {'on_exit': {j,d,e -> execute('call s:convert_events("'.d.'", "'.a:pdfpreview.'", "'.mdfile.'", "'.errorfile.'", "'.exitfile.'", "'.tempfile.'")', '')}})
        else
            call jobstart (['bash', '-c', 'pandoc "'.mdfile.'" --data-dir="'.homedir.'/documents/configurations/ressources" -s -f markdown -t "'.a:format.'" -o "'.exitfile.'" >> "'.errorfile.'" 2>&1'], {'on_exit': {j,d,e -> execute('call s:convert_events("'.d.'", "'.a:pdfpreview.'", "'.mdfile.'", "'.errorfile.'", "'.exitfile.'", "")', '')}})
        endif
    else
        echohl ErrorMsg | echo "Erreur : le fichier ouvert n'a pas de nom." | echohl None
    endif
endfunction

function! convertfiles#convert_to_text(...)
    echo "Conversion en cours..."
    let homedir = expand("~")
    for file in a:000
        if !empty(glob(file, 0, 1))
            " Permettre d'utiliser des wildcards dans les noms de fichiers à convertir (voir ':h glob' et https://vi.stackexchange.com/questions/2607/how-to-open-multiple-files-matching-a-wildcard-expression)
            for f in glob(file, 0, 1)
                if !empty(glob(expand(f)))
                    let fileext = fnamemodify(expand(f), ":e")
                    if exists("*strftime") | let localtime = strftime("%Y-%m-%d_%H-%M-%S") | else | let localtime = localtime() | endif
                    let filebase = fnamemodify(expand(f), ":t:r").'_'.localtime
                    let errorfile = homedir.'/.cache/'.filebase.'_log.txt'
                    let errorcode = 0
                    if fileext ==? "pdf"
                        let exitfile = homedir.'/.cache/'.filebase.'.txt'
                        silent execute '! pdftotext "'.expand(f).'" "'.exitfile.'" > "'.errorfile.'" 2>&1'
                        let fileistext = system('if grep -q "[^[:space:]]" "'.exitfile.'"; then echo -n "1"; else echo -n "0"; fi')
                        if fileistext ==? "0"
                            if !empty(glob('/usr/bin/tesseract'))
                                let file_max_ppi = system('file_list=$(pdfimages -list "'.expand(f)."\" 2>/dev/null | tail -n +3);x_ppi=$(echo $file_list | awk 'BEGIN{a=   0}{if ($13>0+a) a=$13} END{print a}');y_ppi=$(echo $file_list | awk 'BEGIN{a=   0}{if ($14>0+a) a=$14} END{print a}');(( $x_ppi > $y_ppi)) && echo -n $x_ppi || echo -n $y_ppi")
                                call inputsave()
                                let user_dpi = input('Résolution à appliquer pour la conversion du fichier "'.expand(f).'", en DPI (la résolution max. du fichier est de '.file_max_ppi.' PPI) : ')
                                call inputrestore()
                                echo "\n"
                                if user_dpi =~# '^\d\+$'
                                    let tempfile = homedir.'/.cache/'.filebase
                                    silent execute '! pdftoppm -r '.user_dpi.' -gray "'.expand(f).'" "'.exitfile.'" >> "'.errorfile.'" 2>&1'
                                    echo "Reconnaissance des images du fichier \"".expand(f)."\" en cours..."
                                    silent execute '! for img in "'.tempfile.'"*.pgm; do tesseract -l fra --dpi '.user_dpi.' "$img" "$img" >> "'.errorfile.'" 2>&1; done; cat "'.tempfile.'"*.pgm.txt >> "'.exitfile.'" 2>> "'.errorfile.'"'
                                    silent execute '! rm "'.tempfile.'"*.pgm* >> "'.errorfile.'" 2>&1'
                                    if v:shell_error == 0 | let errorcode = 1 | else | let errorcode = 2 | endif
                                else
                                    echohl ErrorMsg | echo "Fichier \"".expand(f)."\" : la résolution indiquée est incorrecte." | echohl None
                                endif
                            else
                                echohl ErrorMsg | echo "Fichier \"".expand(f)."\" : tesseract n'est pas installé ; reconnaissance impossible." | echohl None
                            endif
                        else
                            let errorcode = 1
                        endif
                    elseif fileext ==? "ppm" || fileext ==? "pgm" || fileext ==? "pbm" || fileext ==? "bmp" || fileext ==? "jpg" || fileext ==? "jpeg" || fileext ==? "tif" || fileext ==? "tiff" || fileext ==? "webp" || fileext ==? "gif" || fileext ==? "png"
                        let exitfile = homedir.'/.cache/'.filebase.'.txt'
                        let tempfile = homedir.'/.cache/'.filebase.'.png'
                        let file_max_dpi = system("x_dpi=$(identify -format '%x' -units PixelsPerInch \"".expand(f).'" 2> "'.errorfile."\");if [ $? -eq 0 ]; then y_dpi=$(identify -format '%y' -units PixelsPerInch \"".expand(f).'" 2>> "'.errorfile.'");(( $x_dpi > $y_dpi)) && echo -n $x_dpi || echo -n $y_dpi;fi')
                        silent execute '! convert "'.expand(f).'" -auto-orient -colorspace Gray "'.tempfile.'" >> "'.errorfile.'" 2>&1'
                        silent execute '! tesseract -l fra --dpi '.file_max_dpi.' "'.tempfile.'" "'.homedir.'/.cache/'.filebase.'" >> "'.errorfile.'" 2>&1'
                        silent execute '! rm "'.tempfile.'" >> "'.errorfile.'" 2>&1'
                        if v:shell_error == 0 | let errorcode = 1 | else | let errorcode = 2 | endif
                    elseif fileext ==? "rtf"
                        let exitfile = homedir.'/.cache/'.filebase.'.md'
                        let tempfile = homedir.'/.cache/'.fnamemodify(expand(f), ":t:r").'.odt'
                        silent execute '! soffice --headless --convert-to odt --outdir "'.homedir.'/.cache" "'.expand(f).'" > "'.errorfile.'" 2>&1'
                        silent execute '! pandoc "'.tempfile.'" -s --wrap=preserve -f odt -t markdown-smart -o "'.exitfile.'" >> "'.errorfile.'" 2>&1'
                        silent execute '! rm "'.tempfile.'" >> "'.errorfile.'" 2>&1'
                        if v:shell_error == 0 | let errorcode = 1 | else | let errorcode = 2 | endif
                    else
                        let exitfile = homedir.'/.cache/'.filebase.'.md'
                        silent execute '! pandoc "'.expand(f).'" -s --wrap=preserve -t markdown-smart -o "'.exitfile.'" > "'.errorfile.'" 2>&1'
                        if v:shell_error == 0 | let errorcode = 1 | else | let errorcode = 2 | endif
                    endif
                    if errorcode == 1
                        echo "Fichier \"".expand(f)."\" : conversion réussie."
                        execute 'e '.fnameescape(exitfile)
                    elseif errorcode == 2
                        echohl ErrorMsg | echo "Fichier \"".expand(f)."\" : la conversion a échoué." | echohl None
                        execute 'e '.fnameescape(errorfile)
                    endif
                else
                    echohl ErrorMsg | echo "Fichier \"".expand(f)."\" : le fichier ne peut être lu." | echohl None
                endif
            endfor
        else
            echohl ErrorMsg | echo "Fichier \"".expand(file)."\" : le fichier ne peut être lu." | echohl None
        endif
    endfor
endfunction

function! convertfiles#convert_to_slides(...)
    if !empty(bufname(''))
        echo "Conversion en cours..."
        let homedir = expand("~")
        if exists("*strftime") | let localtime = strftime("%Y-%m-%d_%H-%M-%S") | else | let localtime = localtime() | endif
        let filebase = expand("%:t:r").'_'.localtime
        let mdfile = homedir.'/.cache/'.expand("%:t:r").'_'.localtime.'.md'
        let errorfile = homedir.'/.cache/'.filebase.'_log.txt'
        let outdir = expand("%:p:h")
        let format = a:0 ? a:1 : 'slidy'
        let selfcontained = a:0 >=2 && a:2 == "--no-self-contained" ? '' : '--self-contained '
        let exitfile = outdir."/".filebase.'.html'
        let cssfile = outdir."/".expand("%:t:r").'.css'
        let css = !empty(glob(cssfile)) ? '--css "'.cssfile.'" ' : ''
        call s:typography(mdfile, errorfile)
        call jobstart (['bash', '-c', 'pandoc "'.mdfile.'" -s '.selfcontained.css.'-f markdown -t "'.format.'" -o "'.exitfile.'" >> "'.errorfile.'" 2>&1'], {'on_exit': {j,d,e -> execute('call s:convert_events("'.d.'", "0", "'.mdfile.'", "'.errorfile.'", "'.exitfile.'", "")', '')}})
    else
        echohl ErrorMsg | echo "Erreur : le fichier ouvert n'a pas de nom." | echohl None
    endif
endfunction
function! CompletionFormat(ArgLead, CmdLine, CursorPos)
    " Pandoc peut convertir vers toutes les librairies suivantes
    " return ['dzslides', 'revealjs', 's5', 'slideous', 'slidy']
    " mais seules 'dzslides' et 'slidy' ne nécessitent pas le
    " téléchargement préalable de leur librairie
    return ['dzslides', 'slidy']
endfunction
function! CompletionSelfContained(ArgLead, CmdLine, CursorPos)
    return ['--self-contained', '--no-self-contained']
endfunction
function! convertfiles#CompletionTest(ArgLead, CmdLine, CursorPos)
    let l = split(a:CmdLine[:a:CursorPos-1], '\%(\%(\%(^\|[^\\]\)\\\)\@<!\s\)\+', 1)
    let n = len(l) - index(l, 'ConvToSlides') - 2
    if n < 2
        let funcs = ['CompletionFormat', 'CompletionSelfContained']
        return call(funcs[n], [a:ArgLead, a:CmdLine, a:CursorPos])
    endif
endfunction
