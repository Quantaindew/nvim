# Codebase Contents
## Project Structure
```
.
├── LICENSE
├── init.lua
├── lazy-lock.json
├── letter.md
└── lua
    ├── chadrc.lua
    ├── configs
    │   ├── auto_save.lua
    │   ├── conform.lua
    │   ├── copilot.lua
    │   ├── lazy.lua
    │   ├── lspconfig.lua
    │   ├── mason.lua
    │   ├── mason_lspconfig.lua
    │   ├── nvim_tree.lua
    │   └── treesitter.lua
    ├── mappings.lua
    ├── options.lua
    └── plugins
        └── init.lua

4 directories, 17 files
```

## File: LICENSE
```
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <https://unlicense.org>

```

## File: init.lua
```
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

```

## File: lazy-lock.json
```
{
  "CopilotChat.nvim": { "branch": "canary", "commit": "9333944fde3c65868818e245c73aa29eef826e9b" },
  "LuaSnip": { "branch": "master", "commit": "e808bee352d1a6fcf902ca1a71cee76e60e24071" },
  "NvChad": { "branch": "v2.5", "commit": "a69f893e49ee36d4c74431044b40f08042c396a2" },
  "auto-save.nvim": { "branch": "main", "commit": "5fe9ab0c42f0457f2a973e814a6352b8eeb04730" },
  "base46": { "branch": "v2.5", "commit": "177af7c0e492f6332bf78675a47b8983b1a32291" },
  "cmp-buffer": { "branch": "main", "commit": "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
  "cmp-nvim-lsp": { "branch": "main", "commit": "39e2eda76828d88b773cc27a3f61d2ad782c922d" },
  "cmp-nvim-lua": { "branch": "main", "commit": "f12408bdb54c39c23e67cab726264c10db33ada8" },
  "cmp-path": { "branch": "main", "commit": "91ff86cd9c29299a64f968ebb45846c485725f23" },
  "cmp_luasnip": { "branch": "master", "commit": "05a9ab28b53f71d1aece421ef32fee2cb857a843" },
  "conform.nvim": { "branch": "master", "commit": "40d4e98fcc3e6f485f0e8924c63734bc7e305967" },
  "copilot.lua": { "branch": "master", "commit": "1a237cf50372830a61d92b0adf00d3b23882e0e1" },
  "friendly-snippets": { "branch": "main", "commit": "de8fce94985873666bd9712ea3e49ee17aadb1ed" },
  "gitsigns.nvim": { "branch": "main", "commit": "863903631e676b33e8be2acb17512fdc1b80b4fb" },
  "indent-blankline.nvim": { "branch": "master", "commit": "e7a4442e055ec953311e77791546238d1eaae507" },
  "lazy.nvim": { "branch": "main", "commit": "1159bdccd8910a0fd0914b24d6c3d186689023d9" },
  "mason-lspconfig.nvim": { "branch": "main", "commit": "25c11854aa25558ee6c03432edfa0df0217324be" },
  "mason.nvim": { "branch": "main", "commit": "e2f7f9044ec30067bc11800a9e266664b88cda22" },
  "menu": { "branch": "main", "commit": "ea606f6ab2430db0aece8075e62c14132b815ae1" },
  "minty": { "branch": "main", "commit": "8809b2c7c2edbeb3fa9c3b05bd2e89934d54f526" },
  "nvim-autopairs": { "branch": "master", "commit": "ee297f215e95a60b01fde33275cc3c820eddeebe" },
  "nvim-cmp": { "branch": "main", "commit": "ae644feb7b67bf1ce4260c231d1d4300b19c6f30" },
  "nvim-lspconfig": { "branch": "master", "commit": "04680101ff79e99b4e33a4386ec27cbd0d360c75" },
  "nvim-tree.lua": { "branch": "master", "commit": "50e919426a4a2053f78b2f8ab001c8ad8eb47ef6" },
  "nvim-treesitter": { "branch": "master", "commit": "86c10df7ef77daf45a0e4a918934bb59083db1e1" },
  "nvim-web-devicons": { "branch": "master", "commit": "56f17def81478e406e3a8ec4aa727558e79786f3" },
  "plenary.nvim": { "branch": "master", "commit": "2d9b06177a975543726ce5c73fca176cedbffe9d" },
  "telescope.nvim": { "branch": "master", "commit": "dc6fc321a5ba076697cca89c9d7ea43153276d81" },
  "ui": { "branch": "v3.0", "commit": "63bb4e0b62027dac87542453ced15d5e7b524d8a" },
  "volt": { "branch": "main", "commit": "43f72b49037c191eb3cfe26ba7a5574b4bfce226" },
  "which-key.nvim": { "branch": "main", "commit": "8badb359f7ab8711e2575ef75dfe6fbbd87e4821" }
}

```

## File: lua/chadrc.lua
```
-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "ayu_dark",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

return M

```

## File: lua/configs/auto_save.lua
```
-- ~/.config/nvim/lua/configs/auto_save.lua

local M = {}

M.setup = function()
  require("auto-save").setup {
    execution_message = {
      enabled = false, -- disable the execution message
    },
    trigger_events = { -- See :h events
      immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
      defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
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

```

## File: lua/configs/conform.lua
```
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

```

## File: lua/configs/copilot.lua
```
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

```

## File: lua/configs/lazy.lua
```
return {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}

```

## File: lua/configs/lspconfig.lua
```
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

```

## File: lua/configs/mason.lua
```
local config = {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },

  ensure_installed = {
    -- LSP
    "lua-language-server",
    "html-lsp",
    "css-lsp",
    "typescript-language-server",
    "pyright",
    "rust-analyzer",
    "zls",

    -- Linters
    "eslint_d",
    "flake8",

    -- Formatters
    "stylua",
    "prettier",
    "black",
    "rustfmt",
  },

  max_concurrent_installers = 10,
}

return config

```

## File: lua/configs/mason_lspconfig.lua
```
-- ~/.config/nvim/lua/configs/mason_lspconfig.lua

local M = {}

M.setup = function()
  require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer" },
    automatic_installation = true,
  }

  local lspconfig = require "lspconfig"
  local get_servers = require("mason-lspconfig").get_installed_servers

  local skip_servers = {
    -- "lua_ls",
  }

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

```

## File: lua/configs/nvim_tree.lua
```
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

```

## File: lua/configs/treesitter.lua
```
local config = {
  ensure_installed = {
    "vim",
    "lua",
    "vimdoc",
    "html",
    "css",
    "javascript",
    "typescript",
    "python",
    "rust",
    "zig",
    "teal",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },

  autotag = { enable = true },

  context_commentstring = { enable = true, enable_autocmd = false },

  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
  },
}

return config

```

## File: lua/mappings.lua
```
require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

```

## File: lua/options.lua
```
require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

```

## File: lua/plugins/init.lua
```
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  --  These are some examples, uncomment them if you want to see them work!
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = function()
      return require "configs.mason"
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("configs.mason_lspconfig").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      --      require("nvchad.configs.lspconfig").defaults()
      --      require "configs.lspconfig"
      require("lspconfig").teal_ls.setup {}
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require "configs.treesitter"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
      require("configs.nvim_tree").config()
    end,
  },

  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    config = function()
      require("configs.auto_save").setup()
    end,
  },
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("configs.copilot").setup()
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    cmd = "CopilotChat",
    config = function()
      require("CopilotChat").setup {
        -- Add any custom configuration here
      }
    end,
  },

  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   build = "make",
  --   opts = {
  --     -- add any opts here
  --   },
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below is optional, make sure to setup it properly if you have lazy=true
  --     {
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}

```

