local ls = require 'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

ls.add_snippets("all", {
    s("fn", {
        i(0),
        t({ "Sample Text!" }),
        i(1),
    }),
    s(
        { trig = "arg", regTrig = true },
        {
            f(function(args)
                return { "Still only counts as text!!" .. string.format("%s", type(args)) }
            end, {}),
            i(0),
            t({ "Sample Text!" }),
            i(1),
        }
    ),
    s({ trig = 'isel2' }, {
        i(1, { "hoge", "fuga" }), i(0),
    }),
    s({ trig = 'b(%d)', regTrig = true, wordTrig = true }, {
        f(function(_,snip)
            return {
                "Captured Text: " .. snip.captures[1] .. '.'
            }
        end, {}),
        i(0)
    }),
})

require("luasnip.loaders.from_lua").lazy_load({ include = { "all" } })
