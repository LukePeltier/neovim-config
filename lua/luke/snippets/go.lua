local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local extras = require 'luasnip.extras'
local rep = extras.rep
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('go', {
  s(
    'field',
    fmt(
      [[
    {} *{} `json:"{},omitempty"`
    ]],
      {
        i(1),
        i(0),
        rep(1),
      }
    )
  ),
})
