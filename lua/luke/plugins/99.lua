return {
  'ThePrimeagen/99',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    local nn = require '99'
    nn.setup {
      tmp_dir = './.99',
      md_files = { 'AGENT.md' },
      completion = {
        source = 'cmp',
        custom_rules = { '~/.config/99/skills' },
      },
    }

    -- Visual selection transforms
    vim.keymap.set('v', '<leader>9v', nn.visual, { desc = '99: Transform selection' })

    vim.keymap.set('n', '<leader>9s', nn.search, { desc = '99: Search' })

    -- Utilities
    vim.keymap.set('n', '<leader>9x', nn.stop_all_requests, { desc = '99: Stop all requests' })
    vim.keymap.set('n', '<leader>9i', nn.info, { desc = '99: Show info' })
    vim.keymap.set('n', '<leader>9l', nn.view_logs, { desc = '99: View logs' })
  end,
}
