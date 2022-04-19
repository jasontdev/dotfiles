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

-- Set leader to space
options = {noremap = true}
vim.keymap.set('n', '<Space>', '', options)
vim.g.mapleader = ' '

-- Remaps for telescope
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {buffer = 0})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {buffer = 0})
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {buffer = 0})
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {buffer = 0})
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', {buffer = 0})

-- nvim-cmp setup
vim.opt.completeopt = {'menu','menuone','noselect'}
local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }
    })
})

-- LSP setup
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'gopls', 'tsserver' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup{
        capabilities = capabilities,
        on_attach = function()
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = 0})
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {buffer = 0})
            vim.keymap.set('n', '<leader>gy', vim.lsp.buf.type_definition, {buffer = 0})
            vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, {buffer = 0})
            vim.keymap.set('n', '<leader>gj', vim.diagnostic.goto_next, {buffer = 0})
            vim.keymap.set('n', '<leader>gk', vim.diagnostic.goto_prev, {buffer = 0})
        end,
    }
end

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-surround'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'joshdick/onedark.vim'
    use 'dracula/vim'
end)

