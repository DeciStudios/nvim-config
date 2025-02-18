local M = {}

M["nvim-tree"] = {
    n = {
        ["<C-n>"] = {
            "<cmd>NvimTreeToggle<CR>",
            "Toggle NvimTree"
        },
        ["<C-f>"] = {
            "<cmd>NvimTreeFindFile<CR>",
            "Find file in NvimTree"
        },
        ["<leader>e"] = {
            "<cmd>NvimTreeFocus<CR>",
            "Focus NvimTree"
        },
        ["<A-<>"] = {
            "<cmd>BufferMovePrevious<CR>",
            "Move buffer left"
        },
        ["<A->>"] = {
            "<cmd>BufferMoveNext<CR>",
            "Move buffer right"
        },
        -- Goto buffer in position...
        ["<A-1>"] = {
            "<cmd>BufferGoto 1<CR>",
            "Go to buffer 1"
        },
        ["<A-2>"] = {
            "<cmd>BufferGoto 2<CR>",
            "Go to buffer 2"
        },
        ["<A-3>"] = {
            "<cmd>BufferGoto 3<CR>",
            "Go to buffer 3"
        },
        ["<A-4>"] = {
            "<cmd>BufferGoto 4<CR>",
            "Go to buffer 4"
        },
        ["<A-5>"] = {
            "<cmd>BufferGoto 5<CR>",
            "Go to buffer 5"
        },
        ["<A-6>"] = {
            "<cmd>BufferGoto 6<CR>",
            "Go to buffer 6"
        },
        ["<A-7>"] = {
            "<cmd>BufferGoto 7<CR>",
            "Go to buffer 7"
        },
        ["<A-8>"] = {
            "<cmd>BufferGoto 8<CR>",
            "Go to buffer 8"
        },
        ["<A-9>"] = {
            "<cmd>BufferGoto 9<CR>",
            "Go to buffer 9"
        },
        ["<A-0>"] = {
            "<cmd>BufferLast<CR>",
            "Go to last buffer"
        },
    }
}

M.buffer = {
    n = {
        ["<leader>x"] = {
            "<cmd>BufferClose<CR>",
            "Close current buffer"
        },
        ["<Tab>"] = {
            "<cmd>BufferNext<CR>",
            "Next buffer"
        },
        ["<S-Tab>"] = {
            "<cmd>BufferPrevious<CR>",
            "Previous buffer"
        }

    }
}

M.telescope = {
    n = {
        ["<leader>fw"] = {
            "<cmd>Telescope live_grep<CR>",
            "Find in files"
        },
        ["<leader>ff"] = {
            "<cmd>Telescope find_files<CR>",
            "Find files"
        },
        ["<leader>fa"] = {
            "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
            "Find in hidden files"
        },
        ["<leader>cd"] = {
            function()
                require("telescope").extensions.file_browser.file_browser()
            end,
            "Open file browser",
        },
    }
}

M.telescope.n["cd"] = M.telescope.n["<leader>cd"]
M.telescope.n["ff"] = M.telescope.n["<leader>ff"]

return M
