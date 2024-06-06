-- return { -- You can easily change to a different colorscheme.
--   'folke/tokyonight.nvim',
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     vim.cmd.colorscheme 'tokyonight-night'
--     require('tokyonight').setup {
--       style = 'night',
--     }
--   end,
-- }
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavor = 'mocha',
      integrations = {
        diffview = true,
        fidget = true,
        harpoon = true,
        cmp = true,
        mason = true,
        noice = true,
        gitsigns = true,
        treesitter = true,
        telescope = true,
        lsp_trouble = true,
        which_key = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    }
    vim.o.termguicolors = true
    vim.cmd.colorscheme 'catppuccin'
  end,
}
