-- ~/.config/nvim/lua/configs/mason_lspconfig.lua
local M = {}

M.setup = function()
  require("mason-lspconfig").setup {
    ensure_installed = {},
    automatic_installation = true,
  }

  local lspconfig = require("lspconfig")
  local get_servers = require("mason-lspconfig").get_installed_servers

  local skip_servers = { "lua_ls" }

  for _, server_name in ipairs(get_servers()) do
    if not vim.tbl_contains(skip_servers, server_name) then
      lspconfig[server_name].setup {
        on_attach = require("nvchad.configs.lspconfig").on_attach,
        on_init = require("nvchad.configs.lspconfig").on_init,
        capabilities = require("nvchad.configs.lspconfig").capabilities,
      }
    end
  end

  -- Explicitly prevent lua_ls from being set up
  lspconfig.lua_ls.setup = function() end
end

return M
