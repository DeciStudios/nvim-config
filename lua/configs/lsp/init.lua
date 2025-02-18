local M = {}
local capabilities = require('cmp_nvim_lsp').default_capabilities()

M.on_attach = function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    local keys = {
        n = {
            ["gD"] = { vim.lsp.buf.declaration, "Go to declaration" },
            ["gd"] = { vim.lsp.buf.definition, "Go to definition" },
            ["gi"] = { vim.lsp.buf.implementation, "Go to implementation" },
            ["<leader>sh"] = { vim.lsp.buf.signature_help, "Show signature help" },
            ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
            ["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
            ["<leader>wl"] = {
                function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end,
                "List workspace folders"
            },
            ["<leader>D"] = { vim.lsp.buf.type_definition, "Go to type definition" },
            ["gr"] = { vim.lsp.buf.references, "Show references" },
        },
        v = {
            ["<leader>ca"] = { vim.lsp.buf.code_action, "Code action" },
        },
    }

    require("mappings").add_mappings({ lsp = keys })
end

M.on_init = function(client, _)
    if client.supports_method "textDocument/semanticTokens" then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

-- Configure LSP handlers
require("configs.lsp.handlers").setup()

M.capabilities = capabilities
M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

return M
