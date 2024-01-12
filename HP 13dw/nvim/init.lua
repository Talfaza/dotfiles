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
	--rainbow not working fix later 
		rainbow = { enable = true },	
})




require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'iceberg_dark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}



