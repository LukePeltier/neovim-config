-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

luasnip.setup {
  update_events = { 'TextChanged', 'TextChangedI' },
}

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup {
  formatting = {
    expandable_indicator = true,
    fields = { 'abbr', 'kind', 'menu' },
    format = lspkind.cmp_format {
      mode = 'symbol',
      maxwidth = 50,
      ellipsis_char = '...',
      show_labelDetails = true,
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    ['<C-y>'] = cmp.mapping.confirm { cmp.ConfirmBehavior.Insert, select = true },

    ['<C-Space>'] = cmp.mapping.complete {},

    ['<C-s>.'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-s>,'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
}

cmp.setup.filetype({ 'sql', 'mysql' }, {
  sources = {
    { name = 'vim-dadbod-completion' },
    { name = 'buffer' },
  },
})
