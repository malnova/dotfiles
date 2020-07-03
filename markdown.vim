hi markdownH1 ctermfg=3 cterm=bold
hi markdownH2 ctermfg=3 cterm=bold
hi markdownH3 ctermfg=3 cterm=bold
hi markdownH4 ctermfg=3 cterm=bold
hi markdownH5 ctermfg=3 cterm=bold
hi markdownH6 ctermfg=3 cterm=bold
hi markdownHeadingDelimiter ctermfg=2
hi markdownBlockquote ctermfg=blue
hi markdownCode ctermfg=white ctermbg=black
hi markdownCodeBlock ctermfg=white ctermbg=black
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
" Ajout de plusieurs groupes
" Repris de https://github.com/vim-pandoc/vim-pandoc-syntax/blob/master/syntax/pandoc.vim
syn region pandocFootnoteDef start=/\^\[/ skip=/\[.\{-}]/ end=/\]/
hi link pandocFootnoteDef markdownFootnoteDefinition
syn region pandocLaTeXInlineMath start=/\v\\@<!\$\S@=/ end=/\v\\@<!\$\d@!/ keepend
syn region pandocLaTeXInlineMath start=/\\\@<!\\(/ end=/\\\@<!\\)/ keepend
syn region pandocLaTeXMathBlock start=/\$\$/ end=/\$\$/ keepend
syn region pandocLaTeXMathBlock start=/\\\@<!\\\[/ end=/\\\@<!\\\]/ keepend
hi link pandocLaTeXInlineMath markdownCode
hi link pandocLaTeXMathBlock markdownCode
syn region markdownSubscript start=/\~\(\([[:graph:]]\(\\ \)\=\)\{-}\~\)\@=/ end=/\~/ keepend
syn region markdownSuperscript start=/\^\(\([[:graph:]]\(\\ \)\=\)\{-}\^\)\@=/ skip=/\\ / end=/\^/ keepend
hi link markdownSubscript markdownCode
hi link markdownSuperscript markdownCode
syn match pandocUListItem /^>\=\s*[*+-]\ze\s\+-\@!.*$/
syn match pandocUListItemBullet /^>\=\s*\zs[*+-]/ contained containedin=pandocUListItem conceal cchar=•
hi Conceal ctermfg=white ctermbg=none cterm=bold
hi link markdownOrderedListMarker Conceal
syn match pandocListItem /^\s*(\?\(\d\+\|\l\|\#\|@\)\+[.)]\ze\s\+.*$/
syn match pandocListItem /^\s*(\?x\=l\=\(i\{,3}[a-z]\=\)\{,3}c\{,3}[.)]\ze\s\+.*$/
hi link pandocListItem Conceal
syn match pandocBlockquote /^\s\{,3}>.*\n\(.*\n\@1<!\n\)*/
hi link pandocBlockquote markdownBlockquote
