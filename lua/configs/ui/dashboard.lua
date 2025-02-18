--[[




--]]

local M = {

    header = {
        -- "    ▄▄▄                                  ▄▄     ▄ ▄▄   ▄▄ ",
        -- "  ▄▀▀   ▀▀▄                              █  █  █ █  █ █  █",
        -- " █       ▄▄█ ██████  ███████ ██████ ██  █   █▄█ █  █▄█  █",
        -- "█    ▄▄▀▀    ██   ██ ██      ██     ██  █       █       █",
        -- "▀▄     ▀▀▄▄▄ ██   ██ █████   ██     ██  █  ▄    █       █",
        -- " ▀▄       ▄▀ ██   ██ ██      ██     ██  █ █ █   ██     █ ",
        -- "   ▀▀▄▄▄▀▀   ██████  ███████ ██████ ██  █▄█  █▄▄█ █▄▄▄█  ",
        -- ""
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "     ▄▄▄       ▄▄    ▄ ▄▄   ▄▄ ",
        "  ▄▀▀   ▀▀▄   █  █  █ █  █ █  █",
        " █       ▄▄█  █   █▄█ █  █▄█  █",
        "█    ▄▄▀▀     █       █       █",
        "▀▄     ▀▀▄▄▄  █  ▄    █       █",
        " ▀▄       ▄▀  █ █ █   ██     █ ",
        "   ▀▀▄▄▄▀▀    █▄█  █▄▄█ █▄▄▄█  ",
        "                               ",
        "DeciDev's vim Config",
        "(To exit, just power off your computer)",
        ""
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
            desc = "Open File Browser",
            desc_hl = "String",
            key = "d",
            key_hl = "Number",
            action = function()
                require("telescope").extensions.file_browser.file_browser()
            end,
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
            desc = "Enter Config",
            desc_hl = "String",
            key = "c",
            key_hl = "Number",
            action = function()
                vim.cmd("cd ~/.config/nvim/")
                vim.notify("Moved to nvim config directory. Have fun!")
            end
        },
    },
    footer = {
        "",
        "== Fortnite Quote of the Day ==",
        '"' .. require("plugins.custom.fnquote").quote_of_the_day() .. '"',
        "",
        "",
        "Total Plugins:" .. require("lazy").stats().count,
    }
}

return M
