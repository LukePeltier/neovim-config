-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See :help 'list'
--  and :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', extends = '>', precedes = '<' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.opt.tabstop = 2 -- A TAB character looks like 4 spaces
vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 2 -- Number of spaces inserted when indenting

-- Configure code folding using Treesitter expressions
vim.opt.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = '' -- Use default fold text
vim.opt.fillchars:append 'fold: ' -- Use space for fold character instead of default '-'
vim.opt.foldlevelstart = 99 -- Start with all folds open

-- Disable swap files and backup files
vim.opt.swapfile = false
vim.opt.backup = false
local path_sep = package.config:sub(1, 1) -- Get the path separator based on the package.config
local home_dir = os.getenv 'HOME' or os.getenv 'USERPROFILE' -- Get home directory in a cross-platform way
local undodir = home_dir .. (path_sep == '\\' and '\\.vim\\undodir' or '/.vim/undodir') -- Adjust path based on OS

-- Enable persistent undo history saved to a custom directory
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Enable incremental search highlighting
vim.opt.hlsearch = true -- Highlight all matches
vim.opt.incsearch = true -- Show matches as you type

-- Allow cursor to move one character beyond the end of line
vim.opt.ve = 'onemore'

-- Add custom filetype mappings
vim.filetype.add {
  extension = {
    pcss = 'css', -- Treat .pcss files as CSS
  },
}

-- Configure shared data (shada) file settings
vim.opt.shada = { "'10", '<50', 's10', 'h' } -- Store marks for 10 files, 50 lines per register, skip 10+ kb files, disable hlsearch persistence

-- vim.cmd.colorscheme 'kanagawa'

-- Configure session save options (used by auto-session plugin)
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Disable line wrapping (long lines extend beyond screen width)
vim.opt.wrap = true

-- Configure how diagnostics are displayed
vim.diagnostic.config { virtual_text = true, virtual_lines = false } -- Show inline diagnostics but not virtual lines

-- if vim.env.TMUX then
--   vim.g.clipboard = {
--     name = 'tmuxClipboard',
--     copy = {
--       ['+'] = { 'tmux', 'load-buffer', '-w', '-' },
--       ['*'] = { 'tmux', 'load-buffer', '-w', '-' },
--     },
--     paste = {
--       ['+'] = { 'tmux', 'save-buffer', '-w', '-' },
--       ['*'] = { 'tmux', 'save-buffer', '-w', '-' },
--     },
--     cache_enabled = true,
--   }
-- end
--
-- Configure the status line
vim.opt.laststatus = 3 -- Global status line for all windows
-- Modify the PATH to include mise runtime version manager
vim.env.PATH = vim.env.HOME .. '/.local/share/mise/shims:' .. vim.env.PATH
