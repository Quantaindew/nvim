-- ~/.config/nvim/lua/configs/lspconfig.lua

local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

-- List of servers to set up
local servers = {
  "html",
  "cssls",
  "zls",
  "tsserver",
  -- Add other servers you want to enable
}

-- List of servers to exclude
local excluded_servers = {
  -- "lua_ls",
  -- Add other servers you want to exclude
}

-- Function to check if a server should be excluded
local function should_exclude(server)
  for _, excluded in ipairs(excluded_servers) do
    if server == excluded then
      return true
    end
  end
  return false
end

-- Set up servers
for _, lsp in ipairs(servers) do
  if not should_exclude(lsp) then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }
  end
end

-- Explicitly prevent excluded servers from being set up
for _, excluded in ipairs(excluded_servers) do
  lspconfig[excluded].setup = function() end
end

-- You can still add custom configurations for specific servers if needed
-- For example:
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
--   -- Add any custom settings here
-- }
