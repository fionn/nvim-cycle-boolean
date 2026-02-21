local M = {}

local termcode = {
    inc = vim.api.nvim_replace_termcodes("<C-a>", true, false, true),
    dec = vim.api.nvim_replace_termcodes("<C-x>", true, false, true)
}

local true_to_false = {
        ["true"] = "false",
        ["True"] = "False",
        ["TRUE"] = "FALSE",
        ["on"] = "off",
        ["On"] = "Off",
        ["yes"] = "no",
        ["Yes"] = "No",
}

local false_to_true = {}
for t, f in pairs(true_to_false) do
    false_to_true[f] = t
end

---@return boolean
local function toggle_bool()
    local word = vim.fn.expand("<cword>")
    local negated = true_to_false[word] or false_to_true[word]

    if negated == nil then
        return false
    end

    local col = vim.api.nvim_win_get_cursor(0)[2]
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
    if vim.tbl_contains({"'", "\"", "`"}, char) then
        -- Due to the way ciw works, if we're on a quotation mark for a
        -- boolean-like string we'll replace the quotation mark instead of the
        -- string. It's simplest to detect this and bail if so. We return true
        -- since we don't want to fall back to standard increment/decrement in
        -- this case.
        return true
    end

    local view = vim.fn.winsaveview()
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
