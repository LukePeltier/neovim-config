-- Fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = 'Git blame' })
vim.keymap.set('n', '<leader>gl', '<cmd>Git log --oneline<CR>', { desc = 'Git log' })
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gP', '<cmd>Git pull<CR>', { desc = 'Git pull' })

-- Gitsigns
require('gitsigns').setup({
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '' },
    topdelete = { text = '' },
    changedelete = { text = '▎' },
    untracked = { text = '▎' },
  },
  signs_staged = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '' },
    topdelete = { text = '' },
    changedelete = { text = '▎' },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 250,
    ignore_whitespace = true,
    extra_opts = {
      '--follow',
    },
  },
})
