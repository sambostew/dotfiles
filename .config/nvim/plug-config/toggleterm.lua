require("toggleterm").setup({
    direction       = "float",
    close_on_exit   = true,
    start_in_insert = true,
    float_opts = {
        border = "curved",
        width  = function() return math.floor(vim.o.columns * 0.8) end,
        height = function() return math.floor(vim.o.lines * 0.8) end,
    },
})

-- <Leader>t  toggle primary terminal
-- <F4>       toggle secondary terminal (equivalent to floaterm "new")
-- <F2>       switch to secondary terminal (next)
-- <F3>       switch back to primary terminal (prev)
vim.keymap.set({ "n", "t" }, "<Leader>t", "<cmd>1ToggleTerm<cr>", { desc = "Toggle terminal" })
vim.keymap.set({ "n", "t" }, "<F4>",      "<cmd>2ToggleTerm<cr>", { desc = "New terminal" })
vim.keymap.set({ "n", "t" }, "<F2>",      "<cmd>2ToggleTerm<cr>", { desc = "Next terminal" })
vim.keymap.set({ "n", "t" }, "<F3>",      "<cmd>1ToggleTerm<cr>", { desc = "Prev terminal" })
