-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = vim.api.nvim_create_augroup('Luke', {}),
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})
local persistenceGroup = vim.api.nvim_create_augroup('Persistence', { clear = true })
local home = vim.fn.expand '~'
local disabled_dirs = {
  home,
  home .. '/Downloads',
  '/private/tmp',
}

-- disable persistence for certain directories
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  group = persistenceGroup,
  callback = function()
    local cwd = vim.fn.getcwd()
    for _, path in pairs(disabled_dirs) do
      if path == cwd then
        require('persistence').stop()
        return
      end
    end
    if vim.fn.argc() == 0 then
      require('persistence').load()
    else
      require('persistence').stop()
    end
  end,
  nested = true,
})

-- Add this to your Neovim config
vim.api.nvim_create_user_command('ToggleAutoformat', function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    print 'Autoformat enabled for current buffer'
  else
    vim.g.disable_autoformat = true
    print 'Autoformat disabled for current buffer'
  end
end, {})
