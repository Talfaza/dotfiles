return 
{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "HiPhish/nvim-ts-rainbow2" },
		build = ":TSUpdate",
		config = function()
				vim.keymap.set('n', '<leader>h',':TSEnable highlight<CR>',{})

				local config = require("nvim-treesitter.configs")
				config.setup = ({
				
						ensure_installed = {"c","cpp","php","html","lua","bash","javascript","css","rasi"},
						--TSEnable highlight
						sync_install = false,
						--auto_install = true,
						highlight = { enable = true },
						indent = { enable = true },
						--rainbow not working fix later 
						rainbow = { enable = true },	
				})

					end
}
		 

