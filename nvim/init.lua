vim.o.tabstop = 4 
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.nu = true
vim.o.relativenumber = true
vim.o.hlsearch = false
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = '~/.vim/undodir'
vim.o.undofile = true
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.colorcolumn = 80
vim.o.signcolumn = 'yes' 
vim.cmd('syntax on')
vim.cmd('colorscheme onedark')

local map = vim.api.nvim_set_keymap
map('n', '<Space>', '', {})
vim.g.mapleader = ' '
options = {noremap = true}
map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>', options)
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>', options)
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', options)
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', options)

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-surround'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'joshdick/onedark.vim'
    use 'dracula/vim'
end)

