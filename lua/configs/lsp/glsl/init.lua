local on_attach = require("configs.lsp").on_attach
local capabilities = require("configs.lsp").capabilities
local lspconfig = require("lspconfig")

lspconfig.glsl_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "glsl", "frag", "vert" }, -- adjust this to the filetypes that glsl-analyzer should handle
})
