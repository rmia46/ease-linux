#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}==> Starting C++ CP Setup Automation...${NC}"

NVIM_CONFIG="$HOME/.config/nvim"
SNIPPETS_DIR="$NVIM_CONFIG/lua/custom/snippets"
BACKUP_DIR="$HOME/nvim-snippets"

# 1. Ensure Snippets Directory exists
echo -e "${BLUE}==> Setting up snippets directory...${NC}"
mkdir -p "$SNIPPETS_DIR"

# 2. Copy Snippets
echo -e "${BLUE}==> Deploying C++ snippets...${NC}"
cp "$BACKUP_DIR/snippets/cpp.lua" "$SNIPPETS_DIR/cpp.lua"

# 3. Update Options (4-space tabs)
echo -e "${BLUE}==> Updating indentation options...${NC}"
if ! grep -q "opt.shiftwidth = 4" "$NVIM_CONFIG/lua/options.lua"; then
    cat >> "$NVIM_CONFIG/lua/options.lua" <<EOF

-- C++ CP Indentation
local opt = vim.opt
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
EOF
fi

# 4. Update Mappings
echo -e "${BLUE}==> Injecting key mappings...${NC}"
if ! grep -q "C++ Compile and Run" "$NVIM_CONFIG/lua/mappings.lua"; then
    cat >> "$NVIM_CONFIG/lua/mappings.lua" <<EOF

-- C++ Compile and Run (Files)
vim.keymap.set("n", "<leader>cc", function()
  local file = vim.fn.expand("%")
  local out = vim.fn.expand("%:r")
  vim.fn.system("touch input.txt")
  local cmd = string.format("g++ -O2 -Wall %s -o %s && ./%s < input.txt > output.txt 2>&1", file, out, out)
  vim.cmd("! " .. cmd)
end, { desc = "C++ Compile and Run (Files)" })

-- C++ Compile and Run (Interactive)
vim.keymap.set("n", "<leader>cx", function()
  local file = vim.fn.expand("%")
  local out = vim.fn.expand("%:r")
  local cmd = string.format("g++ -O2 -Wall %s -o %s && ./%s", file, out, out)
  require("nvchad.term").toggle { pos = "sp", id = "cpp_run", cmd = cmd }
end, { desc = "C++ Compile and Run (Interactive)" })

-- Insert debug print for word under cursor
vim.keymap.set("n", "<leader>db", "odebug(<C-r><C-w>);<Esc>", { desc = "Insert C++ debug print" })

-- Manual Snippet Expansion fallback
vim.keymap.set("i", "<C-k>", function()
  require("luasnip").expand()
end, { desc = "Expand snippet" })
EOF
fi

echo -e "${GREEN}==> Setup Complete! Please restart Neovim.${NC}"
echo -e "${BLUE}==> Note: Ensure L3MON4D3/LuaSnip and hrsh7th/nvim-cmp are configured in your plugins/init.lua as described in README.md.${NC}"
