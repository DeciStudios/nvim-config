local M = {
    --Theme Picker
    {
        "zaldih/themery.nvim",
        lazy = false,
        config = function()
            require("themery").setup(require("configs.theming.themery"))
        end
    },
    --Themes
    {
        "navarasu/onedark.nvim",
        lazy = true,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
    },
    {
        "sainnhe/sonokai",
        lazy = true,
        config = function()
            vim.g.sonokai_style = "andromeda"
            vim.g.sonokai_enable_italic = 1
        end
    },
    {
        "shaunsingh/nord.nvim",
        lazy = true,
    },
    {
        "catppuccin/nvim",
        lazy = true,
    },
    {
        "eldritch-theme/eldritch.nvim",
        lazy = true,
    },
    {
        "marko-cerovac/material.nvim",
        lazy = true,
    },
    {
        "mhartington/oceanic-next",
        lazy = true,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
    },
    {
        "rmehri01/onenord.nvim",
        lazy = true,
    },
    {
        "ThePrimeagen/harpoon",
        lazy = true,
    },
    {
        "neanias/everforest-nvim",
        lazy = true,
    },
    {
        "luisiacc/gruvbox-baby",
        lazy = true,
    },
    {
        "Pocco81/Catppuccino.nvim",
        lazy = true,
    },

}

return M
