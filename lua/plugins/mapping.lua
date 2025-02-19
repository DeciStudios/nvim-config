local M = {
    {
        "DeciStudios/mapper-cheatsheet.nvim"
    },
    {
        "DeciStudios/mapper.nvim",
        config = function()
            require("mappings")
        end
    }
}

return M
