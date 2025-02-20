local M = {}

-- Variable to store the last saved chat name
local last_saved_chat_name = nil

-- Create a centered floating window
local function create_float_win(title, width, height)
    local rows = vim.api.nvim_get_option("lines")
    local cols = vim.api.nvim_get_option("columns")

    local row = math.floor((rows - height) / 2)
    local col = math.floor((cols - width) / 2)

    local opts = {
        relative = 'editor',
        row = row,
        col = col,
        width = width,
        height = height,
        style = 'minimal',
        border = 'rounded',
        title = title,
        title_pos = 'center'
    }

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Set window options
    vim.api.nvim_win_set_option(win, 'wrap', false)
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'prompt')
    vim.api.nvim_buf_set_option(buf, 'modified', false)
    return buf, win
end

-- Load available chat files
local function get_chat_files()
    local chat_dir = vim.fn.stdpath("data") .. "/copilotchat_history"
    local files = {}
    local i = 1

    if vim.fn.isdirectory(chat_dir) == 1 then
        local handle = vim.loop.fs_scandir(chat_dir)
        if handle then
            while true do
                local name, type = vim.loop.fs_scandir_next(handle)
                if not name then break end
                if type == "file" and string.match(name, "%.json$") then
                    files[i] = string.gsub(name, "%.json$", "")
                    i = i + 1
                end
            end
        end
    end

    return files
end

-- Save chat window
function M.save_window()
    local buf, win = create_float_win("Save Chat", 40, 1)

    -- Set prompt
    local prompt_text = "Save as: "
    if last_saved_chat_name then
        prompt_text = prompt_text .. last_saved_chat_name
    end
    vim.fn.prompt_setprompt(buf, prompt_text)

    -- Handle input
    vim.keymap.set('i', '<CR>', function()
        local name = vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1]
        name = string.gsub(name, "Save as: ", "")
        if name and name ~= "" then
            require("CopilotChat").save(name)
            last_saved_chat_name = name -- Update the last saved chat name
            M.close(win, buf)
        end
    end, { buffer = buf })
    vim.keymap.set('n', 'q', function()
        M.close(win, buf)
    end, { buffer = buf })
    vim.keymap.set('i', "<ESC>", function()
        M.close(win, buf)
    end, { buffer = buf })
    -- Enter insert mode
    vim.cmd("startinsert!")
end

function M.close(win, buf)
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, { force = true })
    vim.cmd("stopinsert!")
end

-- Load chat window
function M.load_window()
    local files = get_chat_files()
    local height = #files + 2 -- Add some padding
    local buf, win = create_float_win("Load Chat", 40, height)

    -- Display available chats
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, files)

    -- Handle selection
    vim.keymap.set('n', '<CR>', function()
        local line = vim.api.nvim_get_current_line()
        if line and line ~= "" then
            require("CopilotChat").load(line)
            last_saved_chat_name = line -- Update the last saved chat name
            M.close(win, buf)
        end
    end, { buffer = buf })

    -- Handle closing
    vim.keymap.set('n', 'q', function()
        M.close(win, buf)
    end, { buffer = buf })

    vim.keymap.set('i', "<ESC>", function()
        M.close(win, buf)
    end, { buffer = buf })
end

function M.reset_saved_chat_name()
    last_saved_chat_name = nil
end

-- Main function to handle both save and load
function M.open_window(is_save)
    -- Ensure CopilotChat is open
    local chat = require("CopilotChat")
    chat.open()
    if is_save then
        M.save_window()
    else
        M.load_window()
    end
end

return M
