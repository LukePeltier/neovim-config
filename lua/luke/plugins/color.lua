return {
  { -- You can easily change to a different colorscheme.
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      transparent = true,
    },
    config = function(opts)
      require('tokyonight').setup { opts }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  {
    'xiyaowong/transparent.nvim',
  },
  -- {
  --   'sainnhe/gruvbox-material',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.gruvbox_material_enable_italic = true
  --     vim.cmd.colorscheme 'gruvbox-material'
  --   end,
  -- },
}
