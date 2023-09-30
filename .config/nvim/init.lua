-- Use existing .vimrc, which contains config items that are compatible with native Vim
vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])

-- If there is an active conda environment, use that Python interpreter
vim.cmd([[
if !empty($CONDA_PREFIX)
    let g:python3_host_prog = $CONDA_PREFIX . '/bin/python3'
else
    let g:python3_host_prog = '/usr/bin/python3'
endif
]])

-- Initialise lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")

vim.cmd([[
colorscheme tokyonight-night  " must be done after tokyonight.nvim is loaded
]])

vim.cmd([[
" Format file on save
" I only install black on my conda environments, so check for this first
if !empty($CONDA_PREFIX)
    autocmd BufWritePre *.py call BlackSync()
endif

let g:black#settings = {
    \ 'fast': 1,
    \ 'line_length': 100,
    \}
]])

