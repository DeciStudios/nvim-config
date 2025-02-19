local M = {}

M.help = {
    n = {
        ["<leader>hh"] = {
            "<cmd>:help<CR>",
            "Help"
        },
        ["<leader>hk"] = {
            function()
                require("which-key").show()
            end,
            "Open Which Key"
        },
        ["<leader>hc"] = {
            function()
                require("mapper-cheatsheet").show_cheatsheet()
            end,
            "Open Cheatsheet"
        },
        ["<leader>ht"] = {
            "<cmd>Themer<CR>",
            "Open Themer"
        }

    }
}

return M
