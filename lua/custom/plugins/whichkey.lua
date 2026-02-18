return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
  config = function() -- This is the function that runs, AFTER loading
    local wk = require 'which-key'
    wk.setup()

    -- Document existing key chainsk
    wk.add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>9', group = '[9]9' },
      { '<leader>w', group = '[W]orkspace' },
      {
        '<leader>b',
        group = '[B]uffers',
        expand = function()
          return require('which-key.extras').expand.buf()
        end,
      },
    }
  end,
}
