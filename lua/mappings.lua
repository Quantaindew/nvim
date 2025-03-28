require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-a>", "ggVG", { desc = "Select all text" })

-- map("n", "<leader>h", ":split | terminal<CR>", { desc = "Open horizontal terminal" })
-- map("n", "<leader>v", ":vsplit | terminal<CR>", { desc = "Open vertical terminal" })
--

local function close_buffer()
  local bufnr = vim.api.nvim_get_current_buf() -- Get the current buffer number
  if vim.bo[bufnr].buftype == "terminal" then -- Check if it’s a terminal buffer
    local chan = vim.api.nvim_buf_get_var(bufnr, "terminal_job_id") -- Get the job ID
    if chan then
      vim.fn.jobstop(chan) -- Stop the terminal job
    end
  end
  vim.cmd "bdelete!" -- Delete the buffer
end

-- Map this function to a key of your choice (e.g., <leader>x)
map("n", "<leader>x", close_buffer, { desc = "Close buffer" })
