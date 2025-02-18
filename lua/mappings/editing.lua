local M = {}

M.editing = {
    n = {
        ["<leader>/"] = {
            "gcc",
            "Toggle comment"
        },

    },
    v = {
        ["<leader>/"] = {
            "gc",
            "Toggle comment"
        },
    }
}

return M
