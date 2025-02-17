local M = {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        setup = function()
            require('lualine').setup {
                options = {
                    theme = 'onedark'
                }
            }
        end
    }
}
return M
