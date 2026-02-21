local M = {}

local termcode = {
    inc = vim.api.nvim_replace_termcodes("<C-a>", true, false, true),
    dec = vim.api.nvim_replace_termcodes("<C-x>", true, false, true)
}

local negation_map = {
    ["true"] = "false",
    ["false"] = "true",
    ["True"] = "False",
    ["False"] = "True"
}

---@return boolean
local function toggle_bool()
    local negated = negation_map[vim.fn.expand("<cword>")]
    if negated == nil then
        return false
    end

    local view = vim.fn.winsaveview()

    local char = vim.api.nvim_get_current_line():sub(view.col + 1, view.col + 1)
    if vim.tbl_contains({"'", "\"", "`"}, char) then
        -- Due to the way ciw works, if we're on a quotation mark for a
        -- boolean-like string we'll replace the quotation mark instead of the
        -- string. It's simplest to detect this and bail if so. We return true
        -- since we don't want to fall back to standard increment/decrement in
        -- this case.
        return true
    end

    vim.cmd("normal! \"_ciw" .. negated)
    vim.fn.winrestview(view)
    return true
end

---@param key string
---@return nil
local function toggle_and_fallback(key)
    if not toggle_bool() then
        vim.cmd("normal! " .. key)
    end
end

---@return nil
function M.increment()
    toggle_and_fallback(termcode["inc"])
end

---@return nil
function M.decrement()
    toggle_and_fallback(termcode["dec"])
end

return M
