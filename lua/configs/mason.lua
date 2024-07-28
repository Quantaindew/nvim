local config = {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },

  ensure_installed = {
    -- LSP
    "lua-language-server",
    "html-lsp",
    "css-lsp",
    "typescript-language-server",
    "pyright",
    "rust-analyzer",
    "zls",

    -- Linters
    "eslint_d",
    "flake8",

    -- Formatters
    "stylua",
    "prettier",
    "black",
    "rustfmt",
  },

  max_concurrent_installers = 10,
}

return config
