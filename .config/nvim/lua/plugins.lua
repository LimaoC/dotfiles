return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'   -- package manager

    use 'neovim/nvim-lspconfig'    -- nvim LSP configs
    use 'hrsh7th/nvim-cmp'         -- autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'     -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip'         -- snippets plugin
end)

