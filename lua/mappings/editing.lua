local M = {}

M.editing = {
    -- Normal mode mappings
    n = {
        -- Toggle comment on current line
        ["<leader>/"] = {
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            "Toggle comment"
        },
        -- Toggle comment on multiple lines
        ["<leader>c/"] = {
            function()
                require("Comment.api").toggle.linewise.count(vim.v.count1)
            end,
            "Toggle comment on multiple lines"
        },
        -- Toggle block comment
        ["<leader>cb"] = {
            function()
                require("Comment.api").toggle.blockwise.current()
            end,
            "Toggle block comment"
        },
        -- Copy to system clipboard
        ["<C-S-c>"] = {
            '"+y',
            "Copy to system clipboard"
        },
        -- Paste from system clipboard
        ["<C-S-v>"] = {
            '"+p',
            "Paste from system clipboard"
        },
    },
    -- Visual mode mappings
    v = {
        -- Toggle comment on selection
        ["<leader>/"] = {
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            "Toggle comment on selection"
        },
        -- Toggle block comment on selection
        ["<leader>cb"] = {
            "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>",
            "Toggle block comment on selection"
        },

        -- Copy to system clipboard
        ["<C-S-c>"] = {
            '"+y',
            "Copy to system clipboard"
        },
        -- Paste from system clipboard
        ["<C-S-v>"] = {
            '"+p',
            "Paste from system clipboard"
        },
        ["<leader>cf"] = {
            function()
                require("conform").format({ async = true })
            end,
            "Format buffer"
        },
    }
}

-- Additional editing utilities can go here
M.editing.n["<leader>cf"] = {
    function()
        vim.lsp.buf.format({ async = true })
    end,
    "Format document"
}

return M
