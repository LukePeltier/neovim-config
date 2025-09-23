return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    version = false,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        event = 'VeryLazy',
        opts = {},
        keys = function()
          local moves = {
            goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
            goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
            goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
            goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
          }
          local ret = {}
          for method, keymaps in pairs(moves) do
            for key, query in pairs(keymaps) do
              local desc = query:gsub('@', ''):gsub('%..*', '')
              desc = desc:sub(1, 1):upper() .. desc:sub(2)
              desc = (key:sub(1, 1) == '[' and 'Prev ' or 'Next ') .. desc
              desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and ' End' or ' Start')
              ret[#ret + 1] = {
                key,
                function()
                  -- don't use treesitter if in diff mode and the key is one of the c/C keys
                  if vim.wo.diff and key:find '[cC]' then
                    return vim.cmd('normal! ' .. key)
                  end
                  require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
                end,
                desc = desc,
                mode = { 'n', 'x', 'o' },
                silent = true,
              }
            end
          end
          return ret
        end,
        config = function(_, opts)
          local TS = require 'nvim-treesitter-textobjects'
          if not TS.setup then
            vim.notify('Please use `:Lazy` and update `nvim-treesitter`', vim.log.levels.ERROR)
            return
          end
          TS.setup(opts)
        end,
      },
    },
    build = function()
      local TS = require 'nvim-treesitter'
      if not TS.get_installed then
        vim.notify('Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.', vim.log.levels.ERROR)
        return
      end
      if vim.fn.executable 'tree-sitter' == 1 then
        TS.update(nil, { summary = true })
      end
    end,
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
    opts_extend = { 'ensure_installed' },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    opts = {
      -- LazyVim config for treesitter
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = true },
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'printf',
        'python',
        'query',
        'regex',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
    },
    config = function(_, opts)
      return require('custom.treesitter').setup(opts)
    end,
  },
}
