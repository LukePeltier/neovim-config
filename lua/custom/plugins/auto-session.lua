return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Downloads', '/' },
    }
    require('lualine').setup {
      sections = { lualine_x = { require('auto-session.lib').current_session_name } },
    }
  end,
}
