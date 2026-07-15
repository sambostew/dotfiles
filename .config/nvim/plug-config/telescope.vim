lua << EOF
require("telescope").setup({
    defaults = {
        -- All exclusions live in ~/.config/fd/ignore (gitignore syntax) so
        -- fd applies them at native speed. file_ignore_patterns intentionally
        -- empty — when populated with ~30 regexes it slowed picker startup
        -- noticeably because every streamed result was evaluated in Lua.
        find_command = { "fd", "--type", "f", "--exclude", ".git" },
        file_ignore_patterns = {},
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})
require("telescope").load_extension("fzf")
EOF

" Telescope keybindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
