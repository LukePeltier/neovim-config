return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    jump = {
      autojump = true,
    },
    modes = {
      char = {
        jump_labels = true,
      },
    },
  },
  keys = {
    {
      '<leader><CR>',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
-- return {}
