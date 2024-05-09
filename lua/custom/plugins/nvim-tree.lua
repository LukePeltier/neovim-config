return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('nvim-tree').setup {
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    }
    vim.keymap.set('n', '<leader>pv', vim.cmd.NvimTreeToggle)
  end,
}
