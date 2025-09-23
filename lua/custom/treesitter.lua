local M = {}

function M.setup(opts)
  local TS = require 'nvim-treesitter'

  local ts_util = require 'custom.util.treesitter'

  -- some quick sanity checks
  if not TS.get_installed then
    return vim.notify('Please use `:Lazy` and update `nvim-treesitter`', vim.log.levels.ERROR)
  elseif type(opts.ensure_installed) ~= 'table' then
    return vim.notify('`nvim-treesitter` opts.ensure_installed must be a table', vim.log.levels.ERROR)
  end

  -- setup treesitter
  TS.setup(opts)
  ts_util.get_installed(true) -- initialize the installed langs

  -- install missing parsers
  local install = vim.tbl_filter(function(lang)
    return not ts_util.have(lang)
  end, opts.ensure_installed or {})
  if #install > 0 then
    ts_util.ensure_treesitter_cli(function()
      TS.install(install, { summary = true }):await(function()
        ts_util.get_installed(true) -- refresh the installed langs
      end)
    end)
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('lazyvim_treesitter', { clear = true }),
    callback = function(ev)
      if not ts_util.have(ev.match) then
        return
      end

      -- highlighting
      if vim.tbl_get(opts, 'highlight', 'enable') ~= false then
        pcall(vim.treesitter.start)
      end
    end,
  })
end

return M
