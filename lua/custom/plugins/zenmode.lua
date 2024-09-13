return {
  'folke/zen-mode.nvim',
  opts = {},
  config = function()
    local defaults = {
      plugins = {
        tmux = {
          enabled = true,
        },
      },
    }
    vim.keymap.set('n', '<leader>zz', function()
      require('zen-mode').setup(defaults)
      require('zen-mode').toggle()
      ColorMyPencils()
    end, { desc = 'Toggle zen mode' })
  end,
}
