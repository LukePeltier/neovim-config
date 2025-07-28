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

-- Automatically remove trailing whitespace on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = vim.api.nvim_create_augroup('Luke', {}),
  pattern = { '*' },
  command = [[%s/\s\+$//e]], -- Executes the substitute command to remove trailing whitespace
})

-- Create a :ToggleAutoformat command to enable/disable automatic formatting
-- This toggles the global variable that controls format-on-save behavior
vim.api.nvim_create_user_command('ToggleAutoformat', function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    print 'Autoformat enabled for current buffer'
  else
    vim.g.disable_autoformat = true
    print 'Autoformat disabled for current buffer'
  end
end, {})

-- Create a :DeeBeeOpen command to open the DBee database UI
-- This is a shorthand for accessing the database explorer
vim.api.nvim_create_user_command('DeeBeeOpen', function()
  require('dbee').open()
end, {})

-- Hook into CodeCompanion AI request events
-- This autocommand triggers when a request to AI services starts
vim.api.nvim_create_autocmd('User', {
  pattern = 'CodeCompanionRequestStarted', -- Event fired when CodeCompanion makes an API request
  group = vim.api.nvim_create_augroup('CodeCompanionHooks', {}),
  callback = function(request)
    -- Check if the adapter.name in the pattern payload matches "azure_openai"
    if request.data.adapter.name == 'azure_openai' then
      vim.fn.system '/home/luke/.local/bin/logai.sh' -- Run logging script for Azure requests
      vim.notify 'Azure endpoint request triggered'
    end
  end,
})
