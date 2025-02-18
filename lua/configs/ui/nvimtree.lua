local M = {}

M.renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
        glyphs = {
            default = "",
            folder = {
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
            },
            git = {
                unmerged = "",
            },
        }
    }
}

return M
