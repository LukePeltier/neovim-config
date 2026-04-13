-- Treesitter
require('luke.treesitter').setup({
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
})

-- Treesitter textobjects
local TS = require('nvim-treesitter-textobjects')
if TS.setup then
  TS.setup({})
end

local moves = {
  goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
  goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
  goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
  goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
}
for method, keymaps in pairs(moves) do
  for key, query in pairs(keymaps) do
    local desc = query:gsub('@', ''):gsub('%..*', '')
    desc = desc:sub(1, 1):upper() .. desc:sub(2)
    desc = (key:sub(1, 1) == '[' and 'Prev ' or 'Next ') .. desc
    desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and ' End' or ' Start')
    vim.keymap.set({ 'n', 'x', 'o' }, key, function()
      if vim.wo.diff and key:find('[cC]') then
        return vim.cmd('normal! ' .. key)
      end
      require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
    end, { desc = desc, silent = true })
  end
end

-- Treesitter context (sticky header showing current function/class)
-- No setup needed, works out of the box
