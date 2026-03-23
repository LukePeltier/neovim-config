return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })
    vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = 'Git blame' })
    vim.keymap.set('n', '<leader>gl', '<cmd>Git log --oneline<CR>', { desc = 'Git log' })
    vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>', { desc = 'Git push' })
    vim.keymap.set('n', '<leader>gP', '<cmd>Git pull<CR>', { desc = 'Git pull' })
  end,
}
