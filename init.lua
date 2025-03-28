vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    print("LSP started:", client.name)
  end,
})
--
-- -- Set bufhidden to "wipe" for terminal buffers
-- vim.api.nvim_create_autocmd("TermOpen", {
--   callback = function()
--     vim.opt_local.bufhidden = "wipe"
--   end,
-- })
--
-- -- Terminate the terminal job when the buffer is deleted
-- vim.api.nvim_create_autocmd("BufDelete", {
--   pattern = "term://*",
--   callback = function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     local chan = vim.api.nvim_buf_get_var(bufnr, "terminal_job_id")
--     if chan then
--       -- Send SIGTERM to the job
--       vim.fn.jobstop(chan)
--     end
--   end,
-- })
