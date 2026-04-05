#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}==> Starting C++ CP Setup Automation...${NC}"

# Detect where the script is currently located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NVIM_CONFIG="$HOME/.config/nvim"
SNIPPETS_DIR="$NVIM_CONFIG/lua/custom/snippets"

# 1. Ensure Snippets Directory exists
echo -e "${BLUE}==> Setting up snippets directory...${NC}"
mkdir -p "$SNIPPETS_DIR"

# 2. Copy Snippets
echo -e "${BLUE}==> Deploying C++ snippets...${NC}"
if [ -f "$SCRIPT_DIR/snippets/cpp.lua" ]; then
    cp "$SCRIPT_DIR/snippets/cpp.lua" "$SNIPPETS_DIR/cpp.lua"
    echo -e "${GREEN}==> Snippets deployed successfully.${NC}"
else
    echo -e "${RED}==> Error: Could not find snippets/cpp.lua in $SCRIPT_DIR${NC}"
    exit 1
fi

# 3. Update Options (4-space tabs)
echo -e "${BLUE}==> Updating indentation options...${NC}"
if [ -f "$NVIM_CONFIG/lua/options.lua" ]; then
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
fi

# 4. Update Mappings
echo -e "${BLUE}==> Injecting key mappings...${NC}"
if [ -f "$NVIM_CONFIG/lua/mappings.lua" ]; then
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

-- Competitest Mappings
vim.keymap.set("n", "<leader>tc", "<cmd>Competitest receive contest<cr>", { desc = "Receive whole contest" })
vim.keymap.set("n", "<leader>tp", "<cmd>Competitest receive problem<cr>", { desc = "Receive single problem" })
vim.keymap.set("n", "<leader>tr", "<cmd>Competitest run<cr>", { desc = "Run test cases" })
vim.keymap.set("n", "<leader>ta", "<cmd>Competitest add_testcase<cr>", { desc = "Add test case" })
vim.keymap.set("n", "<leader>te", "<cmd>Competitest edit_testcase<cr>", { desc = "Edit test case" })

-- Manual Snippet Expansion fallback
vim.keymap.set("i", "<C-k>", function()
  require("luasnip").expand()
end, { desc = "Expand snippet" })
EOF
    fi
fi

# 5. Update Plugins (Auto-Session, LuaSnip, nvim-cmp, Competitest)
echo -e "${BLUE}==> Injecting plugin configurations...${NC}"
PLUGINS_FILE="$NVIM_CONFIG/lua/plugins/init.lua"

if [ -f "$PLUGINS_FILE" ]; then
    if ! grep -q "xeluxee/competitest.nvim" "$PLUGINS_FILE"; then
        sed -i '$d' "$PLUGINS_FILE"
        cat >> "$PLUGINS_FILE" <<EOF
  {
    "xeluxee/competitest.nvim",
    dependencies = "muniftanjim/nui.nvim",
    lazy = false,
    opts = {
      received_files_extension = "cpp",
      received_problems_path = "\$(CWD)/\$(PROBLEM).\$(EXTENSION)",
      received_contests_directory = "\$(CWD)",
      received_contests_problems_path = "\$(PROBLEM).\$(EXTENSION)",
      compile_command = "g++ -O2 -Wall \$(FNAME) -o \$(FNOEXT)",
      run_command = "./\$(FNOEXT)",
    },
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/", "~/Documents", "~/Pictures" },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    config = function(_, opts)
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/custom/snippets" }
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      opts.sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      }
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
        else fallback() end
      end, { "i", "s" })
      return opts
    end,
  },
}
EOF
        echo -e "${GREEN}==> Plugins registered successfully.${NC}"
    fi
fi

echo -e "${GREEN}==> Setup Complete! Everything is installed and configured.${NC}"
echo -e "${BLUE}==> Please restart Neovim to apply changes.${NC}"
