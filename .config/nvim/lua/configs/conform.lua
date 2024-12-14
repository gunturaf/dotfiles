local options = {
  formatters_by_ft = {
    css = { "prettierd" },
    cue = { "cue_fmt" },
    go = { "gofumpt", "goimports" },
    html = { "prettierd" },
    java = { "google-java-format" },
    js = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    lua = { "stylua" },
    md = { "mdformat" },
    proto = { "buf" },
    python = { "ruff_format" },
    rs = { "rustfmt" },
    sql = { "sqlfluff" },
    toml = { "taplo" },
    ts = { "prettierd" },
    tsx = { "biome" },
    typescript = { "prettierd" },
    yaml = { "prettierd" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 5000,
    lsp_fallback = false,
  },
}

require("conform").setup(options)
