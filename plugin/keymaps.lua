vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

vim.keymap.set('i', '<S-Down>', '<Nop>', { noremap = true, silent = true })

vim.keymap.set('n', '<A-j>', function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! ]c]]
  else
    vim.cmd [[m .+1<CR>==]]
  end
end)

vim.keymap.set('n', '<A-k>', function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! [c]]
  else
    vim.cmd [[m .-2<CR>==]]
  end
end)

-- Move to previous/next
-- map('n', '<a-,>', '<cmd>bufferprevious<cr>', opts)
-- map('n', '<a-.>', '<cmd>buffernext<cr>', opts)
-- -- re-order to previous/next
-- map('n', '<a-<>', '<cmd>buffermoveprevious<cr>', opts)
-- map('n', '<a->>', '<cmd>buffermovenext<cr>', opts)
-- -- goto buffer in position...
-- map('n', '<a-1>', '<cmd>buffergoto 1<cr>', opts)
-- map('n', '<a-2>', '<cmd>buffergoto 2<cr>', opts)
-- map('n', '<a-3>', '<cmd>buffergoto 3<cr>', opts)
-- map('n', '<a-4>', '<cmd>buffergoto 4<cr>', opts)
-- map('n', '<a-5>', '<cmd>buffergoto 5<cr>', opts)
-- map('n', '<a-6>', '<cmd>buffergoto 6<cr>', opts)
-- map('n', '<a-7>', '<cmd>buffergoto 7<cr>', opts)
-- map('n', '<a-8>', '<cmd>buffergoto 8<cr>', opts)
-- map('n', '<a-9>', '<cmd>buffergoto 9<cr>', opts)
-- map('n', '<a-0>', '<cmd>bufferlast<cr>', opts)
-- -- pin/unpin buffer
-- map('n', '<a-p>', '<cmd>bufferpin<cr>', opts)
-- -- goto pinned/unpinned buffer
-- --                 :buffergotopinned
-- --                 :buffergotounpinned
-- -- close buffer
-- map('n', '<a-c>', '<cmd>bufferclose<cr>', opts)
-- -- wipeout buffer
-- --                 :bufferwipeout
-- -- close commands
-- --                 :buffercloseallbutcurrent
-- --                 :buffercloseallbutpinned
-- --                 :buffercloseallbutcurrentorpinned
-- --                 :bufferclosebuffersleft
-- --                 :bufferclosebuffersright
-- -- magic buffer-picking mode
-- map('n', '<c-p>', '<cmd>bufferpick<cr>', opts)
-- -- sort automatically by...
-- map('n', '<space>bb', '<cmd>bufferorderbybuffernumber<cr>', opts)
-- map('n', '<space>bn', '<cmd>bufferorderbyname<cr>', opts)
-- map('n', '<space>bd', '<cmd>bufferorderbydirectory<cr>', opts)
-- map('n', '<space>bl', '<cmd>bufferorderbylanguage<cr>', opts)
-- map('n', '<space>bw', '<cmd>bufferorderbywindownumber<cr>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
