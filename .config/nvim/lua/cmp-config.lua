--{{ nvim-cmp, cmp-nvim-lsp, ultisnips, cmp-nvim-ultisnips config
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/hrsh7th/cmp-nvim-lsp
-- https://github.com/SirVer/ultisnips
-- https://github.com/quangnguyen30192/cmp-nvim-ultisnips

local cmp = require('cmp')
local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),                 -- Scroll up in documentation
        ['<C-d>'] = cmp.mapping.scroll_docs(4),                  -- Scroll down in documentation
        ['<C-l>'] = cmp.mapping.close(),                         -- Close completion menu
        ['<C-y>'] = cmp.mapping.complete(),                      -- Invoke completion menu
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }),  -- Accept currently selected item
        -- Select next completion item if the completion menu is visible. Otherwise, try to expand
        -- the current trigger or try to jump to the next available tab stop.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
            end
        end, { 'i', 's' }),
        -- Select previous completion item if the completion menu is visible. Otherwise, jump to
        -- the previous available tab stop.
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                cmp_ultisnips_mappings.jump_backwards(fallback)
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
    }),
    enabled = function()
        -- Enable completion only if we're not inside a comment
        if require('cmp.config.context').in_treesitter_capture('comment') == true or
                require('cmp.config.context').in_syntax_group('Comment') then
            return false
        else
            return true
        end
    end,
    experimental = {
        ghost_text = true
    }
}

--}}

