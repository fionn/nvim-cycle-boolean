if vim.g.loaded_cycle_boolean then
    return
end

vim.g.loaded_cycle_boolean = true

vim.keymap.set("n", "<C-a>", function() require("cycle_boolean").increment() end, {desc = "Increment"})
vim.keymap.set("n", "<C-x>", function() require("cycle_boolean").decrement() end, {desc = "Decrement"})
