local M = {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = "Mason",
        event = "BufReadPre",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = require("configs.lsp.mason").ensure_installed,
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("configs.lsp")
            require("configs.lsp.languages")
        end
    },



}


local merge = require("utils.merge")
local lua = require("plugins.lsp.lua")
local python = require("plugins.lsp.python")
local rust = require("plugins.lsp.rust")
local odin = require("plugins.lsp.odin")



return merge(M, lua, python, rust, odin)
