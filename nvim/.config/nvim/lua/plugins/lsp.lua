-- REF: Most of this configuration is adapted from https://lsp-zero.netlify.app/docs/
-- REF: To get rid of the `vim` global variable warnings, and add basic completions for Neovim's lua api,
-- REF: see https://lsp-zero.netlify.app/docs/autocomplete.html#basic-completions-for-neovim-s-lua-api

local treesitter_ensure_installed = {
    "lua",
    -- "markdown",
    -- "markdown_inline",
    "python",
    -- "rust",
    -- "vim",
    -- "vimdoc"
}

local mason_ensure_installed = {
    -- These aren't supported in ensure_installed as they aren't LSPs,
    -- but are still useful to note
    -- "black",
    -- "isort",

    -- "clangd",
    "lua_ls",
    -- "julials",
    "pylsp",
    -- "rust_analyzer",  -- rust_analyzer@2024-10-21
    -- "texlab",
}

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
                ensure_installed = treesitter_ensure_installed,
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
            { "hrsh7th/cmp-nvim-lsp-signature-help" }
        },
        config = function()
            -- Cmp settings
            local cmp = require("cmp")

            -- Snippet settings
            local luasnip = require("luasnip")
            local texsnippets = require("snippets.tex")
            -- We want every text change to trigger an update
            -- This makes it easier to see repeat nodes in "real time"
            -- REF: https://github.com/L3MON4D3/LuaSnip/issues/248
            luasnip.config.setup({ enable_autosnippets = true, update_events = { "TextChanged", "TextChangedI" } })
            luasnip.add_snippets("tex", texsnippets)

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lsp_signature_help" },
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
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behaviour = "select" })
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
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
                    vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>",
                        { buffer = event.buf, desc = "Display hover information (lsp)" })
                    vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>",
                        { buffer = event.buf, desc = "Jump to definition (lsp)" })
                    vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>",
                        { buffer = event.buf, desc = "Jump to declaration (lsp)" })
                    vim.keymap.set("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>",
                        { buffer = event.buf, desc = "List all implementations (lsp)" })
                    vim.keymap.set("n", "go", "<Cmd>lua vim.lsp.buf.type_definition()<CR>",
                        { buffer = event.buf, desc = "Jump to definition of type (lsp)" })
                    vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>",
                        { buffer = event.buf, desc = "List all references (lsp)" })
                    vim.keymap.set("n", "gs", "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
                        { buffer = event.buf, desc = "Display signature information (lsp)" })
                    vim.keymap.set("n", "<F2>", "<Cmd>lua vim.lsp.buf.rename()<CR>",
                        { buffer = event.buf, desc = "Rename all references (lsp)" })
                    vim.keymap.set({ "n", "x" }, "<F3>", "<Cmd>lua require('conform').format({async = true})<CR>",
                        { buffer = event.buf, desc = "Format current buffer (conform)" })
                    vim.keymap.set("n", "<F4>", "<Cmd>lua vim.lsp.buf.code_action()<CR>",
                        { buffer = event.buf, desc = "Selects an available code action (lsp)" })
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
                ensure_installed = mason_ensure_installed,
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
                    end,
                    texlab = function()
                        require("lspconfig").texlab.setup({
                            -- Disable texlab formatter, I don't like auto-indenting
                            -- REF: https://github.com/latex-lsp/texlab/wiki/Configuration#texlablatexformatter
                            settings = { texlab = { latexFormatter = "texlab" } }
                        })
                    end,
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
            format_on_save = function(bufnr)
                -- Disable on certain filetypes
                local ignore_filetypes = { "bib" }
                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                    return
                end
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end
        },
    }
}
