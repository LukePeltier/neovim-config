-- Trouble
require('trouble').setup({
  modes = {
    lsp = {
      win = { position = 'right' },
    },
  },
})
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Document Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ... (Trouble)' })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })

-- Todo comments
require('todo-comments').setup({ signs = false })

-- Cloak
require('cloak').setup({
  enabled = true,
  cloak_character = '*',
  highlight_group = 'Comment',
  cloak_telescope = true,
  patterns = {
    {
      file_pattern = '.env*',
      cloak_pattern = '=.+',
      replace = nil,
    },
    {
      file_pattern = {
        'opencode.jsonc',
      },
      cloak_pattern = {
        { '(TOKEN": ).+', replace = '%1' },
      },
    },
  },
})

-- Dadbod
vim.g.db_ui_use_nerd_fonts = 1

-- 99
local nn = require('99')
nn.setup({
  tmp_dir = './.99',
  md_files = { 'AGENT.md' },
  completion = {
    source = 'cmp',
    custom_rules = { '~/.config/99/skills' },
  },
})
vim.keymap.set('v', '<leader>9v', nn.visual, { desc = '99: Transform selection' })
vim.keymap.set('n', '<leader>9s', nn.search, { desc = '99: Search' })
vim.keymap.set('n', '<leader>9x', nn.stop_all_requests, { desc = '99: Stop all requests' })
vim.keymap.set('n', '<leader>9i', nn.info, { desc = '99: Show info' })
vim.keymap.set('n', '<leader>9l', nn.view_logs, { desc = '99: View logs' })

-- Persistence
local persistence = require('persistence')
persistence.setup({})
vim.keymap.set('n', '<leader>Ss', function() persistence.load() end, { desc = 'Load session for current dir' })
vim.keymap.set('n', '<leader>SS', function() persistence.select() end, { desc = 'Select session' })
vim.keymap.set('n', '<leader>Sl', function() persistence.load({ last = true }) end, { desc = 'Load previous session' })
vim.keymap.set('n', '<leader>Sd', function() persistence.stop() end, { desc = 'Stop session' })

-- Render markdown
require('render-markdown').setup({
  render_modes = true,
  sign = {
    enabled = false,
  },
})
