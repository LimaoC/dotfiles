-- Use existing .vimrc, which contains config items that are compatible with native Vim
vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
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
require("lazy").setup(
    "plugins",
    {
        checker = { enabled = true },
        ui = { border = "rounded" },
        rtp = {
            disabled_plugins = {
                "netrwPlugin",
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
            }
        }
    }
)

-- Set colour scheme (must be done after tokyonight.nvim is loaded)
vim.cmd([[colorscheme tokyonight-moon]])

-- Use block cursor in all modes
vim.opt.guicursor = "i:block"
