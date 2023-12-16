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

-- Initialise lazy.nvim (package manager)
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

-- Set colour scheme (must be done after tokyonight.nvim is loaded)
vim.cmd([[colorscheme tokyonight-night]])

-- Format Python files with black on save. I only install black in my conda environments,
-- so check that we're in a conda environment first - otherwise, we'll get an error when
-- we attempt to call BlackSync()
vim.cmd([[
if !empty($CONDA_PREFIX)
    autocmd BufWritePre *.py call BlackSync()
endif

" Skip AST check, which makes formatting faster
let g:black#settings = {
    \ 'fast': 1,
    \}
]])

