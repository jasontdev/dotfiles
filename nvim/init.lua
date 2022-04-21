-- Options
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
vim.o.undofile = true
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.colorcolumn = 80
vim.o.signcolumn = 'yes' 
vim.cmd('syntax on')
vim.cmd('colorscheme onedark')
vim.cmd('set undodir=~/.vim/undo-dir')

vim.diagnostic.config({
    virtual_text = false,
    float = {
        source = 'always',
        border = border
  },
})

-- packer
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-surround'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'joshdick/onedark.vim'
    use 'dracula/vim'
    use 'jose-elias-alvarez/null-ls.nvim'

    use {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                fold_open = "v",
                fold_closed = ">",
                indent_lines = false,
                signs = {
                    error = "error",
                    warning = "warn",
                    hint = "hint",
                    information = "info"
                },
                use_diagnostic_signs = false
            }
        end
    }
end)

-- Set leader to space
options = {noremap = true}
vim.keymap.set('n', '<Space>', '', options)
vim.g.mapleader = ' '

-- Trouble remaps
vim.keymap.set('n', '<leader>t', '<cmd>Trouble document_diagnostics<cr>', options);
vim.keymap.set('n', '<leader>tw', '<cmd>Trouble workspace_diagnostics<cr>', options);

-- Remaps for telescope
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, options)
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, options)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, options)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, options)
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', options)

-- nvim-cmp setup
vim.opt.completeopt = {'menu','menuone','noselect'}
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
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
            vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, {buffer = 0})
            vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, {buffer = 0})
            vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, {buffer = 0})
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer = 0})
        end,
    }
end

-- null-ls.nvim setup
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
        require("null-ls").builtins.formatting.prettier
    },
})
