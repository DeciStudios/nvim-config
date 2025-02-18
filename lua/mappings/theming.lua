local M = {}

M.theming = {
    n = {
        ["<leader>th"] = {
            function()
                print("Theming")
                require("themery").themery()
            end,
            "Open Themery"
        }
    }
}

return M
