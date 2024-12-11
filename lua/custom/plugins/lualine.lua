return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/noice.nvim' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = {
        {
          require('noice').api.status.message.get,
          cond = require('noice').api.status.message.has,
        },
        {
          require('noice').api.status.command.get,
          cond = require('noice').api.status.command.has,
        },
        {
          require('noice').api.status.mode.get,
          cond = require('noice').api.status.mode.has,
        },
        {
          require('noice').api.status.search.get,
          cond = require('noice').api.status.search.has,
        },
      },
      lualine_y = { 'encoding', 'fileformat', 'filetype' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
}
