require("flash").setup({
    labels = "asdfghjklqwertyuiopzxcvbnm",
    label = {
        uppercase = false,
    },
    modes = {
        char = {
            enabled     = true,
            jump_labels = true,
        },
        search = {
            enabled = false,
        },
    },
})

vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end,       { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
