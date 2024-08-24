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
            --local ts_conds = require("nvim-autopairs.ts-conds")

            npairs.setup(opts)
            npairs.add_rules({
                rule("$", "$", { "tex", "latex" })
                -- add a pair if it's not already in an inline_formula (example 2)
                -- TODO: need latex treesitter parser for this one to work
                --:with_pair(ts_conds.is_not_ts_node({ "inline_formula" }))
                -- move right when repeating $
                    :with_move(cond.done())
                -- disable adding a newline when you press <cr>
                    :with_cr(cond.none()),
            })
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        lazy = false,
        opts = {},
    },
    {
        "lervag/vimtex",
        lazy = false, -- vimtex shouldn't be lazy-loaded
    },
}
