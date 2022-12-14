local ls = require("luasnip")
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

ls.add_snippets("go", {
    s("main", {
        t({ "package main" }),
        t({ "", "func main(){", "" }),
        i(0, "write func"),
        t({ "", "}" }),
    }),
    s("func", {
        t({ "", "func " }),
        i(1, "func name"),
        t({ " ()" }),
        i(0),
        t({ "{", "" }),
        i(2, "write process"),
        t({ "", "}" }),
    }),
    s("test", {
        t({ "package " }),
        i(1, "pkgname"),
        t({ "", 'import "testing"', "" }),
        t({ "", "func " }),
        i(2, "TestName"),
        t({ "(t *testing.T){", "" }),
        t({ "    t.Fail()" }),
        t({ "", "}" }),
    }),
})

require("luasnip.loaders.from_lua").lazy_load({ include = { "go" } })
