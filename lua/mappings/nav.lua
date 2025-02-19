local M = {}

M.navigation = {
    i = {
        ["<C-b>"] = {
            "<ESC>^i",
            "Move to the beginning of the line"
        },
        ["<C-e>"] = {
            "<End>",
            "Move to the end of the line",
        },
        ["<C-h>"] = {
            "<Left>",
            "Move left",
        },
        ["<C-l>"] = {
            "<Right>",
            "Move right",
        },
        ["<C-j>"] = {
            "<Down>",
            "Move down",
        },
        ["<C-k>"] = {
            "<Up>",
            "Move up",
        },
    },

    n = {
        ["<C-h>"] = {
            "<C-w>h",
            "Move to the left window",
        },
        ["<C-l>"] = {
            "<C-w>l",
            "Move to the right window",
        },
        ["<C-j>"] = {
            "<C-w>j",
            "Move to the below window",
        },
        ["<C-k>"] = {
            "<C-w>k",
            "Move to the above window",
        },
        ["<C-+>"] = {
            "zA",
            "Open fold",
        },
        ["<C-->"] = {
            "zc",
            "Close fold",
        },
    }
}



return M
