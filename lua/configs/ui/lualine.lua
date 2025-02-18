local seperatorTypes = {
    default = {
        section = { left = '', right = '' },
        component = { left = '', right = '' }
    },
    slant = {
        section = { left = '', right = '' },
        component = { left = '', right = '' }
    },
    arrow = {
        section = { left = '', right = '' },
        component = { left = '', right = '' }
    },
    curve = {
        section = { left = '', right = '' },
        component = { left = '', right = '' }
    },

}

local M = {
    options = {
        icons_enabled = true,
        component_separators = seperatorTypes.curve.component,
        section_separators = seperatorTypes.curve.section,
    },
    sections = {
        lualine_a = {
            {
                'mode',
                fmt = function(str)
                    if str == "NORMAL" then
                        return ' ' .. str
                    elseif str == "INSERT" then
                        return ' ' .. str
                    elseif str == "VISUAL" then
                        return '󰈈 ' .. str
                    elseif str == "V-LINE" then
                        return ' ' .. str
                    end
                end
            } -- Add icon before the mode text
        },

        lualine_x = {
            "copilot", "encoding", "fileformat"
        }
    }
}

return M
