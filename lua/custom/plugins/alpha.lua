return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
  },
  lazy = false,
  config = function()
    local alpha = require 'alpha'
    local theta = require 'alpha.themes.theta'
    local dashboard = require 'alpha.themes.dashboard'
    theta.buttons.val = {
      dashboard.button('e', '  New file', '<cmd>ene<CR>'),
      dashboard.button('SPC s f', '󰈞  Find file'),
      dashboard.button('SPC s g', '󰊄  Live grep'),
      dashboard.button('c', '  Configuration', '<cmd>cd ~/.config/nvim/ <CR>'),
      dashboard.button('u', '  Update plugins', '<cmd>Lazy sync<CR>'),
      dashboard.button('q', '󰅚  Quit', '<cmd>qa<CR>'),
    }
    alpha.setup(theta.config)
  end,
}
