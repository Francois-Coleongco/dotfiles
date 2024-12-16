vim.g.mapleader = " "
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 20
vim.opt.tabstop = 4           -- insert 2 spaces for a tab
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = true           -- wrap lines
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
	spec = {

	{
    'goolord/alpha-nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
};
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim" },
		},

		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		},

		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup()
			end,
		},

		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("mason-lspconfig").setup({
					ensure_installed = { "lua_ls", "gopls" },
				})
			end,
		},
		{
			"neovim/nvim-lspconfig",
			config = function()
				local lspconfig = require("lspconfig")

				lspconfig.lua_ls.setup({})
				lspconfig.gopls.setup({})

				vim.keymap.set("n", " K", vim.lsp.buf.hover, {})
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", {noremap = true})

				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			end,
		},

		{ 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'L3MON4D3/LuaSnip' },
		{
			"nvimtools/none-ls.nvim",
			config = function()
				local null_ls = require("null-ls")

				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.stylua,
						null_ls.builtins.formatting.prettier,
						null_ls.builtins.formatting.gofumpt,
						null_ls.builtins.diagnostics.golangci_lint,
					},
				})
				vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
			end,
		},
		{
			'windwp/nvim-autopairs'
		},

		{ 'mbbill/undotree' },

		{'norcalli/nvim-colorizer.lua'}
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

local config = require("nvim-treesitter.configs")

config.setup({
	ensure_installed = { "lua", "javascript", "go", "c", "cpp" },
	highlight = { enable = true },
	indent = { enable = true },
})


vim.cmd('set undofile')
vim.cmd('set termguicolors')

local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
    -- General configuration
    completion = {
        autocomplete = { cmp.TriggerEvent.TextChanged, cmp.TriggerEvent.InsertEnter },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)  -- Expanding snippets using LuaSnip
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },    -- LSP completion
        { name = 'buffer' },      -- Buffer completion
        { name = 'path' },        -- Path completion
        { name = 'luasnip' },     -- LuaSnip for snippets
    },
    experimental = {
        native_menu = false,
        ghost_text = true,  -- Enable ghost text for better UI feedback
    },
})

require'colorizer'.setup()
require('nvim-autopairs').setup{}
