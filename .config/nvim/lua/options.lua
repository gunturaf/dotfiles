require "nvchad.options"

-- switch vim grep with ripgrep
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.g.go_metalinter_command = "golangci-lint"
vim.g.go_metalinter_enabled = {}

vim.o.rnu = true
vim.o.foldmethod = "expr"
vim.o.foldcolumn = "1"
vim.o.foldlevel = 10
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
