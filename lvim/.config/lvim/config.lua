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
  }
};



local dashboard = require "alpha.themes.dashboard"

local default_header = {
  type = "text",
  val = {
    [[⠛⠛⠛⠻⠿⠾⠿⠿⠿⠿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⠀⠀⠀⡀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠈⠉⠉⠙⠙⠛⠛⠛⠛⢛⠿⣿⠦⢴⠀⠀⠀⠀⠀⠨⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⠆⠼⠏⠛⠀⠀⠈⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⢠⠜⢃⣤⣾⡿⠂⠇⠊⠀⢸⠒⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠙⠛⠋⠛⠛⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿]],
    [[⠂⠚⠒⠂⠒⠀⠐⠠⠤⠤⠤⠠⠠⠤⠤⠠⢌⣤⣖⣲⣢⣀⣤⣾⡟⢻⢣⣾⣿⣿⣿⣿⣷⣴⣢⣿⢗⠀⠀⠀⠰⣲⠒⡒⠀⠀⠀⠄⠤⠤⡀⡠⢄⠀⠡⡀⣀⣀⡀⡀⠀⠀⠀⠀]],
    [[⡲⣢⠀⡐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⣅⣴⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠈⠢⣀⣔⣠⣤⣴⣧⣬⣴⣶⣧⣻⣶⣾⣮⣾⣾⣶⣾⣿⣼⣿]],
    [[⣶⣶⣶⣶⣶⣶⣶⣶⣤⣤⣤⣤⣤⣤⣴⣶⣶⣶⣴⣦⣤⣤⣠⡨⠘⢾⡿⠟⣿⣿⣿⣿⣿⠿⠿⠿⣿⡿⢧⠀⠀⣶⢸⢶⣿⡿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⡅⠀⣽⡇⠰⣦⣠⡟⠻⣇⠠⠶⠂⢸⣿⣤⠄⠀⠀⠈⣿⣿⣾⣶⣾⣿⣿⣷⣷⣿⣶⣶⣶⣶⣶⣶⣤⣤⣬⣭⣭]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡽⠀⠀⣿⣿⣿⣿⡿⡠⠀⢻⣿⣷⣶⣿⣿⡟⠀⠀⠀⠀⣱⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⢸⣿⣿⣿⡿⣾⣷⣾⣿⣿⠟⠛⠉⠁⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠘⣿⠹⣿⡿⣷⡽⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡫⣿⣿⣿⡃⣿⠀⠀⠀⠀⡀⠀⠀⡈⢐⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣯⢹⡴⠞⣇⠀⠘⠀⠈⠀⠂⡠⠈⠉⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢛⣯⣶⣿⢳⠛⠟⣛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠛⠿⠿⢿⠿⣿⡿⠿⢿⣿⢿⣿⣿⣿⢿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢁⣴⣿⣿⣿⣿⠏⣠⡞⠃⢀⠀⠀⠀⠀⠀⠁⠂⡀⠀⢀⠀⠐⠀⠠⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠈⠁⠀⠐⡀⠀]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⣴⣿⣿⣿⡿⢋⣱⡾⠋⠀⠀⠀⠁⠀⠀⠀⠀⢀⡬⠤⠛⠀⠉⠀⠀⠀⠈⠡⠀⠄⠈⢠⣀⡀⠀⠀⠀⡈⠀⠀⠀⠀⠀⠀]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⢼⣿⣿⣿⢿⣶⣿⠟⢠⡀⠁⠀⢀⠀⠺⠠⠠⠺⣫⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠈⢠⣾⣿⣷⣠⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠈⡿⣿⣿⢿⠿⡣⣷⣾⠄⠐⠀⠀⠐⡼⠶⠀⠌⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⠷⠺⠿⠿⠓⠚⠠⠐⠄⠀⠀⠀]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣧⣤⣤⣼⣿⣹⢃⣴⣿⡾⢳⠊⠀⢀⠀⠐⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠁⠀⠀⠈]],
  },
  opts = {
    position = "center",
    hl = "Type",
    -- wrap = "overflow";
  },
}

local buttons = {
  type = "group",
  val = {
    dashboard.button("SPC ff", "  Find File", ":Telescope find_files<CR>"),
    { type = "padding", val = 1 },
    dashboard.button("SPC e", "  New File", ":ene!<CR>"),
    { type = "padding", val = 1 },
    dashboard.button("SPC f r", "  Recently Used Files", ":Telescope oldfiles<CR>"),
    { type = "padding", val = 1 },
    dashboard.button("SPC gp", "  Greppy", ":Telescope live_grep<CR>"),
  },
  position = "center",
}

lvim.builtin.alpha.dashboard.config = {
  layout = {
    { type = "padding", val = 2 },
    default_header,
    { type = "padding", val = 2 },
    buttons,
  },
  opts = {
    margin = 5,
    setup = function()
      vim.cmd [[autocmd alpha_temp DirChanged * lua require('alpha').redraw()]]
    end,
  },
}
