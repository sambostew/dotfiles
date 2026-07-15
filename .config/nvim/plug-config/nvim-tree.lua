require("nvim-tree").setup({
    view = {
        width = 30,
    },
    renderer = {
        icons = {
            show = {
                git          = true,
                folder       = true,
                file         = true,
                folder_arrow = true,
            },
            glyphs = {
                folder = {
                    arrow_closed = "▸",
                    arrow_open   = "▾",
                },
            },
        },
    },
    filters = {
        dotfiles = false,
        custom   = { "^\\.DS_Store$", ".*~$", ".*\\.swp$" },
    },
    git = {
        enable = true,
    },
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
})

-- Focus binding (leader-n toggle is registered in keys/which-key.vim)
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { silent = true, desc = "Focus file tree" })

-- Auto-close nvim when nvim-tree is the last window
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
            vim.cmd("quit")
        end
    end,
})
