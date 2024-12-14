-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"
local servers = { "html", "cssls", "pyright" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- lspconfig.denols.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
--   root_dir = lspconfig.util.root_pattern "yarn.lock",
-- }

-- typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern "tsconfig.json",
  single_file_support = false,
}

-- if not configs.golangcilsp then
--   configs.golangcilsp = {
--     default_config = {
--       cmd = { "golangci-lint-langserver" },
--       root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
--       init_options = {
--         command = {
--           "golangci-lint",
--           "run",
--           "--enable-all",
--           "--disable",
--           "lll",
--           "--out-format",
--           "json",
--           "--issues-exit-code=1",
--         },
--       },
--     },
--   }
-- end

lspconfig.golangci_lint_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  init_options = {
    command = { "golangci-lint", "run", "--fast", "--out-format", "json" },
  },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "gopls", "--remote=auto" },
  settings = {
    gopls = {
      buildFlags = { "-tags=integration" },
      semanticTokens = true,
      completeUnimported = true,
      usePlaceholders = true,
      hints = {
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        parameterNames = true,
        rangeVariableTypes = true,
        functionTypeParameters = true,
      },
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.jdtls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
