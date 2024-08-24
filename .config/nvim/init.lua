-- Use existing .vimrc, which contains config items that are compatible with native Vim
vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])

-- Set status column (git signs and diagnostics)
vim.opt.statuscolumn = [[%!v:lua.require'user.statuscolumn'.statuscolumn()]]

-- If there is an active conda environment, use its Python interpreter
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
