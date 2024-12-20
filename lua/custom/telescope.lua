local data = assert(vim.fn.stdpath 'data') --[[@as string]]

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      'bower_components',
      'static/plugins',
      '.git',
    },
    prompt_prefix = '   ',
    selection_caret = ' ',
    entry_prefix = ' ',
    sorting_strategy = 'descending',
    layout_config = {
      horizontal = {
        prompt_position = 'bottom',
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ['q'] = require('telescope.actions').close },
    },
  },
  extensions = {
    fzf = {},
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}

-- Enable telescope extensions, if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sp', function()
  return builtin.git_files { cwd = vim.fn.expand '%:h' }
end, { desc = '[S]earch [P]roject Files' })
vim.keymap.set('n', '<leader>sa', function()
  builtin.find_files { hidden = true, no_ignore = true }
end, { desc = '[S]earch [A]ll files' })
vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch select [T]elescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

-- Shortcut for searching your neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
