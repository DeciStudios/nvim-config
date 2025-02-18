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

    -- Create main window and buffer
    local main_buf = api.nvim_create_buf(false, true)
    local main_win_opts = {
        relative = 'editor',
        row = row,
        col = col,
        width = width,
        height = height,
        style = 'minimal',
        title = "Themer",
        title_pos = "center",
        border = config.border,
    }
    local main_win = api.nvim_open_win(main_buf, true, main_win_opts)

    -- Create search buffer and window inside main window
    local search_buf = api.nvim_create_buf(false, true)
    local search_win_opts = {
        relative = 'win',
        win = main_win,
        row = 1,
        col = 2,
        width = width - 4,
        height = 1,
        style = 'minimal',
    }
    local search_win = api.nvim_open_win(search_buf, true, search_win_opts)

    -- Create list buffer and window below search
    local list_buf = api.nvim_create_buf(false, true)
    local list_win_opts = {
        relative = 'win',
        win = main_win,
        row = 3,
        col = 2,
        width = width - 6, -- Reduced width to accommodate scrollbar
        height = height - 5,
        style = 'minimal',
    }
    local list_win = api.nvim_open_win(list_buf, false, list_win_opts)

    -- Set window options
    api.nvim_win_set_option(list_win, 'cursorline', true)
    api.nvim_win_set_option(list_win, 'winhighlight', 'CursorLine:PmenuSel')
    api.nvim_win_set_option(list_win, 'number', false)
    api.nvim_win_set_option(list_win, 'signcolumn', 'no')

    -- Initialize search buffer with placeholder
    api.nvim_buf_set_lines(search_buf, 0, -1, false, { "" })

    return search_buf, list_buf, search_win, list_win, main_win
end

-- Show theme selector
function M.select_theme()
    local search_buf, list_buf, search_win, list_win, main_win = create_preview_window()
    local themes = config.themes
    local current_items = {}
    local search_text = ""
    local current_theme = vim.g.colors_name
    local previewing_theme = current_theme

    -- Function to update buffer content
    local function update_buffer()
        current_items = {}
        local lines = {}

        for _, theme in ipairs(themes) do
            if theme.name:lower():find(search_text:lower(), 1, true) then
                table.insert(current_items, theme)
                local line = theme.name
                if theme.colorscheme == current_theme then
                    line = "* " .. line
                end
                if theme.colorscheme == previewing_theme then
                    line = "> " .. line
                end
                table.insert(lines, line)
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
        main_win = main_win,
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
                previewing_theme = selected.colorscheme
                apply_theme(selected, true)
                update_buffer()
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
            api.nvim_win_close(main_win, true)
        end
    end

    _G.theme_selector_close = function()
        api.nvim_win_close(search_win, true)
        api.nvim_win_close(list_win, true)
        api.nvim_win_close(main_win, true)
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
