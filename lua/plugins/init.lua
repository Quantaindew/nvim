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
    opts = function()
      return require "configs.mason"
    end,
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
    config = function()
      --      require("nvchad.configs.lspconfig").defaults()
      --      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require "configs.treesitter"
    end,
  },

  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    config = function()
      require("configs.auto_save").setup()
    end,
  },
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("configs.copilot").setup()
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    cmd = "CopilotChat",
    config = function()
      require("CopilotChat").setup {
        -- Add any custom configuration here
      }
    end,
  },
}
