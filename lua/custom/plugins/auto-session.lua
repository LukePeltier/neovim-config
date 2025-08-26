return {
  -- {
  --   'rmagatti/auto-session',
  --   lazy = false,
  --   opts = {
  --     suppressed_dirs = { '~/', '~/Downloads', '/' },
  --     bypass_save_filetypes = { 'alpha' }, -- or whatever dashboard you use
  --   },
  --   init = function()
  --     vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
  --   end,
  -- },
  {
    'folke/persistence.nvim',
    lazy = false,
    opts = {},
    config = function(_, opts)
      local persistence = require 'persistence'
      persistence.setup(opts)
      -- load the session for the current directory
      vim.keymap.set('n', '<leader>Ss', function()
        persistence.load()
      end, { desc = 'Load session for current dir' })

      -- select a session to load
      vim.keymap.set('n', '<leader>SS', function()
        persistence.select()
      end, { desc = 'Select session' })

      -- load the last session
      vim.keymap.set('n', '<leader>Sl', function()
        persistence.load { last = true }
      end, { desc = 'Load previous session' })

      -- stop Persistence => session won't be saved on exit
      vim.keymap.set('n', '<leader>Sd', function()
        persistence.stop()
      end, { desc = 'Stop session' })
    end,
  },
}

-- return {}
