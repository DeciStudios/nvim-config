local lspconfig = require("lspconfig")
local on_attach = require("configs.lsp").on_attach
local capabilities = require("configs.lsp").capabilities

local setup = {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "python" },
}
lspconfig.pyright.setup(setup)
lspconfig.ruff.setup(setup)
