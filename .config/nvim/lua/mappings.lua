require "nvchad.mappings"

-- disable nvchad term
vim.keymap.del("n", "<leader>h")
vim.keymap.del("n", "<leader>v")
-- disable nvchad tree
vim.keymap.del("n", "<leader>e")

local map = vim.keymap.set
-- local cuscmd = vim.api.nvim_create_user_command

map("n", "<leader>e", "<cmd>Oil --float<CR>", { desc = "Oil: Open" })
map("n", ";", ":", { desc = "Enter CMD mode" })
map("i", "jk", "<ESC>", { desc = "Quit INSERT mode" })

-- webify

map(
  "n",
  "<leader>wy",
  "<cmd>YankLineUrl +<cr>",
  { desc = "Webify: Yank Url to system clipboard, including current line" }
)

-- Telescope
--
map("n", "<leader>tfn", "<cmd>Telescope treesitter<CR>", { desc = "Telescope: Function names, variables." })
map("n", "<leader>tgb", "<cmd>Telescope git_branches<CR>", { desc = "Telescope: Git branches" })
map("n", "<leader>rw", ":lua require('telescope.builtin').lsp_references()<CR>", { desc = "Telescope: LSP refs" })
map("n", "<leader>iw", ":lua require('telescope.builtin').lsp_implementations()<CR>", { desc = "Telescope: LSP impls" })
map(
  "n",
  "<leader>fg",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "Telescope: Advanced Live Grep" }
)

-- Git
--
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit: open" })
map("n", "<leader>gc", "<cmd>Neogit commit<CR>", { desc = "Neogit: interactive commit" })
map("n", "<leader>gp", "<cmd>!git pull<CR>", { desc = "Git: pull" })

map("n", "<leader>gmt", function()
  local packagePath = vim.api.nvim_buf_get_name(0):match "(.*[/\\])"
  local output = vim.system({ "go", "mod", "tidy" }, { cwd = packagePath, text = true }):wait()
  vim.print("Tidying go.mod @ " .. packagePath .. "...")
  if output.code ~= 0 then
    vim.print("Failed to tidy go.mod at " .. packagePath .. ", error = " .. output.stderr)
  else
    local str = "Tidy go.mod @ " .. packagePath .. " success"
    if output.stdout:len() == 0 then
      str = str .. "!"
    else
      str = str .. output.stdout
    end
    vim.print(str)
  end
end, { desc = "Go: tidy go.mod" })

local gitsigns = require "gitsigns"

map("n", "<leader>gd", gitsigns.diffthis)
map("n", "<leader>gb", gitsigns.blame_line, { desc = "Git: Show blame for this line" })
map("n", "<leader>gB", gitsigns.toggle_current_line_blame, { desc = "Git: Show blame" })
map("n", "<leader>cs", gitsigns.stage_hunk, { desc = "Git: Stage hunk" })
map("n", "<leader>cS", gitsigns.stage_buffer, { desc = "Git: Stage buffer" })
map("n", "<leader>cx", gitsigns.undo_stage_hunk, { desc = "Git: Undo stage hunk" })
map("n", "<leader>cr", gitsigns.reset_hunk, { desc = "Git: Reset hunk" })
map("n", "<leader>cR", gitsigns.reset_buffer, { desc = "Git: Reset buffer" })
map("v", "<leader>cs", function()
  gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Git: Stage stage hunk the selected line" })
map("v", "<leader>cx", function()
  gitsigns.undo_stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Git: Undo stage hunk at selected line" })
map("v", "<leader>cr", function()
  gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Git: Reset hunk at selected line" })

map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.nav_hunk "next"
  end
end, { desc = "Git: Go to next hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    gitsigns.nav_hunk "prev"
  end
end)

map(
  "n",
  "<leader>glk",
  ":!git fetch -p ; git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D<CR>",
  { desc = "Git remove unused local branches." }
)

-- Debug Adapter Protocol (DAP)
--
local dap = require "dap"
map("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
map("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
map("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
map("n", "<F12>", dap.step_out, { desc = "DAP: Step out" })
map("n", "<leader>dab", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP: Add breakpoint" })
map("n", "<leader>dau", function()
  require("dapui").toggle()
end, { desc = "DAP: Open UI" })

map("n", "<leader>map", "<cmd> e ~/.config/nvim/lua/mappings.lua<CR>", { desc = "Editor: Edit Mappings" })

-- tmux
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<CR>")
map("n", "<c-j>", "<cmd>TmuxNavigateDown<CR>")
map("n", "<c-k>", "<cmd>TmuxNavigateUp<CR>")
map("n", "<c-l>", "<cmd>TmuxNavigateRight<CR>")
map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<CR>")

-- harpoon
local harpoon = require "harpoon"
harpoon:setup {}

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

map("n", "<leader>ha", function()
  harpoon:list():add()
end)
map("n", "<leader>hn", function()
  harpoon:list():next()
end)
map("n", "<leader>hp", function()
  harpoon:list():prev()
end)
map("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Telescope: harpoon list" })
