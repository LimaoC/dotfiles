--{{ Diagnostics config

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true
	}
)

local signs = {
    Error = "",
    Warn  = "",
    Hint  = "",
    Info  = ""
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

-- Note: You'll need a 'patched' font to use these custom glyphs/icons. See
-- https://github.com/ryanoasis/nerd-fonts if you're interested. Otherwise,
-- uncomment the below config instead:
-- local signs = {
--     Error = "E",
--     Warn  = "W",
--     Hint  = "H",
--     Info  = "I"
-- }

--}}
--{{ Trouble config
-- https://github.com/folke/trouble.nvim
-- Most of these are defaults

local trouble = require('trouble')
trouble.setup {
    position = "bottom",              -- position of the list can be: bottom, top, left, right
    height = 10,                      -- height of the trouble list when position is top or bottom
    width = 50,                       -- width of the list when position is left or right
    icons = true,                     -- use devicons for filenames
    mode = "workspace_diagnostics",   -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "",                  -- icon used for open folds
    fold_closed = "",                -- icon used for closed folds
    group = true,                     -- group results by file
    padding = false,                  -- add an extra new line on top of the list
    action_keys = {                   -- key mappings for actions in the trouble list
        -- map to {} to remove a mapp ing
        close = "q",                  -- close the list
        cancel = "<esc>",             -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r",                -- manually refresh
        jump = {"<cr>", "<tab>"},     -- jump to the diagnostic or open / close folds
        open_split = "<c-x>",         -- open buffer in new split
        open_vsplit = "<c-v>",        -- open buffer in new vsplit
        open_tab = "<c-t>",           -- open buffer in new tab
        jump_close = "o",             -- jump to the diagnostic and close the list
        toggle_mode = "m",            -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P",         -- toggle auto_preview
        hover = "K",                  -- opens a small popup with the full multiline message
        preview = "p",                -- preview the diagnostic location
        close_folds = {"zM", "zm"},   -- close all folds
        open_folds = {"zR", "zr"},    -- open all folds
        toggle_fold = {"zA", "za"},   -- toggle fold of current file
        previous = "k",               -- previous item
        next = "j"                    -- next item
    },                                
    indent_lines = true,              -- add an indent guide below the fold icons
    auto_open = false,                -- automatically open the list when you have diagnostics
    auto_close = false,               -- automatically close the list when you have no diagnostics
    auto_preview = true,              -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false,                -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"},  -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = signs["Error"],
        warning = signs["Warning"],
        hint = signs["Hint"],
        information = signs["Info"],
        other = "﫠"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

-- Note: Some of the settings above require the use of a patched font. Replace them with these
-- if you'd like to just use a regular font instead:
--     icons = false,
--     fold_open = "v",
--     fold_closed = ">",
--     signs = {
--         error = "error",
--         warning = "warn ",
--         hint = "hint ",
--         information = "info ",
--         other = "other"

-- Trouble keybindings
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})

--}}

