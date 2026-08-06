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
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            -- Disable netrw (recommended for nvim-tree and barbar). See :h nvim-tree-netrw for details.
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- Set termguicolors to enable highlight groups (for nvim-tree)
            vim.opt.termguicolors = true
        end,
        opts = {
            sort = { sorter = "case_sensitive" },
            view = {
                side = "right",
                width = { max = 100 }
            },
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
        "rmagatti/auto-session",
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
            { "<Leader>wr", "<Cmd>AutoSession search<CR>", desc = "Session search (auto-session)" },
            { "<Leader>ws", "<Cmd>AutoSession save<CR>",   desc = "Save session (auto-session)" },
            { "<Leader>wd", "<Cmd>AutoSession delete<CR>", desc = "Delete session (auto-session)" },
            { "<Leader>wa", "<Cmd>AutoSession toggle<CR>", desc = "Toggle autosave (auto-session)" },
        },
    },

    {
        "folke/trouble.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            -- Disable diagnostic virtual text (in favour of trouble.nvim)
            vim.diagnostic.config({ virtual_text = false })
        end,
        opts = {
            modes = { symbols = { win = { position = "left" } } },
        },
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

    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- icon support
        opts = {
            "borderless-full",
            fzf_colors = true, -- automatically generate colour scheme from nvim colour scheme
        },
        keys = {
            {
                "<D-F>",
                function()
                    require("fzf-lua").live_grep({ prompt = '» ', resume = true, git_icons = true })
                end,
                desc = "Find in files (fzf)"
            },
            {
                "<D-O>",
                function()
                    require("fzf-lua").files({ resume = true, git_icons = true })
                end,
                desc = "Find files by name (fzf)"
            },
            {
                "<D-e>",
                function()
                    require("fzf-lua").oldfiles({ prompt = "» ", cwd_only = true, include_current_session = true })
                end,
                desc = "Recent files (fzf)"
            }
        }
    },
}
