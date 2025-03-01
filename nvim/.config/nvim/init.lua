vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

---- Run :Screenkey toggle on startup
--vim.api.nvim_create_autocmd("VimEnter", {
--  command = "Screenkey toggle",  -- This will run the :Screenkey toggle command
--})

vim.g.mapleader = " "
vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 20
vim.opt.tabstop = 2           -- insert 2 spaces for a tab
vim.opt.number = true
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = true           -- wrap lines


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		border = "rounded" -- You can also use "single", "double", etc.
	}
)

-- This handler is responsible for showing the hover window with borders
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

		{ "ThePrimeagen/vim-be-good" },
		{ "NStefan002/screenkey.nvim" },
		{ "andweeb/presence.nvim" },
		-- { "mong8se/actually.nvim" },
		{
			'nvim-lualine/lualine.nvim',
			requires = { 'nvim-tree/nvim-web-devicons', opt = true }
		},
		{
			'numToStr/Comment.nvim',
			opts = {
				-- add any options here
			}
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				win = {
					-- don't allow the popup to overlap with the cursor
					no_overlap = true,
					-- width = 1,
					-- height = { min = 4, max = 25 },
					-- col = 0,
					-- row = math.huge,
					border = "rounded",
					padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
					title = true,
					title_pos = "center",
					zindex = 1000,
					-- Additional vim.wo and vim.bo options
					bo = {},
					wo = {
						-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
					},
				},
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		-- {
		-- 	"echasnovski/mini.map",
		-- 	branch = "stable",
		-- 	config = function()
		-- 		require('mini.map').setup()
		-- 		local map = require('mini.map')
		-- 		map.setup({
		-- 			integrations = {
		-- 				map.gen_integration.builtin_search(),
		-- 				map.gen_integration.diagnostic({
		-- 					error = 'DiagnosticFloatingError',
		-- 					warn  = 'DiagnosticFloatingWarn',
		-- 					info  = 'DiagnosticFloatingInfo',
		-- 					hint  = 'DiagnosticFloatingHint',
		-- 				}),
		-- 			},
		-- 			symbols = {
		-- 				encode = map.gen_encode_symbols.dot('4x2'),
		-- 			},
		-- 			window = {
		-- 				side = 'right',
		-- 				width = 20, -- set to 1 for a pure scrollbar :)
		-- 				winblend = 15,
		-- 				show_integration_count = false,
		-- 			},
		-- 		})
		-- 		map.open()
		-- 	end
		-- },

		{
			"MaximilianLloyd/ascii.nvim",
			requires = {
				"MunifTanjim/nui.nvim"
			}
		},
		{
			"goolord/alpha-nvim",
			config = function()
				require("alpha").setup(require("alpha.themes.dashboard").config)
			end,
		},
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
					ensure_installed = { "lua_ls", "gopls", "rust_analyzer", "jdtls" },
				})
			end,
		},

		{ "nvim-java/nvim-java" },

		{
			"neovim/nvim-lspconfig",
			config = function()
				local lspconfig = require("lspconfig")

				lspconfig.lua_ls.setup({
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								-- Make the server aware of Neovim runtime files
								library = vim.api.nvim_get_runtime_file("", true),
							},
						},
					},
				})
				lspconfig.gopls.setup({})
				lspconfig.rust_analyzer.setup({
					settings = {
						["rust-analyzer"] = {},
					},
				})
				lspconfig.clangd.setup({})
				lspconfig.pyright.setup({})
				lspconfig.jdtls.setup({})
				lspconfig.ts_ls.setup({})
				lspconfig.tailwindcss.setup({})


				vim.keymap.set("n", " K", vim.lsp.buf.hover, {})
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				-- vim.api.nvim_set_keymap("n", "<leader>wq", "<cmd>:wq<cr>", { noremap = true })
				-- vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>:q<cr>", { noremap = true })
				-- vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>:w<cr>", { noremap = true })

				vim.api.nvim_set_keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", { noremap = true })
				vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { noremap = true })

				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			end,
		},

		{ "rust-lang/rust.vim" },

		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "L3MON4D3/LuaSnip" },
		{
			"nvimtools/none-ls.nvim",
			config = function()
				local null_ls = require("null-ls")

				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.stylua,
						null_ls.builtins.formatting.prettier,
						null_ls.builtins.formatting.gofumpt,
						null_ls.builtins.formatting.prettier,
						null_ls.builtins.diagnostics.golangci_lint,
					},
				})
				vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
			end,
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			-- use opts = {} for passing setup options
			-- this is equivalent to setup({}) function
		},
		{
			"windwp/nvim-ts-autotag",
		},

		{ "mbbill/undotree" },

		{ "norcalli/nvim-colorizer.lua" },
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)
vim.api.nvim_set_keymap("n", ";", "$", { noremap = true, silent = true })
vim.api.nvim_del_keymap("n", "$")

