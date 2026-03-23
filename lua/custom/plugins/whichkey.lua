return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
  config = function() -- This is the function that runs, AFTER loading
    local wk = require 'which-key'
    wk.setup()

    -- Document existing key chains
    wk.add {
      { '<leader>a', group = '[A]dd (Harpoon)' },
      { '<leader>c', group = '[C]ode' },
      { '<leader>g', group = '[G]it' },
      { '<leader>o', group = '[O]pencode' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>S', group = '[S]essions' },
      { '<leader>u', group = '[U]tilities' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>9', group = '[9]9' },
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
