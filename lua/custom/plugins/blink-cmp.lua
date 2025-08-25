return {
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        config = function()
          require 'custom.snippets'
        end,
      },
      {
        'MattiasMTS/cmp-dbee',
        dependencies = {
          { 'kndndrj/nvim-dbee' },
        },
        ft = 'sql', -- optional but good to have
        opts = {}, -- needed
      },
      'Kaiser-Yang/blink-cmp-avante',
    },

    version = '*',

    opts = {
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
              -- customize the drawing of kind icons
              kind_icon = {
                text = function(ctx)
                  -- default kind icon
                  local icon = ctx.kind_icon
                  -- if LSP source, check for color derived from documentation
                  if ctx.item.source_name == 'LSP' then
                    local color_item = require('nvim-highlight-colors').format(ctx.item.documentation, { kind = ctx.kind })
                    if color_item and color_item.abbr ~= '' then
                      icon = color_item.abbr
                    end
                  end
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  -- default highlight group
                  local highlight = 'BlinkCmpKind' .. ctx.kind
                  -- if LSP source, check for color derived from documentation
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
      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = { 'avante', 'lsp', 'path', 'snippets', 'buffer', 'dadbod', 'deebee', 'markdown' },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
          },
          dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
          markdown = { name = 'RenderMarkdown', module = 'render-markdown.integ.blink', fallbacks = { 'lsp' } },
          deebee = {
            name = 'cmp-dbee',
            module = 'blink.compat.source',
          },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
  },
}
