-- ~/.config/nvim/lua/configs/auto_save.lua

local M = {}

M.setup = function()
  require("auto-save").setup {
    trigger_events = { -- See :h events
      immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
      defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
    },
    debounce_delay = 1500, -- delay after which a pending save is executed
    callbacks = {
      before_saving = function()
        -- Call conform.format() before saving
        require("conform").format { timeout_ms = 500, lsp_fallback = true }
      end,
    },
  }
end

return M
