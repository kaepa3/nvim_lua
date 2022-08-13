local ls = require 'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

ls.add_snippets("html", {
    s("mm", {
        t({"<!DOCTYPE html>", 
        "<html rang='ja'>",
        "  <head>",
        "    <meta charset='UTF_8'>",
        "    <title>"}), i(1),
        t({"</title>",
        "  </head>",
        "  <body>"}),i(0),
        t({"","  </body>", "</html"}),
    })
})

require("luasnip.loaders.from_lua").lazy_load({ include = { "html" } })
