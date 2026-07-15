lua << EOF
require("auto-save").setup({
    enabled = true,
    trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
    },
    debounce_delay = 1000,
    condition = function(buf)
        local utils = require("auto-save.utils.data")
        if vim.fn.getbufvar(buf, "&modifiable") == 1 and
            utils.not_in(vim.fn.getbufvar(buf, "&filetype"), { "harpoon" }) then
            return true
        end
        return false
    end,
})
EOF
