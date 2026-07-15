-- Mason: UI for installing/managing LSP servers (:Mason to open)
-- Servers are currently installed via brew/system PATH.
-- To have mason manage a server instead, add its name to ensure_installed.
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = {} })

-- Advertise nvim-cmp completion capabilities to every server
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Keymaps applied per-buffer when an LSP client attaches
local on_attach = function(_, bufnr)
    local map = function(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc, silent = true })
    end

    -- Navigation
    map("n", "gd",          vim.lsp.buf.definition,      "Go to definition")
    map("n", "gy",          vim.lsp.buf.type_definition,  "Go to type definition")
    map("n", "gi",          vim.lsp.buf.implementation,   "Go to implementation")
    map("n", "gr",          vim.lsp.buf.references,       "Go to references")
    map("n", "K",           vim.lsp.buf.hover,            "Hover docs")

    -- Diagnostics
    map("n", "[g",          vim.diagnostic.goto_prev,     "Prev diagnostic")
    map("n", "]g",          vim.diagnostic.goto_next,     "Next diagnostic")

    -- Refactoring / actions
    map("n",          "<leader>rn", vim.lsp.buf.rename,      "Rename symbol")
    map({ "n", "x" }, "<leader>f",  vim.lsp.buf.format,      "Format")
    map({ "n", "x" }, "<leader>a",  vim.lsp.buf.code_action, "Code action")
    map("n",          "<leader>ac", vim.lsp.buf.code_action, "Code action")
    map("n",          "<leader>qf", vim.lsp.buf.code_action, "Quick fix")
    map("n",          "<leader>cl", vim.lsp.codelens.run,    "Code lens")

    -- Workspace via Telescope
    map("n", "<space>a", "<cmd>Telescope diagnostics<cr>",                   "All diagnostics")
    map("n", "<space>o", "<cmd>Telescope lsp_document_symbols<cr>",          "Document symbols")
    map("n", "<space>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols")
end

-- Diagnostics display
vim.diagnostic.config({
    signs            = true,
    underline        = true,
    update_in_insert = false,
    virtual_text     = { spacing = 4, prefix = "●" },
    float            = { border = "rounded" },
})

-- Global defaults: capabilities and on_attach applied to every enabled server
vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach    = on_attach,
})

-- Per-server overrides (lspconfig supplies cmd/filetypes/root_dir defaults)
vim.lsp.config("terraformls", {
    filetypes = { "terraform", "tf" },
})

vim.lsp.config("ansiblels", {
    settings = {
        ansible = {
            ansible    = { useFullyQualifiedCollectionNames = true },
            validation = { enabled = true, lint = { enabled = true } },
        },
    },
})

vim.lsp.config("pyright", {
    settings = {
        python = {
            analysis = {
                autoSearchPaths        = true,
                useLibraryCodeForTypes = true,
                diagnosticMode         = "openFilesOnly",
            },
        },
    },
})

vim.lsp.enable({ "terraformls", "ansiblels", "pyright", "bashls", "marksman" })

-- Completion
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args) vim.snippet.expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"]     = cmp.mapping.select_next_item(),
        ["<C-k>"]     = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-f>"]     = cmp.mapping.scroll_docs(4),
        ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-e>"]     = cmp.mapping.abort(),
        ["<TAB>"]     = cmp.mapping.confirm({ select = true }),
        ["<CR>"]      = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources(
        { { name = "nvim_lsp" } },
        { { name = "buffer" }, { name = "path" } }
    ),
    window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})
