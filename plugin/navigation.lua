-- Oil
local oil = require('oil')
oil.setup({
  columns = { 'icon' },
  keymaps = {
    ['<C-h>'] = false,
  },
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set('n', '-', function()
  oil.open(vim.fn.expand('%:p:h'))
end, { desc = 'Open parent directory' })

-- Harpoon
local harpoon = require('harpoon')
harpoon:setup()
vim.keymap.set('n', '<leader>ap', function()
  harpoon:list():add()
end, { desc = 'Add to harpoon list' })
vim.keymap.set('n', '<leader>h', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Open harpoon quick menu' })
for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
  vim.keymap.set('n', string.format('<leader>%d', idx), function()
    harpoon:list():select(idx)
  end, { desc = string.format('Harpoon slot %d', idx) })
end

-- Leap
require('leap').opts.preview = function(ch0, ch1, ch2)
  return not (ch1:match('%s') or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a')))
end
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)', { desc = 'Leap' })
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)', { desc = 'Leap from Window' })
vim.keymap.set({ 'n', 'o' }, 'gs', function()
  require('leap.remote').action({
    input = vim.fn.mode(true):match('o') and '' or 'v',
  })
end, { desc = 'Leap Remote' })

-- Vim-tmux-navigator keymaps
vim.keymap.set('n', '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>')
vim.keymap.set('n', '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>')
vim.keymap.set('n', '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>')
vim.keymap.set('n', '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>')
vim.keymap.set('n', '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>')
