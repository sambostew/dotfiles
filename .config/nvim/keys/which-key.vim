" Map leader
let g:mapleader = "\<Space>"

lua << EOF
local wk = require("which-key")

wk.setup({
    win = {
        border = "rounded",
    },
})

wk.add({
    { "<leader>/", function() require("Comment.api").toggle.linewise.current() end, desc = "Comment" },
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Search files" },
    { "<leader>h", "<C-W>s", desc = "Split below" },
    { "<leader>v", "<C-W>v", desc = "Split right" },
    { "<leader>T", "<cmd>Telescope live_grep<cr>", desc = "Search text" },
    { "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    { "<leader>r", function()
        require("toggleterm.terminal").Terminal:new({ cmd = "yazi", direction = "float", hidden = true }):toggle()
      end, desc = "Yazi (file manager)" },

    { "<leader>s", group = "Search" },
    { "<leader>s/", "<cmd>Telescope search_history<cr>", desc = "Search history" },
    { "<leader>s;", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current buffer" },
    { "<leader>sB", "<cmd>Telescope buffers<cr>", desc = "Open buffers" },
    { "<leader>sc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
    { "<leader>sC", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer commits" },
    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Files" },
    { "<leader>sg", "<cmd>Telescope git_files<cr>", desc = "Git files" },
    { "<leader>sG", "<cmd>Telescope git_status<cr>", desc = "Modified git files" },
    { "<leader>sh", "<cmd>Telescope oldfiles<cr>", desc = "File history" },
    { "<leader>sH", "<cmd>Telescope command_history<cr>", desc = "Command history" },
    { "<leader>sl", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Lines" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>sM", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sp", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>sP", "<cmd>Telescope tags<cr>", desc = "Project tags" },
    { "<leader>sS", "<cmd>Telescope colorscheme<cr>", desc = "Color schemes" },
    { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Search text" },
    { "<leader>sT", "<cmd>Telescope current_buffer_tags<cr>", desc = "Buffer tags" },
    { "<leader>sw", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>sy", "<cmd>Telescope filetypes<cr>", desc = "File types" },

    { "<leader>l", ":MarkviewOpenLink<CR>", desc = "Open link" },
})
EOF
