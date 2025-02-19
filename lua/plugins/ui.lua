local M = {
    {
        "nvim-tree/nvim-web-devicons",
        opts = {}
    },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        opts = function()
            return require("configs.ui.nvimtree")
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        init = function()
            require('lualine').setup(require("configs.ui.lualine"))
        end
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = function()
            return require("configs.ui.barbar")
        end,
        version = '^1.0.0',
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    {
        "rcarriga/nvim-notify",
        init = function()
            vim.notify = require("notify")
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = "Telescope",
        opts = require("configs.ui.telescope")
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        init = function()
            require("telescope").load_extension("file_browser")
        end,
        config = function()
            local fb_actions = require "telescope".extensions.file_browser.actions
            local actions = require "telescope.actions"
            local actions_state = require("telescope.actions.state")

            require("telescope").setup({
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                -- your custom insert mode mappings
                                ["<C-e>"] = function(prompt_bufnr) -- Ctrl+Enter in most cases
                                    local picker = actions_state.get_current_picker(prompt_bufnr)
                                    if not picker then return end

                                    fb_actions.change_cwd(prompt_bufnr)
                                    actions.close(prompt_bufnr)
                                end
                            },
                            ["n"] = {
                                -- your custom normal mode mappings
                                ["<Space>"] = function(prompt_bufnr)
                                    local picker = actions_state.get_current_picker(prompt_bufnr)
                                    if not picker then return end -- Prevent errors if there's no active picker

                                    fb_actions.change_cwd(prompt_bufnr)
                                    actions.close(prompt_bufnr)
                                end
                            },
                        },
                    },
                },
            })
        end
    },

    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("dashboard").setup({
                theme = 'doom',
                config = require("configs.ui.dashboard")
            })
        end
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require("toggleterm").setup(require("configs.ui.terminal.opts"))
        end
    },

}
return M
