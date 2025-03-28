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

```

## File: lazy-lock.json
```
{
  "CopilotChat.nvim": { "branch": "canary", "commit": "451d365928a994cda3505a84905303f790e28df8" },
  "LuaSnip": { "branch": "master", "commit": "c9b9a22904c97d0eb69ccb9bab76037838326817" },
  "NvChad": { "branch": "v2.5", "commit": "6f25b2739684389ca69ea8229386c098c566c408" },
  "auto-save.nvim": { "branch": "main", "commit": "29f793a3a7f98129387590269ffe3ad61ab5e509" },
  "base46": { "branch": "v2.5", "commit": "fde7a2cd54599e148d376f82980407c2d24b0fa2" },
  "cmp-buffer": { "branch": "main", "commit": "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
  "cmp-nvim-lsp": { "branch": "main", "commit": "99290b3ec1322070bcfb9e846450a46f6efa50f0" },
  "cmp-nvim-lua": { "branch": "main", "commit": "f12408bdb54c39c23e67cab726264c10db33ada8" },
  "cmp-path": { "branch": "main", "commit": "91ff86cd9c29299a64f968ebb45846c485725f23" },
  "cmp_luasnip": { "branch": "master", "commit": "98d9cb5c2c38532bd9bdb481067b20fea8f32e90" },
  "conform.nvim": { "branch": "master", "commit": "f9ef25a7ef00267b7d13bfc00b0dea22d78702d5" },
  "copilot.lua": { "branch": "master", "commit": "20723713aa5fbfd535fcf0cd28753a899ca3d526" },
  "friendly-snippets": { "branch": "main", "commit": "efff286dd74c22f731cdec26a70b46e5b203c619" },
  "gitsigns.nvim": { "branch": "main", "commit": "7010000889bfb6c26065e0b0f7f1e6aa9163edd9" },
  "indent-blankline.nvim": { "branch": "master", "commit": "005b56001b2cb30bfa61b7986bc50657816ba4ba" },
  "lazy.nvim": { "branch": "main", "commit": "6c3bda4aca61a13a9c63f1c1d1b16b9d3be90d7a" },
  "mason-lspconfig.nvim": { "branch": "main", "commit": "1a31f824b9cd5bc6f342fc29e9a53b60d74af245" },
  "mason.nvim": { "branch": "main", "commit": "fc98833b6da5de5a9c5b1446ac541577059555be" },
  "menu": { "branch": "main", "commit": "7769b17c2a131108c02b10e9f844e504aa605cc2" },
  "minty": { "branch": "main", "commit": "aafc9e8e0afe6bf57580858a2849578d8d8db9e0" },
  "nvim-autopairs": { "branch": "master", "commit": "6522027785b305269fa17088395dfc0f456cedd2" },
  "nvim-cmp": { "branch": "main", "commit": "1e1900b0769324a9675ef85b38f99cca29e203b3" },
  "nvim-lspconfig": { "branch": "master", "commit": "85e0dd26b710e834a105d679200d01e326a3d2b0" },
  "nvim-tree.lua": { "branch": "master", "commit": "44d9b58f11d5a426c297aafd0be1c9d45617a849" },
  "nvim-treesitter": { "branch": "master", "commit": "a3315b8c7f0f1ddaa30b24bcc0af0d31024dfb6a" },
  "nvim-web-devicons": { "branch": "master", "commit": "4c3a5848ee0b09ecdea73adcd2a689190aeb728c" },
  "plenary.nvim": { "branch": "master", "commit": "857c5ac632080dba10aae49dba902ce3abf91b35" },
  "telescope.nvim": { "branch": "master", "commit": "a4ed82509cecc56df1c7138920a1aeaf246c0ac5" },
  "ui": { "branch": "v3.0", "commit": "75233833d84b930bc37fecdcd7eb73b5714e92e4" },
  "volt": { "branch": "main", "commit": "21a2351697abfed26d4469b88d3ab124d55a1b3f" },
  "which-key.nvim": { "branch": "main", "commit": "370ec46f710e058c9c1646273e6b225acf47cbed" }
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
      -- require("lspconfig").teal_ls.setup {}
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

