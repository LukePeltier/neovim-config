-- Devicons
require('nvim-web-devicons').setup()

-- Built-in UI2 (messages + cmdline)
require('vim._core.ui2').enable()

-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
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
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = {
      {
        function()
          return 'recording @' .. vim.fn.reg_recording()
        end,
        cond = function()
          return vim.fn.reg_recording() ~= ''
        end,
        color = { fg = '#ff6666' },
      },
    },
    lualine_y = {
      'filetype',
      function()
        if vim.bo.expandtab then
          return 'spaces: ' .. vim.bo.shiftwidth
        else
          return 'tabs: ' .. vim.bo.tabstop
        end
      end,
    },
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
}

-- Snacks
require('snacks').setup {
  bigfile = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  input = {
    enabled = true,
  },
  styles = {
    notification = {
      wo = { wrap = true },
    },
  },
  indent = {
    enabled = true,
  },
}

vim.keymap.set('n', '<leader>un', function()
  Snacks.notifier.hide()
end, { desc = 'Dismiss All Notifications' })
vim.keymap.set('n', '<leader>uh', function()
  Snacks.notifier.show_history()
end, { desc = 'Show Notification History' })
vim.keymap.set('n', '<leader>bd', function()
  Snacks.bufdelete()
end, { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>gB', function()
  Snacks.gitbrowse()
end, { desc = 'Git Browse' })
vim.keymap.set('n', '<leader>cR', function()
  Snacks.rename()
end, { desc = 'Rename File' })
vim.keymap.set('n', '<c-/>', function()
  Snacks.terminal()
end, { desc = 'Toggle Terminal' })
vim.keymap.set('n', '<c-_>', function()
  Snacks.terminal()
end, { desc = 'which_key_ignore' })
vim.keymap.set('n', ']]', function()
  Snacks.words.jump(vim.v.count1)
end, { desc = 'Next Reference' })
vim.keymap.set('n', '[[', function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = 'Prev Reference' })
vim.keymap.set('n', '<leader>N', function()
  Snacks.win {
    file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = 'yes',
      statuscolumn = ' ',
      conceallevel = 3,
    },
  }
end, { desc = 'Neovim News' })

-- Snacks debug helpers
_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end
vim.print = _G.dd

-- Alpha (dashboard)
local dashboard = require 'alpha.themes.dashboard'
dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', '<cmd>ene<CR>'),
  dashboard.button('SPC s f', '󰈞  Find file'),
  dashboard.button('SPC s g', '󰊄  Live grep'),
  dashboard.button('SPC S s', '  Load session'),
  dashboard.button('SPC S S', '  List sessions'),
  dashboard.button('u', '  Update plugins', '<cmd>lua vim.pack.update()<CR>'),
  dashboard.button('q', '󰅚  Quit', '<cmd>qa<CR>'),
}
require('alpha').setup(dashboard.config)

-- Which-key
local wk = require 'which-key'
wk.setup()
wk.add {
  { '<leader>a', group = '[A]dd (Harpoon)' },
  { '<leader>c', group = '[C]ode' },
  { '<leader>g', group = '[G]it' },
  { '<leader>l', group = '[L]LM' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>S', group = '[S]essions' },
  { '<leader>u', group = '[U]tilities' },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>x', group = 'Trouble' },
  { '<leader>9', group = '[9]9' },
  {
    '<leader>b',
    group = '[B]uffers',
    expand = function()
      return require('which-key.extras').expand.buf()
    end,
  },
}
