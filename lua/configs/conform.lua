-- ~/.config/nvim/configs/conform.lua

local conform = require "conform"

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    python = { "black" },
    css = { "prettier" },
    html = { "prettier" },
    teal = { "tlint" },
    -- Add other formatters as needed
  },

  lang_to_ext = {
    bash = "sh",
    c_sharp = "cs",
    elixir = "exs",
    javascript = "js",
    julia = "jl",
    latex = "tex",
    markdown = "md",
    python = "py",
    ruby = "rb",
    rust = "rs",
    teal = "tl",
    typescript = "ts",
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
    async = false,
  },
}

conform.setup(options)

-- Function to format the current buffer
local function format_buffer()
  conform.format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  }
end

-- Set up autocommands for "format as you type"
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  callback = function()
    -- Use a timer to debounce the formatting
    if vim.b.format_timer then
      vim.fn.timer_stop(vim.b.format_timer)
    end
    vim.b.format_timer = vim.fn.timer_start(1000, function()
      format_buffer()
    end)
  end,
})
