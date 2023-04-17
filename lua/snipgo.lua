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
        i(1, "funcName"),
        t({ " ()" }),
        i(0),
        t({ "{", "" }),
        i(2, "writeProcess"),
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
    s("for", {
        t({ "for " }),
        i(1, "i:=0; i< N; i++"),
        t({ "{", "" }),
        i(0, "process"),
        t({ "", "}" }),
    }),
    s("range", {
        t({ "for " }),
        t({ "i := range " }),
        i(1, "obj"),
        t({ "{", "" }),
        i(0, "process"),
        t({ "", "}" }),
    }),
})

require("luasnip.loaders.from_lua").lazy_load({ include = { "go" } })
