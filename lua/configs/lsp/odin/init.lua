local on_attach = require("configs.lsp").on_attach
local capabilities = require("configs.lsp").capabilities

local lspconfig = require("lspconfig")
lspconfig.ols.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "odin" }, -- adjust this to the filetypes that OLS should handle
})
