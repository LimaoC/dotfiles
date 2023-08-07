" use existing .vimrc, which contains config
" items that are compatible with native Vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require('plugins')
lua require('ls-config')
lua require('cmp-config')
lua require('diagnostics-config')
lua require('treesitter-config')

colorscheme tokyonight-night
set signcolumn=yes            " set sign column to always be on

" If there is a conda environment active, use that Python interpreter
if !empty($CONDA_PREFIX)
    let g:python3_host_prog = $CONDA_PREFIX . '/bin/python3'
endif

"{{ fzf.vim config
" open in new tab, open in horizontal splits, open in vertical splits
" (respectively)
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'
    \}

" Customize fzf colours to match colorscheme
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment']
    \}

noremap <leader>F :FZF <CR>
"}}

"{{ DelimitMate.vim config
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1

" Auto-insert closing docstring characters
au FileType python,julia let b:delimitMate_nesting_quotes = ['"']
"}}

"{{ vim-commentary config
noremap <C-_> <Plug>Commentary
"}}

