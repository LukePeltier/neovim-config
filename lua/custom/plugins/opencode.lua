return {
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      { 'folke/snacks.nvim' },
    },
    config = function()
      vim.o.autoread = true

      -- Recommended/example keymaps.
      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        require('opencode').ask('@this: ', { submit = true })
      end, { desc = 'Ask opencode' })
      vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
        require('opencode').select()
      end, { desc = 'Select prompt' })
      vim.keymap.set({ 'n', 'x' }, '<leader>o+', function()
        require('opencode').prompt '@this'
      end, { desc = 'Add to opencode' })
      vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
        require('opencode').toggle()
      end, { desc = 'Toggle opencode' })
      vim.keymap.set('n', '<S-C-u>', function()
        require('opencode').command 'session.half.page.up'
      end, { desc = 'opencode half page up' })
      vim.keymap.set('n', '<S-C-d>', function()
        require('opencode').command 'session.half.page.down'
      end, { desc = 'opencode half page down' })
    end,
  },
}
