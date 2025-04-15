" vimtex config
let g:vimtex_compiler_latexmk = {
    \ 'aux_dir': {-> "build-" .. expand("%:t:r")},
    \ 'out_dir': {-> "build-" .. expand("%:t:r")},
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \   '-shell-escape',
    \ ],
    \}
let g:vimtex_imaps_enabled = 0                   " disable insert mode mappings
let g:vimtex_indent_enabled = 0                  " disable automatic indenting
let g:vimtex_indent_ignored_envs = [
    \ 'document',
    \ '.*',
    \]
let g:vimtex_mappings_disable = { 'i': [']]'] }  " disable ']]' as it slows down the 'lr[]' snippet
let g:vimtex_syntax_conceal_disable = 1          " disable all syntax concealment
let g:vimtex_view_method = 'zathura_simple'      " need xdotool for zathura, so use zathura_simple

let g:vimtex_grammar_textidote = {
    \ 'jar': '~/.local/bin/textidote.jar',
    \}

let g:tex_flavor = "latex"

set wrap  " latex code lines tend to be longer so wrapping is more desirable
setlocal spell spelllang=en_au

filetype indent off  " disable filetype indentation
