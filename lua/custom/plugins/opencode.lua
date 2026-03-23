return {
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        'folke/snacks.nvim',
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require('opencode').snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                },
              },
            },
          },
        },
      },
    },
    keys = {
      {
        '<leader>oa',
        mode = { 'n', 'x' },
        function()
          require('opencode').ask('@this: ', { submit = true })
        end,
        desc = 'Ask (Opencode)',
      },
      {
        '<leader>os',
        mode = { 'n', 'x' },
        function()
          require('opencode').select()
        end,
        desc = 'Select Action (Opencode)',
      },
      {
        '<leader>ot',
        mode = { 'n', 't' },
        function()
          require('opencode').toggle()
        end,
        desc = 'Toggle (Opencode)',
      },
      {
        '<leader>oo',
        mode = { 'n', 'x' },
        function()
          return require('opencode').operator('@this ')
        end,
        desc = 'Add Range (Opencode)',
        expr = true,
      },
      {
        '<leader>ool',
        function()
          return require('opencode').operator('@this ') .. '_'
        end,
        desc = 'Add Line (Opencode)',
        expr = true,
      },
      {
        '<leader>ou',
        function()
          require('opencode').command('session.half.page.up')
        end,
        desc = 'Scroll Up (Opencode)',
      },
      {
        '<leader>od',
        function()
          require('opencode').command('session.half.page.down')
        end,
        desc = 'Scroll Down (Opencode)',
      },
    },
    config = function()
      vim.g.opencode_opts = {
        server = {
          enabled = 'tmux',
        },
      }

      vim.o.autoread = true
    end,
  },
}
