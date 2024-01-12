vim.cmd("set tabstop=4")
vim.cmd("set number")
vim.cmd("set clipboard=unnamedplus")
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local plugins = {
			{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
		    {
              'nvim-telescope/telescope.nvim', tag = '0.1.5',
		      -- or                              , branch = '0.1.x',
		      dependencies = { 'nvim-lua/plenary.nvim' }
		    },
			{

				"nvim-treesitter/nvim-treesitter",
				dependencies = { "HiPhish/nvim-ts-rainbow2" },
				build = ":TSUpdate",
			}
	}

local opts    = {}

require("lazy").setup(plugins,opts)
vim.cmd.colorscheme "moonfly" 
local builtin = require('telescope.builtin')
vim.keymap.set('n','<C-p>',builtin.find_files,{})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})

local config = require("nvim-treesitter.configs")
config.setup = ({
		
		ensure_installed = {"c","cpp","php","html","lua","bash","javascript","css"},
		--TSEnable highlight
		sync_install = false,
		--auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
		rainbow = { enable = true },	
})
