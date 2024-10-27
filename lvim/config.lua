-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
--
-- General Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.foldmethod = "syntax"
vim.opt.foldlevelstart = 99
vim.opt.scrolloff = 20

-- Tabs and Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search Settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Performance
vim.opt.lazyredraw = true
vim.opt.timeoutlen = 500

-- Misc
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 300
vim.opt.mouse = "a"

-- Enable line wrapping
vim.opt.wrap = true

-- Enable 24-bit RGB color in terminal
vim.opt.termguicolors = true

lvim.keys.insert_mode["<A-j>"] = false
lvim.keys.insert_mode["<A-k>"] = false
lvim.keys.normal_mode["<A-j>"] = false
lvim.keys.normal_mode["<A-k>"] = false
lvim.keys.visual_block_mode["<A-j>"] = false
lvim.keys.visual_block_mode["<A-k>"] = false
lvim.keys.visual_block_mode["J"] = false
lvim.keys.visual_block_mode["K"] = false
