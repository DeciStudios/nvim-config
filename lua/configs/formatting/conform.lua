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
    -- Replace format_on_save with format_after_save for async formatting
    format_after_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters = {
        odin_fmt = {
            command = "odinfmt",
            args = { "$FILENAME" },
            stdin = false,
        },
    },
}

return M
