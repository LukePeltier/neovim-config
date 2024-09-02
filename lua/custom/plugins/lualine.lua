return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'catppuccin',
      },
      sections = {
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {
          function()
            return require('auto-session.lib').current_session_name(true)
          end,
        },
      },
    }
  end,
}
