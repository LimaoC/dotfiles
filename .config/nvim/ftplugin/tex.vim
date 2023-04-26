" vimtex config
let g:vimtex_view_method = 'zathura_simple'  " need xdotool for zathura
let g:vimtex_indent_enabled = 0              " disable automatic indenting
let g:vimtex_imaps_enabled = 0               " disable insert mode mappings
let g:vimtex_quickfix_mode = 0               " disable quickfix window opening automatically (I use trouble.nvim)
" disable ']]' as it slows down the 'lr[]' snippet
let g:vimtex_mappings_disable = {
    \ 'i': [']]'],
    \}
let g:vimtex_syntax_conceal = {
    \ 'accents': 1,
    \ 'ligatures': 1,
    \ 'cites': 0,
    \ 'fancy': 0,
    \ 'spacing': 1,
    \ 'greek': 0,
    \ 'math_bounds': 0,
    \ 'math_delimiters': 1,
    \ 'math_fracs': 0,
    \ 'math_super_sub': 0,
    \ 'math_symbols': 0,
    \ 'sections': 0,
    \ 'styles': 0,
    \}
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'build',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \   '-shell-escape',
    \ ],
    \}

set conceallevel=2  " syntax concealing
set wrap            " latex code lines tend to be longer so wrapping is more desirable

