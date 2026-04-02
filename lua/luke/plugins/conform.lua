return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  config = function()
    require('conform').setup {
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
        if bufname:match '/node_modules/' then
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
    }
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
