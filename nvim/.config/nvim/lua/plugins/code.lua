return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function(_, opts)
            -- Add $$ as a pair for nvim-autopairs
            -- REF: https://github.com/windwp/nvim-autopairs/issues/320
            local npairs = require("nvim-autopairs")
            local rule = require("nvim-autopairs.rule")
            local cond = require("nvim-autopairs.conds")

            npairs.setup(opts)
            npairs.add_rules({
                rule("$", "$", { "tex", "latex" })
                -- move right when repeating $
                    :with_move(cond.done())
                -- disable adding a newline when you press <cr>
                    :with_cr(cond.none()),
            })
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- latest stable release
        event = "InsertEnter",
        opts = {},
    },
    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python",
        config = function() end,
    },
    {
        "lervag/vimtex",
        version = "*", -- latest stable release
        lazy = false,  -- vimtex shouldn't be lazy-loaded
    },
}
