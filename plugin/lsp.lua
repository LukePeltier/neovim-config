-- Completion: blink.cmp + LuaSnip
-- (Must be set up before LSP so get_lsp_capabilities() works)
require('blink.compat').setup()
require('cmp-dbee').setup()
require('luke.snippets')

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
  },

  cmdline = {
    completion = { menu = { auto_show = true } },
  },

  completion = {
    menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if ctx.item.source_name == 'LSP' then
                local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                if color_item and color_item.abbr ~= '' then
                  icon = color_item.abbr
                end
              end
              return icon .. ctx.icon_gap
            end,
            highlight = function(ctx)
              local highlight = 'BlinkCmpKind' .. ctx.kind
              if ctx.item.source_name == 'LSP' then
                local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                if color_item and color_item.abbr_hl_group then
                  highlight = color_item.abbr_hl_group
                end
              end
              return highlight
            end,
          },
        },
      },
    },
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  snippets = {
    preset = 'luasnip',
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'dadbod', 'deebee' },
    providers = {
      dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
      deebee = {
        name = 'cmp-dbee',
        module = 'blink.compat.source',
      },
    },
  },
  fuzzy = { implementation = 'prefer_rust' },
})

-- LSP: mason + lspconfig
require('mason').setup()
require('mason-tool-installer').setup({
  ensure_installed = {
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
    'stylua',
    'svelte-language-server',
    'tailwindcss-language-server',
    'typescript-language-server',
    'ty',
    'zls',
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end

    local builtin = require('telescope.builtin')

    vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = 0, desc = 'LSP: Go to definition' })
    vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = 0, desc = 'LSP: References' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0, desc = 'LSP: Go to declaration' })

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = 0, desc = 'LSP: Rename' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0, desc = 'LSP: Code action' })
    vim.keymap.set('n', '<leader>wd', builtin.lsp_document_symbols, { buffer = 0, desc = 'LSP: Document symbols' })
    vim.keymap.set('n', '<leader>ww', function()
      builtin.diagnostics({ root_dir = true })
    end, { buffer = 0, desc = 'LSP: Workspace diagnostics' })
  end,
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = 'basic',
      },
    },
  },
})

vim.lsp.config('jsonls', {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        library = {
          '${3rd}/love2d/library',
        },
      },
      completion = {
        callSnippet = 'Replace',
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('phpactor', {
  init_options = {
    ['language_server_phpstan.enabled'] = false,
    ['language_server_psalm.enabled'] = false,
    ['php_code_sniffer.enabled'] = false,
  },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = {
        allFeatures = true,
        command = 'clippy',
      },
      diagnostics = {
        enable = true,
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

require('mason-lspconfig').setup({})

-- lazydev (Lua LSP enhancement)
require('lazydev').setup({
  library = {
    { path = 'luvit-meta/library', words = { 'vim%.uv' } },
  },
})
