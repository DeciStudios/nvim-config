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

-- Function to save theme to a file
local function save_theme(theme_name)
    local data_dir = vim.fn.stdpath('data')
    local theme_file = data_dir .. '/theme.txt'

    local file = io.open(theme_file, 'w')
    if file then
        file:write(theme_name)
        file:close()
    end
end

-- Function to load saved theme
local function load_saved_theme()
    local data_dir = vim.fn.stdpath('data')
    local theme_file = data_dir .. '/theme.txt'

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
    -- Set colorscheme with error handling
    local ok = pcall(vim.cmd, "colorscheme " .. theme.colorscheme)
    if not ok then return end

    -- Only save and update lualine for final selection, not preview
    if not is_preview then
        save_theme(theme.colorscheme)

        -- Update lualine
        -- local status_ok, lualine = pcall(require, "lualine")
        -- if status_ok then
        --     lualine.setup({
        --         options = {
        --             theme = theme.colorscheme
        --         }
        --     })
        -- end
    end
end

-- Fuzzy match function
local function fuzzy_match(str, pattern)
    if pattern == "" then return true end
    local pattern_len = #pattern
    local str_len = #str
    local p_idx = 1
    local s_idx = 1
    local match = false

    str = str:lower()
    pattern = pattern:lower()

    while s_idx <= str_len and p_idx <= pattern_len do
        if str:sub(s_idx, s_idx) == pattern:sub(p_idx, p_idx) then
            if p_idx == pattern_len then
                match = true
                break
            end
            p_idx = p_idx + 1
        end
        s_idx = s_idx + 1
    end

    return match
end

-- Create the preview window with search box
local function create_preview_window()
    local width = config.width
    local height = config.height + 1 -- Add 1 for search box

    -- Calculate position
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create buffer
    local buf = api.nvim_create_buf(false, true)

    -- Set buffer options to prevent modifications
    api.nvim_buf_set_option(buf, 'modifiable', false)
    api.nvim_buf_set_option(buf, 'buftype', 'nofile')

    -- Window options
    local win_opts = {
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

    -- Create window
    local win = api.nvim_open_win(buf, true, win_opts)
    api.nvim_win_set_option(win, 'winblend', 0)
    api.nvim_win_set_option(win, 'cursorline', true)

    -- Create search buffer
    local search_buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_option(search_buf, 'buftype', 'prompt')
    api.nvim_buf_set_option(search_buf, 'bufhidden', 'hide')

    -- Create search window
    local search_win = api.nvim_open_win(search_buf, true, {
        relative = 'editor',
        row = row,
        col = col,
        width = width,
        height = 1,
        style = 'minimal',
        border = 'none',
    })

    -- Set up prompt
    vim.fn.prompt_setprompt(search_buf, 'Search: ')

    return buf, win, search_buf, search_win
end

-- Show theme selector
function M.select_theme()
    local buf, win, search_buf, search_win = create_preview_window()
    local themes = config.themes
    local current_items = {}

    -- Function to update buffer content with fuzzy search
    local function update_buffer(filter)
        current_items = {}
        local lines = {}

        for _, theme in ipairs(themes) do
            if fuzzy_match(theme.name, filter) then
                table.insert(current_items, theme)
                table.insert(lines, theme.name)
            end
        end

        -- Allow buffer modification temporarily
        api.nvim_buf_set_option(buf, 'modifiable', true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        api.nvim_buf_set_option(buf, 'modifiable', false)

        -- If we have filtered results, preview the first one
        if #current_items > 0 then
            apply_theme(current_items[1], true)
        end
    end

    -- Initial content
    update_buffer("")

    -- Store buffer-local variables
    vim.b[buf] = {
        current_items = current_items
    }

    -- Set up autocommand for search buffer changes
    vim.api.nvim_create_autocmd("TextChanged", {
        buffer = search_buf,
        callback = function()
            local search_text = vim.api.nvim_buf_get_lines(search_buf, 0, -1, false)[1]:gsub("^Search: ", "")
            update_buffer(search_text)
        end
    })

    vim.api.nvim_create_autocmd("TextChangedI", {
        buffer = search_buf,
        callback = function()
            local search_text = vim.api.nvim_buf_get_lines(search_buf, 0, -1, false)[1]:gsub("^Search: ", "")
            update_buffer(search_text)
        end
    })

    -- Handle navigation and selection
    vim.keymap.set('i', '<Up>', function()
        local idx = math.max(1, (api.nvim_win_get_cursor(win)[1] - 1))
        api.nvim_win_set_cursor(win, { idx, 0 })
        local selected = current_items[idx]
        if selected then
            apply_theme(selected, true)
        end
    end, { buffer = search_buf, noremap = true, silent = true })

    vim.keymap.set('i', '<Down>', function()
        local idx = math.min(#current_items, (api.nvim_win_get_cursor(win)[1] + 1))
        api.nvim_win_set_cursor(win, { idx, 0 })
        local selected = current_items[idx]
        if selected then
            apply_theme(selected, true)
        end
    end, { buffer = search_buf, noremap = true, silent = true })

    vim.keymap.set('i', '<CR>', function()
        local idx = api.nvim_win_get_cursor(win)[1]
        local selected = current_items[idx]
        if selected then
            apply_theme(selected, false)
            pcall(api.nvim_win_close, win, true)
            pcall(api.nvim_win_close, search_win, true)
            pcall(api.nvim_buf_delete, buf, { force = true })
            pcall(api.nvim_buf_delete, search_buf, { force = true })
        end
    end, { buffer = search_buf, noremap = true, silent = true })

    vim.keymap.set('i', '<Esc>', function()
        pcall(api.nvim_win_close, win, true)
        pcall(api.nvim_win_close, search_win, true)
        pcall(api.nvim_buf_delete, buf, { force = true })
        pcall(api.nvim_buf_delete, search_buf, { force = true })
    end, { buffer = search_buf, noremap = true, silent = true })

    -- Start in insert mode
    vim.cmd('startinsert')
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
