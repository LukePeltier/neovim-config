return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require 'custom.tree-sitter'
    end,
  },

  -- { 'nvim-treesitter/nvim-treesitter-context' },
  { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
}

-- return {}
