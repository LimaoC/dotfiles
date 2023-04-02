-- Automatically install and set up packer.nvim on any machine this config is cloned to
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Automatically run :PackerCompile whenever plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'             -- Package manager
    use 'neovim/nvim-lspconfig'              -- nvim LSP configs
    use 'hrsh7th/nvim-cmp'                   -- nvim completion engine
    use 'hrsh7th/cmp-nvim-lsp'               -- nvim-cmp source for nvim LSP
    use 'dcampos/nvim-snippy'                -- Snippets plugin
    use 'dcampos/cmp-snippy'                 -- Snippets source for nvim-cmp
    use 'folke/tokyonight.nvim'              -- Tokyo Night theme
    use {                                    -- haskell-tools plugin
        'mrcjkb/haskell-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim', -- optional
        },
        branch = '1.x.x', -- recommended
    }
    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
        }
      end
    }

    -- Automatically install and set up packer.nvim on any machine this config is cloned to
    if packer_bootstrap then
        require('packer').sync()
    end
end)

