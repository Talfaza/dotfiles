return {
		{
				"williamboman/mason.nvim",
				config = function()
								require("mason").setup({})
						 end
		},
		{
				'williamboman/mason-lspconfig.nvim',
				config = function()
								require("mason-lspconfig").setup({
										    ensure_installed = { "lua_ls",
																"clangd",
																"cssls",
																"dockerls",
																"html",
																"quick_lint_js",
																"marksman",
																"intelephense",
																"jedi_language_server",
																"sqlls",
																"hydra_lsp"
														       },

								})
						 end
		},
		{

				"neovim/nvim-lspconfig",
				config = function()

								local lspconfig = require('lspconfig')
								lspconfig.lua_ls.setup({})
								lspconfig.clangd.setup({})
								lspconfig.cssls.setup({})
								lspconfig.dockerls.setup({})
								lspconfig.html.setup({})
								lspconfig.quick_lint_js.setup({})
								lspconfig.marksman.setup({})
								lspconfig.intelephense.setup({})
								lspconfig.jedi_language_server.setup({})
								lspconfig.sqlls.setup({})
								lspconfig.hydra_lsp.setup({})
								vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
						        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
						 end
		}

}
