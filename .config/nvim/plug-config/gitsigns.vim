lua << EOF
require("gitsigns").setup({
    signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(l, r, desc)
            vim.keymap.set("n", l, r, { buffer = bufnr, desc = desc })
        end

        map("<leader>gj", gs.next_hunk,                                 "Next hunk")
        map("<leader>gk", gs.prev_hunk,                                 "Prev hunk")
        map("<leader>gJ", function() gs.next_hunk({ count = 999 }) end, "Last hunk")
        map("<leader>gK", function() gs.prev_hunk({ count = 999 }) end, "First hunk")
    end,
})
EOF
