" use existing .vimrc, which contains config
" items that are compatible with native Vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require('plugins')
lua require('lsconfig')
lua require('trouble-config')
lua require('haskell-config')

colorscheme tokyonight-night

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
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"}}

