return {
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {},
    dependencies = {
      'mason-org/mason.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'neovim/nvim-lspconfig',
      'stevearc/conform.nvim',
      'b0o/SchemaStore.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'stylua', -- Used to format lua code
          'basedpyright',
          'bash-language-server',
          'beautysh',
          'clang-format',
          'clangd',
          'cmake-language-server',
          'codespell',
          'css-lsp',
          'editorconfig-checker',
          'eslint-lsp',
          'gopls',
          'jdtls',
          'jq',
          'json-lsp',
          'lua-language-server',
          'marksman',
          'perlnavigator',
          'phpactor',
          'phpcs',
          'phpstan',
          'prettierd',
          'ruff',
          'rust-analyzer',
          'sql-formatter',
          'svelte-language-server',
          'tailwindcss-language-server',
          'typescript-language-server',
          'zls',
        },
      }
      require('mason-lspconfig').setup {}
      -- Disable certain capabilities for specific servers
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client.name == 'ruff' then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end,
        desc = 'LSP: Disable hover capability from Ruff',
      })
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local builtin = require 'telescope.builtin'

          vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
          vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = 0 })
          vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = 0 })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })

          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set('n', '<space>wd', builtin.lsp_document_symbols, { buffer = 0 })
          vim.keymap.set('n', '<space>ww', function()
            builtin.diagnostics { root_dir = true }
          end, { buffer = 0 })
        end,
      })

      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })
      vim.lsp.config('phpactor', {
        on_attach = on_attach,
        init_options = {
          ['language_server_phpstan.enabled'] = false,
          ['language_server_psalm.enabled'] = false,
          ['php_code_sniffer.enabled'] = false,
        },
      })

      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              allFeatures = true,
              command = 'clippy',
            },
            diagnostics = {
              enable = true,
            },
          },
        },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              telemetry = { enable = false },
              library = {
                '${3rd}/love2d/library',
              },
            },
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })

      vim.lsp.config('svelte', {
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd('BufWritePost', {
            pattern = { '*.js', '*.ts' },
            group = vim.api.nvim_create_augroup('svelte_ondidchangetsorjsfile', { clear = true }),
            callback = function(ctx)
              client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
            end,
          })
        end,
      })

      vim.lsp.config('jsonls', {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config('basedpyright', {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
          },
        },
      })

      require 'custom.conform'
    end,
  },
}
