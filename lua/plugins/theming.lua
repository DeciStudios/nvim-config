local M = {
    --Theme Picker
    {
        "zaldih/themery.nvim",
        lazy = false,
        config = function()
            require("themery").setup(require("configs.themery"))
        end
    },
    --Themes
    {
        "navarasu/onedark.nvim",
        lazy = true,
        config = function()
            require("onedark").setup()
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        config = function()
            require("tokyonight").setup()
        end
    },
    {
        "sainnhe/sonokai",
        lazy = true,
        config = function()
            vim.g.sonokai_style = "andromeda"
            vim.g.sonokai_enable_italic = 1
        end
    },

}

return M
