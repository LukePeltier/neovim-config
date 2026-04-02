return {
  'coder/claudecode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  event = 'VeryLazy',
  opts = {
    terminal = {
      provider = 'none',
    },
  },
  config = true,
  keys = {
    { '<leader>lb', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
    { '<leader>ls', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
    {
      '<leader>ls',
      '<cmd>ClaudeCodeTreeAdd<cr>',
      desc = 'Add file',
      ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
    },
    -- Diff management
    { '<leader>la', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
    { '<leader>ld', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
  },
}
