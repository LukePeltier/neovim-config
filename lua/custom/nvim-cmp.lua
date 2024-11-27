-- See `:help cmp`
local cmp = require 'cmp'
local ls = require 'luasnip'
local lspkind = require 'lspkind'

vim.snippet.expand = ls.lsp_expand

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
  filter = filter or {}
  filter.direction = filter.direction or 1

  if filter.direction == 1 then
    return ls.expand_or_jumpable()
  else
    return ls.jumpable(filter.direction)
  end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
  if direction == 1 then
    if ls.expandable() then
      return ls.expand_or_jump()
    else
      return ls.jumpable(1) and ls.jump(1)
    end
  else
    return ls.jumpable(-1) and ls.jump(-1)
  end
end

vim.snippet.stop = ls.unlink_current

-- ================================================
--      My Configuration
-- ================================================
ls.config.set_config {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  override_builtin = true,
}

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/custom/snippets/*.lua', true)) do
  loadfile(ft_path)()
end

vim.keymap.set({ 'i', 's' }, '<C-s>;', function()
  return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-s>,', function()
  return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
end, { silent = true })

require('luasnip.loaders.from_vscode').lazy_load()

require('luasnip.loaders.from_snipmate').load()

vim.opt.shortmess:append 'c'
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
      vim.snippet.expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-y>'] = cmp.mapping(cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }, { 'i', 'c' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
}

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'cmdline', option = {
      ignore_cmds = { 'Man', '!' },
    } },
  },
  {
    { name = 'path' },
  },
})

cmp.setup.filetype({ 'sql', 'mysql' }, {
  sources = {
    { name = 'vim-dadbod-completion' },
    { name = 'buffer' },
  },
})
