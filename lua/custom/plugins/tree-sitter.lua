return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'diff' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = {
          enable = true,
        },
      }
    end,
  },

  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/nvim-treesitter-textobjects',
}
