return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown', 'codecompanion' },
  opts = {
    render_modes = true,
    sign = {
      enabled = false,
    },
  },
}
