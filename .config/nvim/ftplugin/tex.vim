" vimtex config
let g:vimtex_view_method = 'zathura_simple'
let g:vimtex_syntax_conceal = {
    \ 'accents': 1,
    \ 'ligatures': 1,
    \ 'cites': 0,
    \ 'fancy': 0,
    \ 'spacing': 1,
    \ 'greek': 1,
    \ 'math_bounds': 1,
    \ 'math_delimiters': 1,
    \ 'math_fracs': 0,
    \ 'math_super_sub': 0,
    \ 'math_symbols': 0,
    \ 'sections': 0,
    \ 'styles': 0,
    \}

set conceallevel=2  " syntax concealing
set wrap            " latex lines tend to be longer so wrapping is more desirable

