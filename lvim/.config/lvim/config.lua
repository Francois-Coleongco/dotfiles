-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.opt.shiftwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 20
vim.opt.tabstop = 2           -- insert 2 spaces for a tab
vim.opt.number = true
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = true           -- wrap lines

lvim.format_on_save = true
lvim.colorscheme = "poimandres"
lvim.transparent_window = true
lvim.lsp.buffer_mappings.normal_mode['<leader>ca'] = { vim.lsp.buf.code_action, "code action" }
lvim.lsp.buffer_mappings.normal_mode['<leader>`'] = { ":bnext<CR>" }

lvim.plugins = {
  -- Lua

  {
    'olivercederborg/poimandres.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('poimandres').setup {
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
      }
    end,

    -- optionally set the colorscheme within lazy config
    init = function()
      vim.cmd("colorscheme poimandres")
    end

  },
  {
    'goolord/alpha-nvim',
  },
  { "andweeb/presence.nvim" },

};
