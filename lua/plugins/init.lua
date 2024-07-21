return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  --  These are some examples, uncomment them if you want to see them work!
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "rust-analyzer",
        "rustfmt",
        "zls", -- Zig Language Server, which includes zigfmt
        "typescript-language-server",
        "pyright",
        "black", -- Python language server and formatter
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("configs.mason_lspconfig").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    --  config = function()
    --      require("nvchad.configs.lspconfig").defaults()
    --      require "configs.lspconfig"
    --      end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
  },

  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    config = function()
      require("configs.auto_save").setup()
    end,
  },
}
