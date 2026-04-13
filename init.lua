vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local gh = function(x) return 'https://github.com/' .. x end

-- Build hooks for plugins that need post-install/update steps
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    if name == 'blink.cmp' then
      vim.system({ 'cargo', 'build', '--release' }, { cwd = ev.data.path })
    elseif name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = ev.data.path })
    elseif name == 'LuaSnip' then
      vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path })
    elseif name == 'nvim-treesitter' then
      if ev.data.active then
        local TS = require('nvim-treesitter')
        if TS.update then
          TS.update(nil, { summary = true })
        end
      end
    end
  end,
})

vim.pack.add({
  -- Colorscheme
  gh('folke/tokyonight.nvim'),
  gh('xiyaowong/transparent.nvim'),

  -- UI
  gh('folke/snacks.nvim'),
  gh('goolord/alpha-nvim'),
  gh('nvim-tree/nvim-web-devicons'),
  gh('folke/which-key.nvim'),
  gh('nvim-lualine/lualine.nvim'),
  gh('folke/noice.nvim'),
  gh('MunifTanjim/nui.nvim'),
  gh('j-hui/fidget.nvim'),

  -- Completion + Snippets
  gh('saghen/blink.cmp'),
  gh('saghen/blink.compat'),
  { src = gh('L3MON4D3/LuaSnip'), version = vim.version.range('2.x') },
  gh('rafamadriz/friendly-snippets'),
  gh('MattiasMTS/cmp-dbee'),

  -- LSP
  gh('mason-org/mason.nvim'),
  gh('mason-org/mason-lspconfig.nvim'),
  gh('WhoIsSethDaniel/mason-tool-installer.nvim'),
  gh('neovim/nvim-lspconfig'),
  gh('b0o/SchemaStore.nvim'),
  gh('folke/lazydev.nvim'),
  gh('Bilal2453/luvit-meta'),

  -- Treesitter
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
  { src = gh('nvim-treesitter/nvim-treesitter-textobjects'), version = 'main' },
  gh('nvim-treesitter/nvim-treesitter-context'),

  -- Telescope
  gh('nvim-telescope/telescope.nvim'),
  gh('nvim-telescope/telescope-fzf-native.nvim'),
  gh('nvim-telescope/telescope-ui-select.nvim'),
  gh('nvim-lua/plenary.nvim'),

  -- Git
  gh('tpope/vim-fugitive'),
  { src = gh('lewis6991/gitsigns.nvim'), version = 'main' },

  -- Editing
  gh('echasnovski/mini.nvim'),
  gh('windwp/nvim-autopairs'),
  gh('stevearc/conform.nvim'),
  gh('mfussenegger/nvim-lint'),
  gh('windwp/nvim-ts-autotag'),
  gh('folke/ts-comments.nvim'),
  gh('brenoprata10/nvim-highlight-colors'),

  -- Navigation
  gh('stevearc/oil.nvim'),
  { src = gh('ThePrimeagen/harpoon'), version = 'harpoon2' },
  'https://codeberg.org/andyg/leap.nvim',
  gh('christoomey/vim-tmux-navigator'),

  -- Tools
  gh('folke/trouble.nvim'),
  gh('folke/todo-comments.nvim'),
  gh('nvim-pack/nvim-spectre'),
  gh('mbbill/undotree'),
  gh('kevinhwang91/nvim-bqf'),
  gh('laytan/cloak.nvim'),
  gh('tpope/vim-dadbod'),
  gh('kristijanhusak/vim-dadbod-ui'),
  gh('kristijanhusak/vim-dadbod-completion'),
  gh('kndndrj/nvim-dbee'),
  gh('ThePrimeagen/99'),
  gh('folke/persistence.nvim'),
  gh('MeanderingProgrammer/render-markdown.nvim'),

  -- Misc
  gh('tpope/vim-sleuth'),
  gh('tpope/vim-abolish'),
  gh('tpope/vim-repeat'),
  gh('pechorin/any-jump.vim'),
  gh('nvim-java/nvim-java'),
})

-- Built-in opt plugin (not a git repo, not managed by vim.pack)
vim.cmd.packadd('nvim.difftool')

-- Colorscheme (must be set up before UI plugins configure highlight groups)
require('tokyonight').setup({ transparent = true })
vim.cmd.colorscheme('tokyonight-night')
