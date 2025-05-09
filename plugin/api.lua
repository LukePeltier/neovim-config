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
-- local persistenceGroup = vim.api.nvim_create_augroup('Persistence', { clear = true })
-- local home = vim.fn.expand '~'
-- local disabled_dirs = {
--   home,
--   home .. '/Downloads',
--   '/private/tmp',
-- }

-- -- disable persistence for certain directories
-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
--   group = persistenceGroup,
--   callback = function()
--     local cwd = vim.fn.getcwd()
--     for _, path in pairs(disabled_dirs) do
--       if path == cwd then
--         require('persistence').stop()
--         return
--       end
--     end
--     if vim.fn.argc() == 0 then
--       require('persistence').load()
--     else
--       require('persistence').stop()
--     end
--   end,
--   nested = true,
-- })

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

vim.api.nvim_create_user_command('DeeBeeOpen', function()
  require('dbee').open()
end, {})

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('avante.providers').azure.parse_api_key = function()
      return vim.env.AZURE_OPENAI_API_KEY
    end
  end,
})

-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'AvanteInputSubmitted',
--   callback = function(event)
--     vim.notify('AvanteInputSubmitted triggered with data: ' .. vim.inspect(event.data or {}))
--     vim.notify 'Starting logai.sh job...'
--     local job_id = vim.fn.jobstart('/home/luke/.local/bin/logai.sh', {
--       on_exit = function(_, exit_code, _)
--         vim.schedule(function()
--           vim.notify('logai.sh exit code: ' .. exit_code)
--         end)
--       end,
--     })
--     vim.notify('Job started with ID: ' .. job_id)
--   end,
-- })

-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'AvanteInputSubmitted',
--   callback = function()
--     vim.notify 'Starting logai.sh job...'
--     local job_id = vim.fn.jobstart('/home/luke/.local/bin/logai.sh', {
--       on_exit = function(_, exit_code, _)
--         vim.schedule(function()
--           if exit_code == 0 then
--             vim.notify 'logai.sh completed successfully'
--           else
--             vim.notify('logai.sh failed with exit code ' .. exit_code, vim.log.levels.ERROR)
--           end
--         end)
--       end,
--       on_stderr = function(_, data, _)
--         if data then
--           vim.schedule(function()
--             vim.notify('logai.sh stderr: ' .. table.concat(data, '\n'), vim.log.levels.WARN)
--           end)
--         end
--       end,
--     })
--   end,
-- })
--

-- Add this to your init.lua
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.defer_fn(function()
      local Llm = require 'avante.llm'
      if not Llm or not Llm.stream then
        vim.notify('Could not find avante.llm.stream function', vim.log.levels.ERROR)
        return
      end

      -- Check if logai.sh exists
      local logai_path = '/home/luke/.local/bin/logai.sh'
      local uv = vim.uv
      if not uv.fs_stat(logai_path) then
        vim.notify('logai.sh not found, skipping avante.nvim API hook installation', vim.log.levels.WARN)
        return
      end

      -- Store original function
      local original_stream = Llm.stream

      -- Replace with our wrapped version
      Llm.stream = function(opts)
        vim.notify 'Intercepted avante.nvim API request'

        -- Run your script
        vim.fn.jobstart(logai_path, {
          stdin = nil,
          detach = true,
          pty = false,
        })

        -- Call original function
        return original_stream(opts)
      end

      -- vim.notify 'Successfully installed avante.nvim API hook'
    end, 1000) -- Wait 1 second for everything to load
  end,
})
