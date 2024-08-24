-- REF: https://lsp-zero.netlify.app/v3.x/guide/lazy-loading-with-lazy-nvim

return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufRead" },
        build = ":TSUpdate",
        config = function()
            -- NOTE:
            -- https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
            -- This error can occur if you have more than one `parser` runtime directory. See above for details.
            -- If the nvim parser is one of them, you can remove it by changing the directory name from `parser`.
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" }, -- completion source for luasnip
            { "windwp/nvim-autopairs" },
            --{ "evesdropper/luasnip-latex-snippets.nvim" },
        },
        config = function()
            -- Autocompletion settings
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            -- Cmp settings
            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()
            -- Insert '()' after selecting a function/method completion item
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )

            -- Snippet settings
            local luasnip = require("luasnip")
            local texsnippets = require("user.luasnippets.tex")
            -- We want every text change to trigger an update
            -- This makes it easier to see repeat nodes in "real time"
            -- REF: https://github.com/L3MON4D3/LuaSnip/issues/248
            luasnip.config.setup({ enable_autosnippets = true, update_events = { "TextChanged", "TextChangedI" } })
            luasnip.add_snippets("tex", texsnippets)

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                mapping = cmp.mapping.preset.insert({
                    -- Scroll up and down in documentation
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    -- Close, complete and accept selected item in completion menu
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-Space>"] = cmp.mapping.confirm({ select = true }),
                    -- Navigate between completion items
                    ["<Tab>"] = cmp_action.luasnip_supertab(),
                    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
                }),
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- Show source name in completion menu
                formatting = lsp_zero.cmp_format({ details = true }),
                -- Preselect the first item in the completion menu
                preselect = "item",
                completion = {
                    completeopt = "menu,menuone,noinsert"
                },
                -- Disable completion in comments
                enabled = function()
                    local context = require "cmp.config.context"
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment")
                            and not context.in_syntax_group("Comment")
                    end
                end
            })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" }, -- lazy-load on one of these commands
        event = { "BufReadPre", "BufNewFile" },        -- or one of these events
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
            { "jose-elias-alvarez/null-ls.nvim" },
            { "jay-babu/mason-null-ls.nvim" },
            { "nvim-lua/plenary.nvim" }, -- needed for null-ls
        },
        config = function()
            -- This is where all the LSP shenanigans live
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- See :h lsp-zero-keybindings to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            -- REF: https://lsp-zero.netlify.app/v3.x/language-server-configuration.html#explicit-setup
            lsp_zero.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ["clangd"] = { "c" },
                    ["julials"] = { "julia" },
                    ["lua_ls"] = { "lua" },
                    ["null-ls"] = { "python" }, -- black is installed with null-ls
                    ["rust_analyzer"] = { "rust" },
                    ["texlab"] = { "tex" },
                }
            })

            -- REF: https://lsp-zero.netlify.app/v3.x/language-server-configuration.html#diagnostics
            lsp_zero.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = '»'
            })

            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "julials", "lua_ls", "pylsp", "rust_analyzer", "texlab" },
                handlers = {
                    -- This first function is the default handler
                    -- It applies to every language server without a custom handler
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                    clangd = function()
                        require("lspconfig").clangd.setup({
                            cmd = {
                                "clangd",
                                "--background-index",
                                "--clang-tidy",
                                "--header-insertion=iwyu",
                                "--completion-style=detailed",
                            },
                        })
                    end,
                    pylsp = function()
                        require("lspconfig").pylsp.setup({
                            settings = { pylsp = { plugins = { pycodestyle = { maxLineLength = 88 } } } }
                        })
                    end
                },
            })

            -- null-ls settings
            require("mason-null-ls").setup({
                ensure_installed = { "black", "isort" },
            })

            local null_ls = require("null-ls")
            require("null-ls").setup({
                sources = {
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                }
            })

            -- To get rid of the warnings around the `vim` global variable, see:
            -- REF: https://lsp-zero.netlify.app/v3.x/getting-started.html#lua-language-server-and-neovim
        end,
    },
}
