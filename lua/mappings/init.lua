local merge = require("utils.merge")
local cheatsheet = require("plugins.custom.cheatsheet")
-- Initialize M once
local M = {}

function M.setup()
    local nav = require("mappings.nav")
    local ui = require("mappings.ui")
    local settings = require("mappings.settings")
    local editing = require("mappings.editing")

    M.keymaps = merge(nav, ui, settings, editing)

    M.keymaps.help = {
        n = {
            ["<leader>hh"] = {
                "<cmd>:help<CR>",
                "Help"
            },
            ["<leader>hk"] = {
                function()
                    require("which-key").show()
                end,
                "Open Which Key"
            },
            ["<leader>hc"] = {
                function()
                    require("mappings.cheatsheet").show_cheatsheet()
                end,
                "Open Cheatsheet"
            },
        }
    }


    M.apply()
end

function M.apply()
    local map = vim.keymap.set
    for name, maps in pairs(M.keymaps) do
        for mode, data in pairs(maps) do
            for key, val in pairs(data) do
                map(mode, key, val[1], { desc = val[2] })
            end
        end
    end
    cheatsheet.setup(M.keymaps)
end

-- Function to add new mappings without reinitializing
function M.add_mappings(new_mappings)
    M.keymaps = merge(M.keymaps, new_mappings)
    M.apply()
end

return M
