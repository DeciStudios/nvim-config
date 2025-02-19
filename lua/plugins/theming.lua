local M = {
    -- -- Theme Picker
    {
        "DeciStudios/themer.nvim",
        config = function()
            require("themer").setup(require("configs.ui.themer"))
        end
    },





    ----------------
    ---- Themes ----
    ----------------

    { "folke/tokyonight.nvim",          lazy = true },
    {
        "sainnhe/sonokai",
        lazy = true,
        config = function()
            vim.g.sonokai_style = "andromeda"
            vim.g.sonokai_enable_italic = 1
        end
    },
    { "shaunsingh/nord.nvim",           lazy = true },
    { "catppuccin/nvim",                lazy = true },
    { "eldritch-theme/eldritch.nvim",   lazy = true },
    { "marko-cerovac/material.nvim",    lazy = true },
    { "mhartington/oceanic-next",       lazy = true },
    { "EdenEast/nightfox.nvim",         lazy = true },
    { "rmehri01/onenord.nvim",          lazy = true },
    { "neanias/everforest-nvim",        lazy = true },
    { "luisiacc/gruvbox-baby",          lazy = true },
    { "ellisonleao/gruvbox.nvim",       lazy = true },
    { "sainnhe/gruvbox-material",       lazy = true },
    { "sainnhe/everforest",             lazy = true },
    { "projekt0n/github-nvim-theme",    lazy = true },
    { "Mofiqul/vscode.nvim",            lazy = true },
    { "jacoborus/tender.vim",           lazy = true },
    { "rafamadriz/neon",                lazy = true },
    { "rebelot/kanagawa.nvim",          lazy = true },
    { "frenzyexists/aquarium-vim",      lazy = true },
    { "tiagovla/tokyodark.nvim",        lazy = true },
    { "yonlu/omni.vim",                 lazy = true },
    { "kaiuri/nvim-juliana",            lazy = true },
    { "rockerBOO/boo-colorscheme-nvim", lazy = true },
    { "zanglg/nova.nvim",               lazy = true },
    { "yashguptaz/calvera-dark.nvim",   lazy = true },
    { "bluz71/vim-moonfly-colors",      lazy = true },
    { "bluz71/vim-nightfly-colors",     lazy = true },
    { "drewtempelmeyer/palenight.vim",  lazy = true },
    { "fenetikm/falcon",                lazy = true },
    { "savq/melange-nvim",              lazy = true },
    { "NTBBloodbath/doom-one.nvim",     lazy = true },
    { "kdheepak/monochrome.nvim",       lazy = true },
    { "rktjmp/lush.nvim",               lazy = true }, -- Lush for building themes
    { "mcchrish/zenbones.nvim",         lazy = true,        dependencies = { "rktjmp/lush.nvim" } },
    { "Shatur/neovim-ayu",              lazy = true },
    { "sainnhe/edge",                   lazy = true },
    { "tjdevries/colorbuddy.nvim",      lazy = true }, -- Required for some themes
    { "rmehri01/onenord.nvim",          lazy = true },
    { "olimorris/onedarkpro.nvim",      lazy = true },
    { "ishan9299/nvim-solarized-lua",   lazy = true },
    { "bluz71/vim-moonfly-colors",      lazy = true },
    { "marko-cerovac/material.nvim",    lazy = true },
    { "Mofiqul/dracula.nvim",           lazy = true },
    { "rose-pine/neovim",               name = "rose-pine", lazy = true },
    { "Everblush/nvim",                 name = "everblush", lazy = true },
    { "hardhackerlabs/theme-vim",       lazy = true },
    { "glepnir/zephyr-nvim",            lazy = true },
    { "sainnhe/everforest",             lazy = true },
    { "xiantang/darcula-dark.nvim",     lazy = true },
}

return M
