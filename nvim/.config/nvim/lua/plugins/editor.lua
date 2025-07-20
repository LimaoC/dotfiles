-- Disable netrw (recommended for nvim-tree and barbar). See :h nvim-tree-netrw for details.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set termguicolors to enable highlight groups (for nvim-tree)
vim.opt.termguicolors = true

-- Disable diagnostic virtual text (in favour of trouble.nvim)
vim.diagnostic.config({ virtual_text = false })

-- Open nvim-tree for directories and change Neovim's directory
-- REF: https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup#open-for-directories-and-change-neovims-directory
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(data)
        -- Buffer is a directory
        local directory = vim.fn.isdirectory(data.file) == 1
        if not directory then
            return
        end

        vim.cmd.cd(data.file)
        require("nvim-tree.api").tree.open()
    end
})

-- Decide behaviour for auto-closing nvim-tree on QuitPre
-- REF: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#marvinth01
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        -- Get all nvim-tree windows and floating windows
        for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil then
                table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= '' then
                table.insert(floating_wins, w)
            end
        end
        if 1 == #wins - #floating_wins - #tree_wins then
            -- Should quit, so we close all invalid windows.
            for _, w in ipairs(tree_wins) do
                vim.api.nvim_win_close(w, true)
            end
        end
    end
})

return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*", -- latest stable release
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            sort = { sorter = "case_sensitive" },
            view = { side = "right" },
            renderer = {
                group_empty = true,
                full_name = true,
                highlight_git = "name",
            },
            filters = {
                dotfiles = true,
                exclude = { ".github" },
            },
            tab = {
                sync = {
                    open = true,
                    close = true,
                },
            },
        },
        keys = {
            { "<Leader>t", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle tree (NvimTree)" },
        },
    },

    {
        "romgrk/barbar.nvim",
        version = "^1.0.0", -- (optional) only update when a new 1.x version is released
        lazy = false,
        priority = 100,
        dependencies = {
            "nvim-tree/nvim-web-devicons" -- (optional) for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            focus_on_close = "previous",
            highlight_visible = false,
            icons = {
                diagnostics = {
                    [vim.diagnostic.severity.ERROR] = { enabled = true },
                    [vim.diagnostic.severity.HINT] = { enabled = true },
                },
            },
            sidebar_filetypes = {
                NvimTree = { text = " NvimTree" }
            },
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
            options = {
                disabled_filetypes = { "NvimTree" },
            },
            extensions = { "mason", "quickfix", "trouble" },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = { current_line_blame = true },
        keys = {
            { "<Leader>hs", "<Cmd>Gitsigns stage_hunk<CR>",          desc = "Stage hunk (Gitsigns)" },
            { "<Leader>hr", "<Cmd>Gitsigns reset_hunk<CR>",          desc = "Reset hunk (Gitsigns)" },
            { "<Leader>hi", "<Cmd>Gitsigns preview_hunk_inline<CR>", desc = "Preview hunk inline (Gitsigns)" },
            { "<Leader>bb", "<Cmd>Gitsigns blame<CR>",               desc = "Blame window (Gitsigns)" },
            { "<Leader>bl", "<Cmd>Gitsigns blame_line<CR>",          desc = "Blame for current line (Gitsigns)" },
        }
    },

    {
        "folke/which-key.nvim",
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

    {
        "rmagatti/auto-session",
        dependencies = { "nvim-tree/nvim-tree.lua" },
        lazy = false,
        opts = {
            suppressed_dirs = { "~/", "~/Downloads", "/" },
            show_auto_restore_notif = true,
            pre_save_cmds = {
                -- Execute User SessionSavePre before :mksession to restore barbar tab order
                -- REF: https://github.com/romgrk/barbar.nvim?tab=readme-ov-file#sessions
                function() vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" }) end
            }
        },
        config = function(_, opts)
            require("auto-session").setup(opts)
            -- Set globals in sessionoptions to restore barbar tab order
            -- REF: https://github.com/romgrk/barbar.nvim?tab=readme-ov-file#sessions
            vim.o.sessionoptions =
            "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"
        end,
        keys = {
            -- Will use Telescope if installed or a vim.ui.select picker otherwise
            { "<Leader>wr", "<Cmd>SessionSearch<CR>",         desc = "Session search (auto-session)" },
            { "<Leader>ws", "<Cmd>SessionSave<CR>",           desc = "Save session (auto-session)" },
            { "<Leader>wd", "<Cmd>SessionDelete<CR>",         desc = "Delete session (auto-session)" },
            { "<Leader>wa", "<Cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave (auto-session)" },
        },
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            modes = {
                symbols = {
                    win = { position = "left" },
                },
            },
        },
        config = true,
        cmd = "Trouble",
        keys = {
            { "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>",                        desc = "Diagnostics (Trouble)" },
            { "<Leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",           desc = "Buffer diagnostics (Trouble)" },
            { "<Leader>cs", "<Cmd>Trouble symbols toggle focus=false<CR>",                desc = "Symbols (Trouble)" },
            { "<Leader>cl", "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP definitions/references/... (Trouble)" },
            { "<Leader>xL", "<Cmd>Trouble loclist toggle<CR>",                            desc = "Location list (Trouble)" },
            { "<Leader>xQ", "<Cmd>Trouble qflist toggle<CR>",                             desc = "Quickfix list (Trouble)" },
        },
    },
}
