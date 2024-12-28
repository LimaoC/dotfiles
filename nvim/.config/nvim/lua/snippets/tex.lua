-- Inspired by evesdropper's luasnip-latex-snippets.nvim implementation
-- https://github.com/evesdropper/luasnip-latex-snippets.nvim

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local tex_conds = require("snippets.tex_conditions")
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })
local automathsnippet = ls.extend_decorator.apply(autosnippet,
    { condition = tex_conds.in_math, show_condition = tex_conds.in_math })
local autotextsnippet = ls.extend_decorator.apply(autosnippet,
    { condition = tex_conds.in_text, show_condition = tex_conds.in_text })
local line_begin = require("luasnip.extras.conditions.expand").line_begin


-- Snippets

M = {
    ---- Math modes
    autotextsnippet(
        { trig = "mk", name = "$...$", desc = "inline math" },
        fmta([[$<>$<>]], { i(1), i(0) })
    ),
    autotextsnippet(
        { trig = "dm", name = "\\[...\\]", desc = "display math" },
        fmta([[
        \[
        <>
        .\]
        <>]], { i(1), i(0) })),
    ---- Environments
    autosnippet(
        { trig = "beg", name = "begin/end", desc = "begin/end environment (generic)" },
        fmta([[
        \begin{<>}
        <>
        \end{<>}]], { i(1), i(0), rep(1) })
    ),
    ---- Subscripts and superscripts
    -- Replace x_yz| with x_{yz|} and x^yz| with x^{yz|}
    automathsnippet(
        {
            trig = "([%a%d])([_^])([-+%a%d][-+%a%d])",
            name = "sub/superscript",
            desc = "sub/superscript",
            trigEngine = "pattern",
        },
        {
            f(function(_, snip)
                return snip.captures[1] .. snip.captures[2] .. "{" .. snip.captures[3]
            end), i(1), t("}"), i(0)
        }
    ),
    ---- Auto-sized brackets
    automathsnippet(
        { trig = "lr)", name = "lr()", desc = "auto-sized round brackets" },
        fmta([[\left( <> \right)<>]], { i(1), i(0) })
    ),
    automathsnippet(
        { trig = "lr]", name = "lr[]", desc = "auto-sized square brackets" },
        fmta([[\left[ <> \right]<>]], { i(1), i(0) })
    ),
    automathsnippet(
        { trig = "lr}", name = "lr{}", desc = "auto-sized curly brackets" },
        fmta([[\left\{ <> \right\}<>]], { i(1), i(0) })
    ),
    autosnippet(
        { trig = "lr>", name = "auto-sized <>", desc = "auto-sized angled brackets" },
        fmt([[\left\langle () \right\rangle()]], { i(1), i(0) }, { delimiters = "()" }) -- use different delimiter pair for readability
    ),
    automathsnippet(
        { trig = "lr|", name = "auto-sized ||", desc = "auto-sized pipes" },
        fmta([[\left| <> \right|<>]], { i(1), i(0) })
    ),
    ---- Fractions
    -- Replace // with \frac{}{}
    automathsnippet(
        { trig = "//", name = "\\frac{}{}", desc = "fraction" },
        fmta([[\frac{<>}{<>}<>]], { i(1), i(2), i(0) })
    ),
    ---- Maths commands
    -- Replace sumjk with \sum_{}^{}
    automathsnippet(
        { trig = "sumjk", name = "\\sum_{}^{}", desc = "summation" },
        fmta([[\sum_{<>}^{<>}<>]], { i(1), i(2), i(0) })
    ),
    -- Replace sumk with \sum_{}
    automathsnippet(
        { trig = "sumk", name = "\\sum_{}", desc = "summation" },
        fmta([[\sum_{<>}<>]], { i(1), i(0) })
    ),
    -- Replace prodjk with \prod_{}^{}
    automathsnippet(
        { trig = "prodjk", name = "\\prod_{}^{}", desc = "product" },
        fmta([[\prod_{<>}^{<>}<>]], { i(1), i(2), i(0) })
    ),
    -- Replace prodk with \prod_{}
    automathsnippet(
        { trig = "prodk", name = "\\prod_{}", desc = "product" },
        fmta([[\prod_{<>}<>]], { i(1), i(0) })
    ),
    -- Replace bbx with \mathbb{x}
    automathsnippet(
        { trig = "bb(%a)", name = "\\mathbb{}", desc = "mathbb", trigEngine = "pattern" },
        { f(function(_, snip) return "\\mathbb{" .. snip.captures[1] .. "}" end) }
    ),
    -- Replace bfx with \mathbf{x}
    automathsnippet(
        { trig = "bf(%a)", name = "\\mathbf{}", desc = "mathbf", trigEngine = "pattern" },
        { f(function(_, snip) return "\\mathbf{" .. snip.captures[1] .. "}" end) }
    ),
    -- Replace calx with \mathcal{x}
    automathsnippet(
        { trig = "cal(%a)", name = "mathcal", desc = "mathcal", trigEngine = "pattern" },
        { f(function(_, snip) return "\\mathcal{" .. snip.captures[1] .. "}" end) }
    ),
    -- Replace rmx with \mathrm{x}
    automathsnippet(
        { trig = "rm(%a)", name = "mathrm", desc = "mathrm", trigEngine = "pattern" },
        { f(function(_, snip) return "\\mathrm{" .. snip.captures[1] .. "}" end) }
    ),
    -- Replace Var with \mathbb{V}\text{ar}
    automathsnippet(
        { trig = "Var", name = "variance", desc = "variance" },
        { t("\\mathbb{V}\\text{ar}") }
    ),
    -- Replace Cov with \mathbb{C}\text{ov}
    automathsnippet(
        { trig = "Cov", name = "covariance", desc = "covariance" },
        { t("\\mathbb{C}\\text{ov}") }
    ),
}

return M
