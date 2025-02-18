-- lua/theme-selector/init.lua
local M = {}
local api = vim.api
local fn = vim.fn

-- Default config
local config = {
    themes = {},
    width = 60,
    height = 20,
    border = "rounded",
}

-- Function to save theme to data
local function save_theme(theme_name)
    local data_dir = vim.fn.stdpath('data')
    local theme_file = data_dir .. '/theme.txt'

    local file = io.open(theme_file, 'w')
    if file then
        file:write(theme_name)
        file:close()
    end
end

-- Load saved theme
local function load_saved_theme()
    local data_dir = vim.fn.stdpath('data')
    local theme_file = data_dir .. '/theme.txt'
    --SAVED IN ~/.local/share/nvim/theme.txt

    local file = io.open(theme_file, 'r')
    if file then
        local theme_name = file:read('*all')
        file:close()
        return theme_name
    end
    return nil
end

-- Apply theme
local function apply_theme(theme, is_preview)
    vim.cmd("colorscheme " .. theme.colorscheme)

    if not is_preview then
        save_theme(theme.colorscheme)
    end
end

-- Create the preview window
local function create_preview_window()
    local width = config.width
    local height = config.height

    -- Calculate position
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create buffers
    local search_buf = api.nvim_create_buf(false, true)
    local list_buf = api.nvim_create_buf(false, true)

    -- Window options
    local list_win_opts = {
        relative = 'editor',
        row = row,
        col = col,
        width = width,
        height = height - 3, -- Reduce height to make room for search
        style = 'minimal',
        title = "Themer",
        title_pos = "center",
        border = config.border,
    }

    local search_win_opts = {
        relative = 'editor',
        row = row + height - 2,
        col = col + 2,
        width = width - 4,
        height = 1,
        style = 'minimal',
        border = config.border,
    }

    -- Create windows
    local list_win = api.nvim_open_win(list_buf, false, list_win_opts)
    local search_win = api.nvim_open_win(search_buf, true, search_win_opts)

    -- Set window options
    api.nvim_win_set_option(list_win, 'cursorline', true)
    api.nvim_win_set_option(list_win, 'winhighlight', 'CursorLine:PmenuSel')

    -- Initialize search buffer with placeholder
    api.nvim_buf_set_lines(search_buf, 0, -1, false, { "" })

    return search_buf, list_buf, search_win, list_win
end

-- Show theme selector
function M.select_theme()
    local search_buf, list_buf, search_win, list_win = create_preview_window()
    local themes = config.themes
    local current_items = {}
    local search_text = ""

    -- Function to update buffer content
    local function update_buffer()
        current_items = {}
        local lines = {}

        for _, theme in ipairs(themes) do
            if theme.name:lower():find(search_text:lower(), 1, true) then
                table.insert(current_items, theme)
                table.insert(lines, theme.name)
            end
        end

        -- Set buffer modifiable before updating
        api.nvim_buf_set_option(list_buf, 'modifiable', true)
        api.nvim_buf_set_lines(list_buf, 0, -1, false, lines)
        api.nvim_buf_set_option(list_buf, 'modifiable', false)

        -- Keep cursor in bounds
        if #lines > 0 then
            local cursor = api.nvim_win_get_cursor(list_win)
            if cursor[1] > #lines then
                api.nvim_win_set_cursor(list_win, { #lines, 0 })
            end
        end
    end

    -- Initial content
    update_buffer()

    -- Make list buffer readonly
    api.nvim_buf_set_option(list_buf, 'modifiable', false)

    -- Enable insert mode in search buffer
    vim.cmd("startinsert")

    -- Set up keymaps
    local opts = { noremap = true, silent = true, callback = true }

    -- Search buffer keymaps
    api.nvim_buf_set_keymap(search_buf, 'i', '<CR>', '', {
        callback = function() _G.theme_selector_apply_current() end
    })
    api.nvim_buf_set_keymap(search_buf, 'i', '<Esc>', '', {
        callback = function() _G.theme_selector_close() end
    })
    api.nvim_buf_set_keymap(search_buf, 'i', '<Up>', '', {
        callback = function() _G.theme_selector_move_cursor(-1) end
    })
    api.nvim_buf_set_keymap(search_buf, 'i', '<Down>', '', {
        callback = function() _G.theme_selector_move_cursor(1) end
    })

    -- Update search on text change
    api.nvim_create_autocmd("TextChanged", {
        buffer = search_buf,
        callback = function()
            search_text = api.nvim_buf_get_lines(search_buf, 0, 1, false)[1]
            update_buffer()
        end
    })

    api.nvim_create_autocmd("TextChangedI", {
        buffer = search_buf,
        callback = function()
            search_text = api.nvim_buf_get_lines(search_buf, 0, 1, false)[1]
            update_buffer()
        end
    })

    -- Store windows for other functions
    M.current_windows = {
        search_win = search_win,
        list_win = list_win,
        current_items = current_items
    }

    -- Create global functions for callbacks
    _G.theme_selector_move_cursor = function(direction)
        local cursor = api.nvim_win_get_cursor(list_win)
        local new_pos = cursor[1] + direction
        local line_count = #current_items

        if new_pos >= 1 and new_pos <= line_count then
            api.nvim_win_set_cursor(list_win, { new_pos, 0 })
            local selected = current_items[new_pos]
            if selected then
                apply_theme(selected, true)
            end
        end
        vim.cmd("startinsert")
    end

    _G.theme_selector_apply_current = function()
        local cursor = api.nvim_win_get_cursor(list_win)
        local selected = current_items[cursor[1]]
        if selected then
            apply_theme(selected, false)
            api.nvim_win_close(search_win, true)
            api.nvim_win_close(list_win, true)
        end
    end

    _G.theme_selector_close = function()
        api.nvim_win_close(search_win, true)
        api.nvim_win_close(list_win, true)
    end
end

-- Setup function
function M.setup(opts)
    config = vim.tbl_deep_extend("force", config, opts or {})

    -- Create user command
    vim.api.nvim_create_user_command("ThemeSelect", M.select_theme, {})

    -- Load saved theme on startup
    local saved_theme = load_saved_theme()
    if saved_theme then
        for _, theme in ipairs(config.themes) do
            if theme.colorscheme == saved_theme then
                apply_theme(theme, false)
                break
            end
        end
    end
end

return M
