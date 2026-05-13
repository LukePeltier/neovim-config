-- Mini plugins
require('mini.ai').setup({ n_lines = 500 })
require('mini.splitjoin').setup()
require('mini.align').setup()
require('mini.surround').setup({
  mappings = {
    add = 'gsa',
    delete = 'gsd',
    find = 'gsf',
    find_left = 'gsF',
    highlight = 'gsh',
    replace = 'gsr',
    update_n_lines = 'gsn',
  },
})
require('mini.bracketed').setup({
  undo = { suffix = '' },
})

-- Autopairs
require('nvim-autopairs').setup({
  ignored_next_char = '[%w%.]',
})

-- Conform (formatting)
require('conform').setup({
  notify_on_error = true,
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    sh = { 'beautysh' },
    sql = { 'sleek' },
    mysql = { 'sleek' },
    nix = { 'alejandra' },
    ocaml = { 'ocamlformat' },
    cpp = { 'clang-format' },
    c = { 'clang-format' },
  },
  default_format_opts = {
    lsp_format = 'fallback',
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match('/node_modules/') then
      return
    end
    return { timeout_ms = 500, lsp_format = 'fallback' }
  end,
  formatters = {
    sleek = {
      command = 'sleek',
      stdin = true,
    },
    alejandra = {
      command = 'alejandra',
      stdin = true,
    },
  },
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Lint
local lint = require('lint')
lint.linters_by_ft = {
  editorconfig = { 'editorconfig-checker' },
  php = { 'phpcs', 'phpstan' },
}
local phpcs = lint.linters.phpcs
phpcs.args = {
  '--standard=./CafeStandards.xml',
  '-q',
  '--report=json',
  '-',
}
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})

-- ts-autotag
require('nvim-ts-autotag').setup({})

-- ts-comments
require('ts-comments').setup({})

-- Highlight colors
vim.opt.termguicolors = true
require('nvim-highlight-colors').setup({})
