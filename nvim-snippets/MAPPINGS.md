# C++ Compilation & Execution Mappings

Add these mappings to your `lua/mappings.lua` to enable rapid testing during contests.

## 1. File-Based I/O (`input.txt` -> `output.txt`)
**Shortcut**: `<leader>cc` (Normal Mode)
- **Action**: Compiles current file, creates `input.txt` if missing, and runs with redirection. **Note**: `stderr` is redirected to `output.txt` so `debug()` prints are visible.
- **Code**:
```lua
map("n", "<leader>cc", function()
  local file = vim.fn.expand("%")
  local out = vim.fn.expand("%:r")
  vim.fn.system("touch input.txt")
  local cmd = string.format("g++ -O2 -Wall %s -o %s && ./%s < input.txt > output.txt 2>&1", file, out, out)
  vim.cmd("! " .. cmd)
end, { desc = "C++ Compile and Run (Files)" })
```

## 2. Interactive Mode (Terminal Prompt)
**Shortcut**: `<leader>cx` (Normal Mode)
- **Action**: Compiles and runs in a togglable horizontal terminal for direct user input.
- **Code**:
```lua
map("n", "<leader>cx", function()
  local file = vim.fn.expand("%")
  local out = vim.fn.expand("%:r")
  local cmd = string.format("g++ -O2 -Wall %s -o %s && ./%s", file, out, out)
  require("nvchad.term").toggle { pos = "sp", id = "cpp_run", cmd = cmd }
end, { desc = "C++ Compile and Run (Interactive)" })
```

## 3. Competitest (Competitive Companion Integration)
**Shortcuts**:
- `<leader>tc`: Receive whole contest.
- `<leader>tp`: Receive single problem.
- `<leader>tr`: Run test cases.
- `<leader>ta`: Add test case.
- `<leader>te`: Edit test case.

**Code**:
```lua
map("n", "<leader>tc", "<cmd>Competitest receive contest<cr>", { desc = "Receive whole contest" })
map("n", "<leader>tp", "<cmd>Competitest receive problem<cr>", { desc = "Receive single problem" })
map("n", "<leader>tr", "<cmd>Competitest run<cr>", { desc = "Run test cases" })
map("n", "<leader>ta", "<cmd>Competitest add_testcase<cr>", { desc = "Add test case" })
map("n", "<leader>te", "<cmd>Competitest edit_testcase<cr>", { desc = "Edit test case" })
```

> **Note**: These mappings assume `g++` and `competitest.nvim` are installed and configured.
