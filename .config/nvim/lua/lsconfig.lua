--{{ LSP config
-- https://github.com/neovim/nvim-lspconfig

local lspconfig = require('lspconfig')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.document_formatting then
        vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    elseif client.server_capabilities.document_range_formatting then
        vim.keymap.set('n', '<space>f', vim.lsp.buf.range_formatting, bufopts)
    end
end

--}}
--{{ nvim-cmp, cmp-nvim-lsp, nvim-snippy, cmp-snippy config
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/hrsh7th/cmp-nvim-lsp
-- https://github.com/dcampos/nvim-snippy
-- https://github.com/dcampos/cmp-snippy

-- Additional LSP configs supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enable language servers
local servers = { 'julials', 'pyright' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- Setup snippy
local snippy = require('snippy')

-- Setup nvim-cmp
local cmp = require('cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            snippy.expand_snippet(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),            -- Scroll up in documentation
        ['<C-d>'] = cmp.mapping.scroll_docs(4),             -- Scroll down in documentation
        ['<C-Space>'] = cmp.mapping.complete(),             -- Invoke completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Accept currently selected item
        ['<Tab>'] = cmp.mapping(function(fallback)          -- Select next completion item if 
            if cmp.visible() then                           --   the completion menu is visible.
                cmp.select_next_item()                      --   Otherwise, expands the current
            elseif snippy.can_expand_or_advance() then      --   trigger (if possible) or jumps
                snippy.expand_or_advance()                  --   to the nextavailable tab stop
            else                                            --   if either can be performed.
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)        -- Select previous completion item
            if cmp.visible() then                           --   if the completion menu is
                cmp.select_prev_item()                      --   visible.
            elseif snippy.can_jump(-1) then
                snippy.previous()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'snippy' },
    }),
    experimental = {
        ghost_text = true,
    }
}

