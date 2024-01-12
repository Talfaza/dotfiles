
return {
		{"bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
		
		{"nvim-treesitter/nvim-treesitter",dependencies = { "HiPhish/nvim-ts-rainbow2" },build = ":TSUpdate",},
		{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
		      "nvim-lua/plenary.nvim",
		      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		      "MunifTanjim/nui.nvim",}
		},
		{'nvim-telescope/telescope.nvim', tag = '0.1.5',dependencies = { 'nvim-lua/plenary.nvim' }},
		{'nvim-lualine/lualine.nvim',dependencies = { 'nvim-tree/nvim-web-devicons' }}
	}

