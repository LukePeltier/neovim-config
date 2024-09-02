return {
  'rmagatti/auto-session',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim', -- Only needed if you want to use session lens
  },
  opts = {
    log_level = 'info',
    suppressed_dirs = { '~/', '~/Downloads', '/' },
    bypass_save_filetypes = { 'alpha' }, -- or whatever dashboard you use
  },
  init = function()
    vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
  end,
}