local config = require("nvim-treesitter.configs")

config.setup({
	ensure_installed = { "lua", "javascript", "go", "c", "cpp" },
	highlight = { enable = true },
	indent = { enable = true },
})

vim.cmd("set undofile")
vim.cmd("set termguicolors")

vim.keymap.set("n", "<leader>h", "<cmd>noh<CR>")

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	-- General configuration
	completion = {
		autocomplete = { cmp.TriggerEvent.TextChanged, cmp.TriggerEvent.InsertEnter },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- Expanding snippets using LuaSnip
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = "nvim_lsp" }, -- LSP completion
		{ name = "buffer" }, -- Buffer completion
		{ name = "path" },   -- Path completion
		{ name = "luasnip" }, -- LuaSnip for snippets
	},
	experimental = {
		native_menu = false,
		ghost_text = true, -- Enable ghost text for better UI feedback
	},
})

require("colorizer").setup()

npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

require("nvim-ts-autotag").setup({
	opts = {
		-- Defaults
		enable_close = true,         -- Auto close tags
		enable_rename = true,        -- Auto rename pairs of tags
		enable_close_on_slash = false, -- Auto close on trailing </
	},
	-- Also override individual filetype configs, these take priority.
	-- Empty by default, useful if one of the "opts" global settings
	-- doesn't work well in a specific filetype
	per_filetype = {
		["html"] = {
			enable_close = false,
		},
	},
})

require("screenkey").setup({
	win_opts = {
		row = vim.o.lines - vim.o.cmdheight - 1,
		col = vim.o.columns - 1,
		relative = "editor",
		anchor = "SE",
		width = 40,
		height = 3,
		border = "single",
		title = "",
		title_pos = "center",
		style = "minimal",
		focusable = false,
		noautocmd = true,
	},
	compress_after = 3,
	clear_after = 3,
	disable = {
		filetypes = {},
		buftypes = {},
		events = false,
	},
	show_leader = true,
	group_mappings = false,
	display_infront = {},
	display_behind = {},
	filter = function(keys)
		return keys
	end,
	keys = {
		["<TAB>"] = "󰌒",
		["<CR>"] = "󰌑",
		["<ESC>"] = "Esc",
		["<SPACE>"] = "␣",
		["<BS>"] = "󰌥",
		["<DEL>"] = "Del",
		["<LEFT>"] = "",
		["<RIGHT>"] = "",
		["<UP>"] = "",
		["<DOWN>"] = "",
		["<HOME>"] = "Home",
		["<END>"] = "End",
		["<PAGEUP>"] = "PgUp",
		["<PAGEDOWN>"] = "PgDn",
		["<INSERT>"] = "Ins",
		["<F1>"] = "󱊫",
		["<F2>"] = "󱊬",
		["<F3>"] = "󱊭",
		["<F4>"] = "󱊮",
		["<F5>"] = "󱊯",
		["<F6>"] = "󱊰",
		["<F7>"] = "󱊱",
		["<F8>"] = "󱊲",
		["<F9>"] = "󱊳",
		["<F10>"] = "󱊴",
		["<F11>"] = "󱊵",
		["<F12>"] = "󱊶",
		["CTRL"] = "Ctrl",
		["ALT"] = "Alt",
		["SUPER"] = "󰘳",
		["<leader>"] = "<leader>",
	},
})

npairs.add_rule(Rule("/*", "*/"))

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

require('lualine').setup()
require('Comment').setup()
