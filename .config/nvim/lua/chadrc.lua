-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyodark",
  transparency = true,
  theme_toggle = { "tokyodark", "tokyonight" },
}

M.ui = {
  cmp = {
    style = "flat_dark",
  },

  statusline = {
    theme = "minimal",
  },

  nvdash = {
    load_on_startup = false,
    header = {
      "                                 ",
    },
    buttons = {
      { "  Find File", "<space> f f", "Telescope find_files" },
      { "X  Git", "<space> n g", "Neogit" },
      { "󰈚  Recent Files", "<space> f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      --   { "  Themes", "Spc t h", "Telescope themes" },
      --   { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

  telescope = {
    style = "bordered",
  },
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.mason = {
  pkgs = {
    "css-lsp",
    "deno",
    "golangci-lint",
    "golangci-lint-langserver",
    "google-java-format",
    "gopls",
    "html-lsp",
    "jdtls",
    "lua-language-server",
    "mdformat",
    "pyright",
    "ruff",
    "rust-analyzer",
    "sqlfluff",
    "stylua",
    "typescript-language-server",
  },
}

return M
