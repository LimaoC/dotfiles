-- Disable netrw (recommended for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Decide how to open nvim tree depending on whether we're opening a directory or a file
-- REF: https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
local function open_nvim_tree(data)
    if (vim.fn.filereadable(data.file) == 1  -- buffer is a real file on the disk
        or data.file == "" and vim.bo[data.buf].buftype == ""  -- buffer is a [No Name]
    ) then
        -- open the tree, find the file but don't focus it
        require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
    else
        -- "NvimTree_1" gets appended to the filepath, so remove it to get the actual path
        file_path = string.match(data.file, "^(.*)/")
        if vim.fn.isdirectory(file_path) == 1 then  -- buffer is a directory
            -- change to the directory
            vim.cmd.cd(file_path)
            -- open the tree, without focusing it
            require("nvim-tree.api").tree.open()
        else
            return
        end
    end
end

-- Decide behaviour for auto-closing nvim-tree.
-- REF: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
local function tab_win_closed(winnr)
    local api = require("nvim-tree.api")
    local tabnr = vim.api.nvim_win_get_tabpage(winnr)
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local buf_info = vim.fn.getbufinfo(bufnr)[1]
    local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
    local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
    if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
        -- Close all nvim tree on :q
        if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
            api.tree.close()
        end
    else                                                      -- else closed buffer was normal buffer
        if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
            local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
            if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
                vim.schedule(function ()
                    if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
                        vim.cmd("quit")                                       -- then close all of vim
                    else                                                  -- else there are more tabs open
                        vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
                    end
                end)
            end
        end
    end
end
vim.api.nvim_create_autocmd("WinClosed", {
    callback = function ()
        local winnr = tonumber(vim.fn.expand("<amatch>"))
        vim.schedule_wrap(tab_win_closed(winnr))
    end,
    nested = true
})
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- barbar mappings
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
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        version = '^1.0.0', -- (optional) only update when a new 1.x version is released
    },
    {
        'nvim-lualine/lualine.nvim',
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
