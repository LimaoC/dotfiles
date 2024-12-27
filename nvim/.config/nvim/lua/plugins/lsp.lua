-- REF: Most of this configuration is adapted from https://lsp-zero.netlify.app/docs/
-- REF: To get rid of the `vim` global variable warnings, and add basic completions for Neovim's lua api,
-- REF: see https://lsp-zero.netlify.app/docs/autocomplete.html#basic-completions-for-neovim-s-lua-api

return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufRead" },
        build = ":TSUpdate",
        config = function()
            -- REF: https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
            -- This error can occur if you have more than one `parser` runtime directory. See above for details.
            -- If the nvim parser is one of them, you can remove it by changing the directory name from `parser`.
            require("nvim-treesitter.configs").setup({
                -- ensure_installed = { "lua", "markdown", "markdown_inline", "python", "query", "rust", "vim", "vimdoc" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" }, -- completion source for luasnip
        },
        config = function()
            -- Cmp settings
            local cmp = require("cmp")

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
                    -- Navigate between completion items using "super tab"
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        local luasnip = require("luasnip")
                        local col = vim.fn.col(".") - 1

                        if cmp.visible() then
                            cmp.select_next_item({ behaviour = "select" })
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                            fallback()
                        else
                            cmp.complete()
                        end
                    end, {"i", "s"}),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        local luasnip = require("luasnip")

                        if cmp.visible() then
                            cmp.select_prev_item({ behaviour = "select" })
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                }),
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- Preselect the first item in the completion menu
                preselect = "item",
                completion = {
                    completeopt = "menu,menuone,noinsert"
                },
                -- Bordered completion menus
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
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
            { "stevearc/conform.nvim" },
            -- { "jose-elias-alvarez/null-ls.nvim" },
            -- { "jay-babu/mason-null-ls.nvim" },
            -- { "nvim-lua/plenary.nvim" }, -- needed for null-ls
        },
        init = function()
            vim.opt.signcolumn = "yes"
        end,
        config = function()
            -- This is where all the LSP shenanigans live

            -- Add cmp_nvim_lsp capabilities to lspconfig
            -- This should be executed before you configure any language server
            local lsp_defaults = require("lspconfig").util.default_config
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lsp_defaults.capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({"n", "x"}, "<F3>", "<cmd>lua require('conform').format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            -- If we need to save a file without formatting...
            vim.api.nvim_create_user_command("Write", "noautocmd write", {})

            -- Diagnostics
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✘",
                        [vim.diagnostic.severity.WARN] = "▲",
                        [vim.diagnostic.severity.HINT] = "⚑",
                        [vim.diagnostic.severity.INFO] = "»",
                    },
                },
            })

            -- Automatic installs of language servers
            require("mason").setup({})
            require("mason-lspconfig").setup({
                -- Use rust_analyzer@2024-10-21
                -- REF: https://www.reddit.com/r/rust/comments/1geyfld/rustanalyzer_server_cancelled_the_request_in/
                -- ensure_installed = { "clangd", "julials", "lua_ls", "pylsp", "rust_analyzer@2024-10-21", "texlab" },
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
        end,
    },

    -- Formatting
    {
        -- REF: https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            formatters_by_ft = {
                python = { "isort", "black" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    }
}
