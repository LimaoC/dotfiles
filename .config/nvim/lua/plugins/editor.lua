-- Disable netrw (recommended for nvim-tree and barbar). See :h nvim-tree-netrw for details.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set termguicolors to enable highlight groups (for nvim-tree)
vim.opt.termguicolors = true

-- Decide how to open nvim tree depending on how we're opening nvim.
-- For files and [No Name] buffers, open the tree, find the file (highlight it in nvim-tree),
--   but don't focus it.
-- For directories, change Neovim's directory to it and open nvim-tree.
-- REF: https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
local function open_nvim_tree(data)
    if (vim.fn.filereadable(data.file) == 1  -- buffer is a real file on the disk
        or (data.file == "" and vim.bo[data.buf].buftype == "")  -- buffer is a [No Name]
    ) then
        -- Open the tree, find the file but don't focus it
        require("nvim-tree.api").tree.toggle({ focus = false, find_file = false, })
    else
        -- Get the path to the file to check if it is a directory.
        -- "NvimTree_1" gets appended to the filepath, so remove it to get the actual path
        local file_path = string.match(data.file, "^(.*)/")
        if vim.fn.isdirectory(file_path) == 1 then  -- buffer is a directory
            -- Change to the directory and open nvim-tree
            vim.cmd.cd(file_path)
            require("nvim-tree.api").tree.open()
        else
            return
        end
    end
end
-- Startup on VimEnter event
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Decide behaviour for auto-closing nvim-tree.
-- Use QuitPre to check if nvim-tree is the last window 
-- REF: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
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
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort = { sorter = "case_sensitive", },
                view = {
                    side = "right",
                    width = 40,
                },
                renderer = { group_empty = true, },
                filters = { dotfiles = true, },
                tab = {
                    sync = {
                        open = true,
                        close = true,
                    },
                },
            })
        end,
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',  -- (optional) for git status
            'nvim-tree/nvim-web-devicons',  -- (optional) for file icons
        },
        config = function()
            require("gitsigns").setup()
            require("barbar").setup({
                sidebar_filetypes = {
                    NvimTree = true,
                }
            })
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }
            -- Move to previous/next
            map('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
            map('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)
            -- Re-order to previous/next
            map('n', '<A-H>', '<Cmd>BufferMovePrevious<CR>', opts)
            map('n', '<A-L>', '<Cmd>BufferMoveNext<CR>', opts)
            -- Goto buffer in position...
            map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
            map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
            map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
            map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
            map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
            map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
            map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
            map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
            map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
            map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
            -- Pin/unpin buffer
            map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
            -- Close buffer
            map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
            -- Magic buffer-picking mode
            map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
            -- Sort automatically by...
            map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
            map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
            map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
            map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
        end,
        opts = {},
        version = '^1.0.0', -- (optional) only update when a new 1.x version is released
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require("lualine").setup({
                options = {
                    disabled_filetypes = { "NvimTree" },
                },
            })
        end,
    },
}
