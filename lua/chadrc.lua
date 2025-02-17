---@type ChadrcConfig 
local M = {}


M.base46 = {
  theme="eldritch",
  -- transparency=true,
}

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },

}
M.nvdash = { 
  load_on_startup = true,
  header={

  "     ▄▄▄       ▄▄    ▄ ▄▄   ▄▄ ",
  "  ▄▀▀   ▀▀▄   █  █  █ █  █ █  █",
  " █       ▄▄█  █   █▄█ █  █▄█  █",
  "█    ▄▄▀▀     █       █       █",
  "▀▄     ▀▀▄▄▄  █  ▄    █       █",
  " ▀▄       ▄▀  █ █ █   ██     █ ",
  "   ▀▀▄▄▄▀▀    █▄█  █▄▄█ █▄▄▄█  ",
  "                               ",
  " Powered By  eovim",
  ""
    
  },
  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Open Directory", keys = "cd", cmd = "Telescope file_browser" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}


if vim.g.neovide then
  --print("YEAH")
  vim.o.guifont= "FiraCode Nerd Font:h13:b"
  local default_path = vim.fn.expand("~/Documents/Projects")
  vim.api.nvim_set_current_dir(default_path)

  vim.g.neovide_font_size = 12
  --vim.g.neovide
  -- M.base46.transparency = false
  -- require("base46").toggle_transparency()
  -- require('nvchad.base46').load_all_highlights()

  vim.g.neovide_transparency = 0.6
  vim.g.neovide_window_blurred = true
  -- require('base46').toggle_transparency()
end



return M
