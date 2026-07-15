-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local result = vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { result, "WarningMsg" },
      { "\nPress any key to continue..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Shared dependencies
  { "nvim-lua/plenary.nvim",                    lazy = false },
  { "nvim-tree/nvim-web-devicons",              lazy = false },

  -- File explorer
  { "nvim-tree/nvim-tree.lua",                  lazy = false },

  -- Status line & tab bar
  { "nvim-lualine/lualine.nvim",                lazy = false },
  { "romgrk/barbar.nvim",                       lazy = false },

  -- Fuzzy finding
  { "nvim-telescope/telescope.nvim",            branch = "master", lazy = false },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = false },

  -- LSP
  { "neovim/nvim-lspconfig",                    lazy = false },
  { "williamboman/mason.nvim",                  lazy = false },
  { "williamboman/mason-lspconfig.nvim",        lazy = false },

  -- Completion
  { "hrsh7th/nvim-cmp",                         lazy = false },
  { "hrsh7th/cmp-nvim-lsp",                     lazy = false },
  { "hrsh7th/cmp-buffer",                       lazy = false },
  { "hrsh7th/cmp-path",                         lazy = false },

  -- Syntax / treesitter
  { "nvim-treesitter/nvim-treesitter",          build = ":TSUpdate", lazy = false },

  -- Git
  { "lewis6991/gitsigns.nvim",                   lazy = false },
  { "tpope/vim-fugitive",                       lazy = false },
  { "tpope/vim-rhubarb",                        lazy = false },
  { "junegunn/gv.vim",                          lazy = false },

  -- Motion / navigation
  { "folke/flash.nvim",                         lazy = false },
  { "unblevable/quick-scope",                   lazy = false },

  -- Linting
  { "mfussenegger/nvim-lint",                   lazy = false },

  -- UI enhancements
  { "lukas-reineke/indent-blankline.nvim",      lazy = false },
  { "folke/which-key.nvim",                     lazy = false },
  { "glepnir/dashboard-nvim",                   lazy = false },
  { "akinsho/toggleterm.nvim",                  lazy = false },

  -- Editing utilities
  { "numToStr/Comment.nvim",                    lazy = false },
  { "okuuva/auto-save.nvim",                    lazy = false },
  { "simnalamburt/vim-mundo",                   lazy = false },

  -- Language support
  { "pearofducks/ansible-vim",                  lazy = false },
  { "hashivim/vim-terraform",                   lazy = false },

  -- Markdown
  { "OXY2DEV/markview.nvim",                    lazy = false },

  -- Theme (priority ensures it loads before colorscheme is applied in themes/tokyonight.vim)
  { "folke/tokyonight.nvim",                    priority = 1000, lazy = false },

  -- i3 config filetype (Linux-only, remove after Hyprland migration)
  { "mboughaba/i3config.vim",                   ft = "i3config" },
})
