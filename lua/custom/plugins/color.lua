function ColorMyPencils(color)
  color = color or 'catppuccin'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end
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
      default_integrations = true,
      integrations = {
        alpha = true,
        diffview = true,
        fidget = true,
        harpoon = true,
        cmp = true,
        mason = true,
        noice = true,
        gitsigns = true,
        treesitter = true,
        telescope = {
          enabled = true,
        },
        which_key = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        flash = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    }
    vim.cmd.colorscheme 'catppuccin'
    ColorMyPencils()
  end,
}
