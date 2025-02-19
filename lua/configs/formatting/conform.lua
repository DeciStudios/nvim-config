local M = {
    formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        odin = { "odin_fmt" },
        -- Add a fallback formatter for unknown filetypes
        ["*"] = { "trim_whitespace", "trim_newlines" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true, -- This is important
        async = true,
    },
    formatters = {
        odin_fmt = {
            command = "odin",
            args = { "fmt", "$FILENAME" },
            stdin = false,
        },
    },
}

return M
