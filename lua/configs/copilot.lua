-- ~/config/nvim/lua/configs/copilot.lua

local M = {}

M.setup = function()
  require("copilot").setup {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        accept_word = "<M-w>",
        accept_line = "<M-L>",
        next = "<Tab>",
        prev = "<S-Tab>",
        dismiss = "<C-]>",
      },
    },
    panel = {
      enabled = true,
      auto_refresh = true,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>",
      },
      layout = {
        position = "bottom",
        ratio = 0.4,
      },
    },
    filetypes = {
      ["*"] = true, -- Enable for all filetypes
      [""] = function()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
          return false
        end
        return true
      end,
    },
    copilot_node_command = "node", -- or use the path to your Node.js executable
    server_opts_overrides = {},
  }

  -- Custom keymapping to handle Tab behavior
  vim.keymap.set("i", "<Tab>", function()
    if require("copilot.suggestion").is_visible() then
      require("copilot.suggestion").next()
    else
      return "<Tab>"
    end
  end, { expr = true, silent = true })

  vim.keymap.set("i", "<S-Tab>", function()
    if require("copilot.suggestion").is_visible() then
      require("copilot.suggestion").prev()
    else
      return "<S-Tab>"
    end
  end, { expr = true, silent = true })
end

return M
