return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "navarasu/onedark.nvim",
        config = function ()
            require('onedark').load()
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "json", "php", "java", "cpp", "go" },
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
			})
        end
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function ()
            local harpoon = require("harpoon")
            harpoon:setup()
    
            vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
        end
    },
    {
        "mbbill/undotree",
        config = function ()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },
    {
        "tpope/vim-fugitive",
        config = function ()
            vim.keymap.set('n', '<leader>gg', vim.cmd.Git)
        end
    },
    --- Uncomment the two plugins below if you want to manage the language servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = function ()
            local lsp = require("lsp-zero")
            lsp.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp.default_keymaps({buffer = bufnr, remap=false})
            end)

            require('mason').setup({})
            require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",
                "tsserver",
                "eslint",
                "bashls",
                "clangd",
                "dockerls",
                "gopls",
                "html",
                "jsonls",
                "jdtls",
                "marksman",
                "intelephense",
                "jedi_language_server",
                "rust_analyzer",
                "sqlls",
                "svelte",
                "tailwindcss"
            },
            handlers = { lsp.default_setup,}
        })
        end
    },
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {
        'ThePrimeagen/vim-be-good',
    }
}
