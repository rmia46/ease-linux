# 🚀 Neovim C++ Competitive Programming Master Guide

This repository provides a high-performance environment for C++ competitive programming.

## 🛠️ Automated Setup
To install or restore everything automatically, run the included `install.sh` script:

```bash
chmod +x ~/nvim-snippets/install.sh
~/nvim-snippets/install.sh
```

### What it does:
1.  **Snippets**: Deploys `cpp.lua` to `~/.config/nvim/lua/custom/snippets/`.
2.  **Options**: Configures `shiftwidth`, `tabstop`, and `expandtab` to 4 spaces in `options.lua`.
3.  **Mappings**: Injects `<leader>cc`, `<leader>cx`, `<leader>db`, and `<C-k>` into `mappings.lua`.

---

## ⚙️ Required Plugin Overrides
Add these entries to your `lua/plugins/init.lua` for full functionality.

### LuaSnip & nvim-cmp
```lua
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

    -- Ensure luasnip is in the sources
    opts.sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
    }

    -- Enable <Tab> for expansion
    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" })
    
    return opts
  end,
}
```

---

## ⌨️ Commands & Shortcuts

| Shortcut | Action |
| :--- | :--- |
| `<leader>cc` | **Compile & Run (Files)**: Redirects `input.txt` -> `output.txt` (incl. debug). |
| `<leader>cx` | **Compile & Run (Interactive)**: Runs in a horizontal terminal. |
| `<leader>db` | **Instant Debug**: Inserts `debug(word_under_cursor);` below. |
| `<C-k>` | **Manual Expansion**: Manual fallback for LuaSnip expansion. |

---

## 📝 Snippet Overview (Prefixes)

| Prefix | Description |
| :--- | :--- |
| `cp_base` | **Core Template**: `myrtle()`, `FASTIO`, `YES_NO`, and `debug(x)` macro. |
| `db` | **Manual Debug**: Inserts `debug(x);` |
| `dsu` | **DSU Struct**: Full Disjoint Set Union implementation. |
| `combi` | **Combinatorics**: Factorial pre-calculation logic. |
| `minpq` | **Smart Min-PQ**: Auto-mirrors types (e.g., `priority_queue<ll, vector<ll>, greater<ll>>`). |
| `custom_sort`| **Lambda Sort**: Inline `sort` with lambda comparator. |

---

## 📖 Related Guides
- **[SHORTCUTS.md](SHORTCUTS.md)**: Detailed guide on how to use snippets (type-mirroring, placeholders).
- **[MAPPINGS.md](MAPPINGS.md)**: Detailed explanation of the compilation and execution logic.
