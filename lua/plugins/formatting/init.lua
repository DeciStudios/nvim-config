local M = {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },         -- Change from lazy = true
        dependencies = { "nvim-lua/plenary.nvim" },     -- Add this line
        config = function()
            require("gitsigns").setup()
        end
    },
    {
        "nvimtools/none-ls.nvim",
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require('mason-null-ls').setup(require("configs.formatting.null-ls")) -- require your null-ls config here (example below)
        end,
    },
    {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
            require("configs.formatting.luasnip")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
        },
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },
    {
        "onsails/lspkind.nvim"
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "windwp/nvim-autopairs",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            require("configs.formatting.cmp")
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("Comment").setup({
                -- Use treesitter to determine context
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring", -- Better comment support for embedded languages
        },
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = require("configs.formatting.conform"),
    },
    {
        "tpope/vim-surround",
        event = "VeryLazy",
    },
    {
        "mg979/vim-visual-multi",
        event = "VeryLazy",
    },
    {
        "mattn/emmet-vim",
        ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    },
    {
        "junegunn/vim-easy-align",
        event = "VeryLazy",
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event = "BufReadPost",
        config = function()
            require("configs.formatting.ufo")
        end
    },
    {
        "phaazon/hop.nvim",
        event = "BufReadPost",
        config = function()
            require("configs.formatting.hop")
        end
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("configs.formatting.harpoon")
        end
    },

}

local merge = require("utils.merge")
local lua = require("plugins.formatting.lua")
local web = require("plugins.formatting.web")

return merge(M, lua, web)
