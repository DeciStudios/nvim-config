local M = {}

M.help = {
    n = {
        ["<leader>?h"] = {
            "<cmd>:help<CR>",
            "Help"
        },
        ["<leader>?k"] = {
            function()
                require("which-key").show()
            end,
            "Open Which Key"
        },
        ["<leader>?c"] = {
            function()
                require("mapper-cheatsheet").show_cheatsheet()
            end,
            "Open Cheatsheet"
        },
        ["<leader>?t"] = {
            "<cmd>Themer<CR>",
            "Open Themer"
        }

    }
}

return M
