local M = {}

M.copilot = {
    n = {
        ["<leader>gcc"] = {
            function()
                require("CopilotChat").open()
            end,
            "Open Copilot chat"
        },
        ["<leader>gco"] = {
            function()
                require("copilot").toggle()
            end,
            "Toggle Copilot"
        },
        ["<leader>gci"] = {
            function()
                require("CopilotChat").open({
                    window = {
                        layout = 'float',
                        relative = 'cursor',
                        width = 1,
                        height = 0.4,
                        row = 1,
                    }
                })
            end,
            "Open Copilot inline chat"
        }
    }
}


return M
