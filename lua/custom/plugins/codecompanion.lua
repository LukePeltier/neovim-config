return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'j-hui/fidget.nvim',
  },
  keys = {
    {
      '<leader>at',
      '<cmd>CodeCompanionChat Toggle<CR>',
      desc = 'CodeCompanion Chat Toggle',
    },
    {
      '<leader>ai',
      '<cmd>CodeCompanion<CR>',
      mode = 'v',
      desc = 'CodeCompanion Inline (visual)',
    },
  },
  opts = {
    adapters = {
      azure_openai = function()
        -- Emit an autocmd event before returning the adapter
        return require('codecompanion.adapters').extend('azure_openai', {
          env = {
            api_key = os.getenv 'AZURE_OPENAI_API_KEY',
            endpoint = os.getenv 'AZURE_OPENAI_ENDPOINT',
            api_version = '2025-01-01-preview',
          },
          schema = {
            model = {
              default = 'gpt-4.1',
              choices = {
                ['o4-mini'] = { opts = { can_reason = true } },
                'gpt-4.1',
                'gpt-4.1-mini',
              },
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = 'azure_openai',
      },
      inline = {
        adapter = 'azure_openai',
      },
    },
  },
  init = function()
    require('custom.fidget-spinner'):init()
  end,
}
