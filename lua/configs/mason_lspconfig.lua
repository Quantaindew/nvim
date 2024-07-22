-- ~/.config/nvim/lua/configs/mason_lspconfig.lua
local M = {}

M.setup = function()
  require("mason-lspconfig").setup {
    ensure_installed = {
      -- "lua_ls" is removed from here
      -- Add other language servers you want to ensure are installed
    },
    automatic_installation = true,
  }

  require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      -- Skip setup for lua_ls
      if server_name ~= "lua_ls" then
        require("lspconfig")[server_name].setup {
          on_attach = require("nvchad.configs.lspconfig").on_attach,
          on_init = require("nvchad.configs.lspconfig").on_init,
          capabilities = require("nvchad.configs.lspconfig").capabilities,
        }
      end
    end,
  }
  -- Explicitly disable lua_ls
  require("lspconfig").lua_ls.setup = function() end
end

return M
