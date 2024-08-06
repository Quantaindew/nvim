-- ~/.config/nvim/lua/configs/nvimtree.lua
local config = function()
  require("nvim-tree").setup {
    git = {
      enable = true,
      ignore = false,
    },
    view = {
      width = 30,
    },
    renderer = {
      highlight_git = true,
      icons = {
        show = {
          git = true,
        },
      },
    },
  }
end

return { config = config }
