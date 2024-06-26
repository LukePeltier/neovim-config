return {
  'mfussenegger/nvim-lint',
  event = 'BufReadPre',
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      editorconfig = { 'editorconfig-checker' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
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
        lint.try_lint 'codespell'
      end,
    })
  end,
}
