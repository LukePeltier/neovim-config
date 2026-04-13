-- Devicons
require('nvim-web-devicons').setup()

-- Noice (set up before lualine since lualine references noice.api)
require('noice').setup({
  lsp = {
    progress = {
      enable = false,
    },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
})

-- Lualine
require('lualine').setup({
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
        require('noice').api.status.command.get,
        cond = require('noice').api.status.command.has,
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
})

-- Snacks
require('snacks').setup({
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
})

vim.keymap.set('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
vim.keymap.set('n', '<leader>uh', function() Snacks.notifier.show_history() end, { desc = 'Show Notification History' })
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
vim.keymap.set('n', '<leader>cR', function() Snacks.rename() end, { desc = 'Rename File' })
vim.keymap.set('n', '<c-/>', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
vim.keymap.set('n', '<c-_>', function() Snacks.terminal() end, { desc = 'which_key_ignore' })
vim.keymap.set('n', ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
vim.keymap.set('n', '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })
vim.keymap.set('n', '<leader>N', function()
  Snacks.win({
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
  })
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
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = {
  '                                                     ',
  '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                                     ',
}
dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', '<cmd>ene<CR>'),
  dashboard.button('SPC s f', '󰈞  Find file'),
  dashboard.button('SPC s g', '󰊄  Live grep'),
  dashboard.button('SPC S s', '  Load session'),
  dashboard.button('SPC S S', '  List sessions'),
  dashboard.button('c', '  Configuration', '<cmd>cd ~/.config/nvim/ <CR>'),
  dashboard.button('u', '  Update plugins', '<cmd>lua vim.pack.update()<CR>'),
  dashboard.button('q', '󰅚  Quit', '<cmd>qa<CR>'),
}
require('alpha').setup(dashboard.config)

-- Which-key
local wk = require('which-key')
wk.setup()
wk.add({
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
})
