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
    --{{ general plugins
    use 'wbthomason/packer.nvim'                   -- Package manager
    use 'tpope/vim-surround'                       -- Surroundings plugin
    use 'Raimondi/delimitMate'                     -- Auto close quotes, brackets, etc.
    use {                                          -- Diagnostics, references, quickfix lists
        'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons'
    }
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim"
    }
    use 'neovim/nvim-lspconfig'                    -- nvim LSP configs
    use 'hrsh7th/nvim-cmp'                         -- nvim completion engine
    use 'hrsh7th/cmp-nvim-lsp'                     -- nvim-cmp source for nvim LSP
    use 'SirVer/ultisnips'                         -- Snippets plugin
    use {                                          -- Snippets source for nvim-cmp
        'quangnguyen30192/cmp-nvim-ultisnips',
        config = function()
            require('cmp_nvim_ultisnips').setup{}
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {                                          -- Fuzzy finder
        'junegunn/fzf.vim',
        requires = {
            'junegunn/fzf',
            run = ':call fzf#install()'
        }
    }
    --}}
    --{{ themes
    use 'folke/tokyonight.nvim'  -- Tokyo Night theme
    --}}
    --{{ language specific
    use 'lervag/vimtex'                      -- LaTeX in vim
    use {                                    -- Configures `haskell-language-server`
        'mrcjkb/haskell-tools.nvim',         -- and integrates with other haskell tools
        requires = 'nvim-lua/plenary.nvim',
        branch = '2.x.x',                    -- recommended (stable branch)
    }
    --}}
    -- Automatically install and set up packer.nvim on any machine this config is cloned to
    if packer_bootstrap then
        require('packer').sync()
    end
end)

