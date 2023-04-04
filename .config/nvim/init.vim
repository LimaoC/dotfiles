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

