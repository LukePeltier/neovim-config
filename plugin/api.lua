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

vim.api.nvim_create_user_command('ToggleAutoformat', function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    print 'Autoformat enabled for current buffer'
  else
    vim.g.disable_autoformat = true
    print 'Autoformat disabled for current buffer'
  end
end, {})

vim.api.nvim_create_user_command('DeeBeeOpen', function()
  require('dbee').open()
end, {})

vim.api.nvim_create_autocmd('User', {
  pattern = 'CodeCompanionRequestStarted', -- or 'CodeCompanionRequestStarted'
  group = vim.api.nvim_create_augroup('CodeCompanionHooks', {}),
  callback = function(request)
    -- Check if the adapter.name in the pattern payload matches "azure_openai"
    if request.data.adapter.name == 'azure_openai' then
      vim.fn.system '/home/luke/.local/bin/logai.sh'
      vim.notify 'Azure endpoint request triggered'
    end
  end,
})
