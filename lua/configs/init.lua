vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.diagnostic.disable(0)
    local clients = vim.lsp.get_active_clients({bufnr = 0})
    for _, client in ipairs(clients) do
      if client.name == "lua_ls" then
        vim.lsp.stop_client(client.id)
      end
    end
  end,
})
