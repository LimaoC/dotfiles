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
            {
                "<S-t>",
                "<Cmd>NvimTreeToggle<CR>",
                desc = "Toggle NvimTree",
            },
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
        config = function(_, opts)
            require("barbar").setup(opts)

            -- barbar mappings
            local map_opts = { noremap = true, silent = true }
            local map = vim.api.nvim_set_keymap
            -- Move to previous/next
            map("n", "<A-h>", "<Cmd>BufferPrevious<CR>", map_opts)
            map("n", "<A-l>", "<Cmd>BufferNext<CR>", map_opts)
            -- Re-order to previous/next
            map("n", "<A-H>", "<Cmd>BufferMovePrevious<CR>", map_opts)
            map("n", "<A-L>", "<Cmd>BufferMoveNext<CR>", map_opts)
            -- Goto buffer in position...
            map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", map_opts)
            map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", map_opts)
            map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", map_opts)
            map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", map_opts)
            map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", map_opts)
            map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", map_opts)
            map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", map_opts)
            map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", map_opts)
            map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", map_opts)
            map("n", "<A-0>", "<Cmd>BufferLast<CR>", map_opts)
            -- Pin/unpin buffer
            map("n", "<A-p>", "<Cmd>BufferPin<CR>", map_opts)
            -- Close buffer
            map("n", "<A-c>", "<Cmd>BufferClose<CR>", map_opts)
            -- Magic buffer-picking mode
            map("n", "<C-p>", "<Cmd>BufferPick<CR>", map_opts)
            -- Sort automatically by...
            map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", map_opts)
            map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', map_opts)
            map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", map_opts)
            map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", map_opts)
            map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", map_opts)
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                disabled_filetypes = { "NvimTree" },
            },
        }
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = { current_line_blame = true }
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            indent = { enabled = true },
            notifier = { enabled = true },
            statuscolumn = { enabled = true },
        },
        keys = {
            { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
        }
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
            {
                "<Leader>xx",
                "<Cmd>Trouble diagnostics toggle<CR>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<Leader>xX",
                "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<Leader>cs",
                "<Cmd>Trouble symbols toggle focus=false<CR>",
                desc = "Symbols (Trouble)",
            },
            {
                "<Leader>cl",
                "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<Leader>xL",
                "<Cmd>Trouble loclist toggle<CR>",
                desc = "Location List (Trouble)",
            },
            {
                "<Leader>xQ",
                "<Cmd>Trouble qflist toggle<CR>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
}
