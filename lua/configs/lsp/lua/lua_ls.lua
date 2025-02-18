local on_attach = require("configs.lsp").on_attach
local capabilities = require("configs.lsp").capabilities
local on_init = require("configs.lsp").on_init
require("lspconfig").lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = on_init,

    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand "$VIMRUNTIME/lua",
                    vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/luv/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
}
