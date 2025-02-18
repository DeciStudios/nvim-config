local M = {

    header = {
        "                                                                     ",
        "                                                                     ",
        "██████╗ ███████╗ ██████╗██╗██╗   ██╗██╗███╗   ███╗                 ",
        "██╔══██╗██╔════╝██╔════╝██║██║   ██║██║████╗ ████║                 ",
        "██║  ██║█████╗  ██║     ██║██║   ██║██║██╔████╔██║                 ",
        "██║  ██║██╔══╝  ██║     ██║╚██╗ ██╔╝██║██║╚██╔╝██║                 ",
        "██████╔╝███████╗╚██████╗██║ ╚████╔╝ ██║██║ ╚═╝ ██║                 ",
        "╚═════╝ ╚══════╝ ╚═════╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝                 ",
        "                                                                     ",
        "                                                                     "
    },
    center = {
        {
            icon = " ",
            icon_hl = "Title",
            desc = "Find File",
            desc_hl = "String",
            key = "f",
            key_hl = "Number",
            action = "Telescope find_files"
        },
        {
            icon = " ",
            icon_hl = "Title",
            desc = "Find Text",
            desc_hl = "String",
            key = "w",
            key_hl = "Number",
            action = "Telescope live_grep"
        },
        {
            icon = " ",
            icon_hl = "Title",
            desc = "Recent Files",
            desc_hl = "String",
            key = "r",
            key_hl = "Number",
            action = "Telescope oldfiles"
        },
        {
            icon = " ",
            icon_hl = "Title",
            desc = "Config",
            desc_hl = "String",
            key = "c",
            key_hl = "Number",
            action = "e ~/.config/nvim/init.lua"
        },
    },
    footer = {
        "",
        "🚀 Have fun with neovim",
        "   Total Plugins: " .. require("lazy").stats().count,
    }
}

return M
