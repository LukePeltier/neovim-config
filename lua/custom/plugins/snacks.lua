-- snacks.nvim: A collection of small QoL utilities by folke.
-- Provides: notifications, buffer delete, terminal toggle, word navigation,
-- file rename, git browse, indent guides, and more.
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true }, -- Disable heavy features (treesitter, LSP) for large files
    notifier = {
      enabled = true, -- Replaces vim.notify with a nicer UI
      timeout = 3000,
    },
    quickfile = { enabled = true }, -- Render files quickly before plugins load
    statuscolumn = { enabled = true }, -- Custom status column (signs, line numbers, folds)
    words = { enabled = true }, -- Highlight and jump between references of word under cursor
    input = {
      enabled = true, -- Prettier vim.ui.input replacement
    },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
    indent = {
      enabled = true, -- Indent guides
    },
  },
  keys = {
    -- Notifications
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>uh',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Show Notification History',
    },

    -- Buffers
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },

    -- Git
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
    },

    -- Code
    {
      '<leader>cR',
      function()
        Snacks.rename()
      end,
      desc = 'Rename File',
    },

    -- Terminal (<c-_> is how some terminals send <c-/>)
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<c-_>',
      function()
        Snacks.terminal()
      end,
      desc = 'which_key_ignore',
    },

    -- Word references: jump between occurrences of the word under cursor
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
    },

    -- Misc
    {
      '<leader>N',
      desc = 'Neovim News',
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        }
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Global debug helpers: dd() to inspect, bt() for backtrace
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end,
    })
  end,
}
