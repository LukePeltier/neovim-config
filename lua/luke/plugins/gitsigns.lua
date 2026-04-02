return {
  'lewis6991/gitsigns.nvim',
  branch = 'main',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
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
  },
}
