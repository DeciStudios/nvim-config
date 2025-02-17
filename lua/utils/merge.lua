local function merge(...)
    local M = {}
    for _, module in ipairs({ ... }) do
        for k, v in pairs(module) do
            M[k] = v
        end
    end
    return M
end

return merge
