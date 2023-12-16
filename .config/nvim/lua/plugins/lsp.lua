vim.cmd([[ let g:UltiSnipsExpandTrigger="<c-space>" ]])

-- vim.diagnostic.config({
--     virtual_text = false,
-- })

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',  -- lazy-load on entering insert mode
        dependencies = {
            { 'SirVer/ultisnips' },
            {
                'quangnguyen30192/cmp-nvim-ultisnips',
                config = function() require("cmp_nvim_ultisnips").setup{} end
            },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        },
        config = function()
            -- Configure autocompletion settings
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            -- Configure cmp settings
            local cmp = require("cmp")
            local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                snippet = {
                    expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "ultisnips" },
                    { name = "nvim_lsp_signature_help" },
                },
                mapping = cmp.mapping.preset.insert({
                    -- Scroll up and down in documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    -- Close, complete, and accept selected item in completion menu
                    ['<C-l>'] = cmp.mapping.close(),
                    ['<C-y>'] = cmp.mapping.complete(),
                    ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
                    -- Navigate between completion items
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        cmp_ultisnips_mappings.compose { "jump_forwards", "select_next_item" }(fallback)
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        cmp_ultisnips_mappings.compose { "jump_backwards", "select_prev_item" }(fallback)
                    end, { 'i', 's' }),
                }),
                experimental = {
                    ghost_text = true
                }
            })
        end
    },

    -- LSP Support
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },  -- lazy-load on executing one of these commands
        event = {'BufReadPre', 'BufNewFile'},           -- or one of these events
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
        },
        config = function()
            -- This is where all the LSP shenanigans live
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()
            lsp_zero.configure("lua_ls", {
                settings = { Lua = { diagnostics = { globals = { "vim" } } } }
            })

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require("mason-lspconfig").setup({
                handlers = {
                    lsp_zero.default_setup,
                }
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- LSP Signatures
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        config = function()
            require("lsp_signature").setup({
                hint_enable = false,
            })
        end
    }
}
