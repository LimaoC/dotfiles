return {
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- load at startup
        priority = 1000, -- load this before other start plugins
        opts = {},
    },

    {
        "romgrk/barbar.nvim",
        version = "^1.0.0", -- only update when a new 1.x version is released
        lazy = false,
        priority = 100,
        dependencies = {
            "lewis6991/gitsigns.nvim",    -- for git status
            "nvim-tree/nvim-web-devicons" -- for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            focus_on_close = "previous",
            highlight_visible = false,
            icons = {
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = true },
                },
                gitsigns = {
                    added = { enabled = true, icon = "+" },
                    changed = { enabled = true, icon = "~" },
                    deleted = { enabled = true, icon = "-" },
                },
            },
            sidebar_filetypes = { NvimTree = { text = " NvimTree" } },
            no_name_title = "[unnamed buffer]",
        },
        keys = {
            { "<A-h>",     "<Cmd>BufferPrevious<CR>",            desc = "Change to previous buffer (barbar)" },
            { "<A-l>",     "<Cmd>BufferNext<CR>",                desc = "Change to next buffer (barbar)" },
            { "<A-H>",     "<Cmd>BufferMovePrevious<CR>",        desc = "Switch with previous buffer (barbar)" },
            { "<A-L>",     "<Cmd>BufferMoveNext<CR>",            desc = "Switch with next buffer (barbar)" },
            { "<A-1>",     "<Cmd>BufferGoto 1<CR>",              desc = "Change to buffer 1 (barbar)" },
            { "<A-2>",     "<Cmd>BufferGoto 2<CR>",              desc = "Change to buffer 2 (barbar)" },
            { "<A-3>",     "<Cmd>BufferGoto 3<CR>",              desc = "Change to buffer 3 (barbar)" },
            { "<A-4>",     "<Cmd>BufferGoto 4<CR>",              desc = "Change to buffer 4 (barbar)" },
            { "<A-5>",     "<Cmd>BufferGoto 5<CR>",              desc = "Change to buffer 5 (barbar)" },
            { "<A-6>",     "<Cmd>BufferGoto 6<CR>",              desc = "Change to buffer 6 (barbar)" },
            { "<A-7>",     "<Cmd>BufferGoto 6<CR>",              desc = "Change to buffer 7 (barbar)" },
            { "<A-8>",     "<Cmd>BufferGoto 7<CR>",              desc = "Change to buffer 8 (barbar)" },
            { "<A-9>",     "<Cmd>BufferGoto 8<CR>",              desc = "Change to buffer 9 (barbar)" },
            { "<A-0>",     "<Cmd>BufferLast<CR>",                desc = "Change to last buffer (barbar)" },
            { "<A-p>",     "<Cmd>BufferPin<CR>",                 desc = "Pin/unpin buffer  (barbar)" },
            { "<A-c>",     "<Cmd>BufferClose<CR>",               desc = "Close buffer (barbar)" },
            { "<C-p>",     "<Cmd>BufferPick<CR>",                desc = "Magic buffer-picking mode (barbar)" },
            { "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Order buffers by buffer number (barbar)" },
            { "<Space>bn", "<Cmd>BufferOrderByName<CR>",         desc = "Order buffers by name (barbar)" },
            { "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>",    desc = "Order buffers by directory (barbar)" },
            { "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>",     desc = "Order buffers by language (barbar)" },
            { "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", desc = "Order buffers by window number (barbar)" },
        }
    },

    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = { disabled_filetypes = { "NvimTree" } },
            extensions = { "mason", "quickfix", "trouble" },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        opts = { current_line_blame = true },
        keys = {
            { "<Leader>hn", "<Cmd>Gitsigns nav_hunk next<CR>",       desc = "Go to next hunk (Gitsigns)" },
            { "<Leader>hp", "<Cmd>Gitsigns nav_hunk prev<CR>",       desc = "Go to prev hunk (Gitsigns)" },
            { "<Leader>hs", "<Cmd>Gitsigns stage_hunk<CR>",          desc = "Stage hunk (Gitsigns)" },
            { "<Leader>hr", "<Cmd>Gitsigns reset_hunk<CR>",          desc = "Reset hunk (Gitsigns)" },
            { "<Leader>hi", "<Cmd>Gitsigns preview_hunk_inline<CR>", desc = "Preview hunk inline (Gitsigns)" },
            { "<Leader>bb", "<Cmd>Gitsigns blame<CR>",               desc = "Blame window (Gitsigns)" },
            { "<Leader>bl", "<Cmd>Gitsigns blame_line<CR>",          desc = "Blame for current line (Gitsigns)" },
        }
    },

    {
        "folke/which-key.nvim",
        version = "*",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = { enabled = false } }
        },
        keys = {
            { "<Leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer local keymaps (which-key)" },
        },
    },

    {
        "folke/snacks.nvim",
        version = "*",
        priority = 1000,
        lazy = false,
        opts = {
            indent = { enabled = true },
            picker = { enabled = true },
            notifier = {
                enabled = true,
                top_down = false,
            },
            statuscolumn = { enabled = true },
        },
        keys = {
            { "<leader>n", function() require("snacks").notifier.show_history() end, desc = "Notification history (snacks)" },
            { "z=",        function() require("snacks").picker.spelling() end,       desc = "Spelling suggestions (snacks)" },
        }
    },
}
