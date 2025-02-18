local M = {
    { 'AndreM222/copilot-lualine' },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
            require("configs.ai.copilot")
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "copilot.lua" },
        event = "InsertEnter",
        config = function()
            require("copilot_cmp").setup()
        end
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        cmd = "CopilotChat",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        config = function()
            require("CopilotChat").setup(require("configs.ai.copilotchat"))
        end
    },

}

return M
