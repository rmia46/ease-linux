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
  -- Ensure input.txt exists
  vim.fn.system("touch input.txt")
  -- Compile and run, redirecting stderr (debug) to output.txt
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

> **Note**: These mappings assume `g++` is installed and accessible in your system PATH.
