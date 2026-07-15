local lint = require("lint")

lint.linters_by_ft = {
    python   = { "ruff" },
    markdown = { "markdownlint-cli2" },
    sh       = { "shellcheck" },
    bash     = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
