local M = {
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = false,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = "background",
                tailwind = true,
                sass = { enable = true, parsers = { "css" }, },
                virtualtext = "■",
            },
            buftypes = {},
        }
    },
    -- TypeScript/React
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx",
            "rescript",
            "xml",
            "php",
            "markdown",
            "astro", "glimmer", "handlebars", "hbs"
        },
        opts = {
            enable = true,
            enable_rename = true,
            enable_close = true,
            enable_close_on_slash = true,
        },
    },
    -- Tailwind
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    },
}

return M
