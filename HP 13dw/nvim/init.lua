vim.cmd("set tabstop=4")
vim.cmd("set number")
vim.cmd("set clipboard=unnamedplus")
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)


require("lazy").setup("plugins")
vim.cmd.colorscheme "moonfly" 
local builtin = require('telescope.builtin')
vim.keymap.set('n','<C-p>',builtin.find_files,{})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
vim.keymap.set('n', '<leader>h',':TSEnable highlight<CR>',{})
vim.keymap.set('n' ,'<C-b>' ,':Neotree filesystem reveal left<CR>',{})
local config = require("nvim-treesitter.configs")
config.setup = ({
		
		ensure_installed = {"c","cpp","php","html","lua","bash","javascript","css","rasi"},
		--TSEnable highlight
		sync_install = false,
		--auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
		rainbow = { enable = true },	
})
