local ls = require("luasnip")
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d
local common = {
    s("main", {
        t({ "#include<stdio.h>" }),
        t({ "", "int main(){", "" }),
        i(0, "write func"),
        t({ "", "retun 0;" }),
        t({ "", "}" }),
    }),
    s("func", {
        t({ "", "void " }),
        i(1, "func name"),
        t({ " ()" }),
        i(0),
        t({ "{", "" }),
        i(2, "write process"),
        t({ "", "}" }),
    }),
    s("for", {
        t({ "for(int i = 0; i< 0; i++){", "" }),
        i(1, "process"),
        t({ "", "}" }),
    }),
}
ls.add_snippets("c", common)
ls.add_snippets("cpp", common)

require("luasnip.loaders.from_lua").lazy_load({ include = { "c", "cpp" } })
