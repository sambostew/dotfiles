lua << EOF
require("tokyonight").setup({
    style                  = "night",
    transparent            = true,
    styles                 = {
        comments  = { italic = true },
        keywords  = { italic = true },
        functions = {},
        variables = {},
        sidebars  = "transparent",
        floats    = "transparent",
    },
    on_highlights = function(hl, c)
        -- Underline the word under cursor (matches arch tokyonight_current_word setting)
        hl.LspReferenceText  = { underline = true }
        hl.LspReferenceRead  = { underline = true }
        hl.LspReferenceWrite = { underline = true }
    end,
})
EOF

colorscheme tokyonight
