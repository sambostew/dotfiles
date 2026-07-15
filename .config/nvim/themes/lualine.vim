lua << EOF
require("lualine").setup({
    options = {
        theme = "tokyonight",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "diagnostics", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})

-- barbar: pill-shaped tabs using powerline rounded caps (U+E0B6 / U+E0B4),
-- retinted from catppuccin mocha → tokyonight night palette (purple accent).
require("barbar").setup({
    animation = false,
    auto_hide = false,
    tabpages = true,
    clickable = true,
    icons = {
        buffer_index = true,
        button = "",
        diagnostics = { [vim.diagnostic.severity.ERROR] = { enabled = false } },
        gitsigns = { added = { enabled = false }, changed = { enabled = false }, deleted = { enabled = false } },
        filetype = { enabled = true },
        separator = { left = "\u{E0B6}", right = "\u{E0B4}" },
        separator_at_end = false,
        modified = { button = "\u{25CF}" },
        pinned = { button = "\u{F147}", filename = true },
        inactive = { separator = { left = "\u{E0B6}", right = "\u{E0B4}" } },
        visible = { separator = { left = "\u{E0B6}", right = "\u{E0B4}" } },
    },
})

local set_hl = vim.api.nvim_set_hl
local pink   = "#bb9af7"  -- tokyonight purple (mauve-equivalent accent)
local base   = "#1a1b26"  -- tokyonight bg (tab text on active)
local pill   = "#292e42"  -- tokyonight bg_highlight (inactive tab body)
local text   = "#c0caf5"  -- tokyonight fg
local muted  = "#565f89"  -- tokyonight comment
local warn   = "#e0af68"  -- tokyonight yellow (modified marker)

-- Active buffer (pink pill)
set_hl(0, "BufferCurrent",        { fg = base, bg = pink, bold = true })
set_hl(0, "BufferCurrentIndex",   { fg = base, bg = pink, bold = true })
set_hl(0, "BufferCurrentNumber",  { fg = base, bg = pink, bold = true })
set_hl(0, "BufferCurrentMod",     { fg = warn, bg = pink, bold = true })
set_hl(0, "BufferCurrentSign",    { fg = pink, bg = "NONE" })
set_hl(0, "BufferCurrentIcon",    { fg = base, bg = pink })
set_hl(0, "BufferCurrentTarget",  { fg = base, bg = pink, bold = true })

-- Visible (split-shown but not focused) — same surface1 pill as inactive
set_hl(0, "BufferVisible",        { fg = text, bg = pill })
set_hl(0, "BufferVisibleIndex",   { fg = text, bg = pill })
set_hl(0, "BufferVisibleNumber",  { fg = text, bg = pill })
set_hl(0, "BufferVisibleMod",     { fg = warn, bg = pill })
set_hl(0, "BufferVisibleSign",    { fg = pill, bg = "NONE" })
set_hl(0, "BufferVisibleIcon",    { fg = text, bg = pill })
set_hl(0, "BufferVisibleTarget",  { fg = text, bg = pill, bold = true })

-- Inactive buffer
set_hl(0, "BufferInactive",       { fg = muted, bg = pill })
set_hl(0, "BufferInactiveIndex",  { fg = muted, bg = pill })
set_hl(0, "BufferInactiveNumber", { fg = muted, bg = pill })
set_hl(0, "BufferInactiveMod",    { fg = warn, bg = pill })
set_hl(0, "BufferInactiveSign",   { fg = pill, bg = "NONE" })
set_hl(0, "BufferInactiveIcon",   { fg = muted, bg = pill })
set_hl(0, "BufferInactiveTarget", { fg = muted, bg = pill, bold = true })

-- Tabline background / fill area between & after buffers
set_hl(0, "BufferTabpageFill",    { fg = pill, bg = "NONE" })
set_hl(0, "BufferTabpages",       { fg = text, bg = "NONE" })
EOF

set laststatus=2
set showtabline=2
set noshowmode
