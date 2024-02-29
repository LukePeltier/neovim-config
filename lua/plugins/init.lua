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
            lsp.extend_lspconfig()
            lsp.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp.default_keymaps({buffer = bufnr, remap=false})
				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = "*.go",
					callback = function()
						local params = vim.lsp.util.make_range_params()
						params.context = {only = {"source.organizeImports"}}
						-- buf_request_sync defaults to a 1000ms timeout. Depending on your
						-- machine and codebase, you may want longer. Add an additional
						-- argument after params if you find that you have to write the file
						-- twice for changes to be saved.
						-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
						local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
						for cid, res in pairs(result or {}) do
							for _, r in pairs(res.result or {}) do
								if r.edit then
									local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
									vim.lsp.util.apply_workspace_edit(r.edit, enc)
								end
							end
						end
						vim.lsp.buf.format({async = false})
					end
				})
                vim.b.lsp_zero_enable_autoformat = 1
            end)

           ---  require('mason').setup({})
            require("mason").setup {
                log_level = vim.log.levels.DEBUG
            }
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
                    "pyright",
                    "rust_analyzer",
                    "sqlls",
                    "svelte",
                    "tailwindcss"
                },
                handlers = { lsp.default_setup,}
            })
            local cmp = require('cmp')
            local cmp_action = lsp.cmp_action()

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ['<Tab>'] = cmp.mapping.confirm({select = false}),

                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Navigate between snippet placeholder
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                })
            })
        end
    },
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		},
		lazy = false,
	}

}
