local ls = require("luasnip")
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

ls.add_snippets("python", {
    s("main", {
        t({ 'if __name__ == "__main__":' }),
    }),
    s("fn", {
        t({ "def " }),
        i(1, "name"),
        t({ "(" }),
        i(2, "args"),
        t({ "):" }),
    }),
})

require("luasnip.loaders.from_lua").lazy_load({ include = { "python" } })
