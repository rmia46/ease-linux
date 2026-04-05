# 🚀 Neovim C++ Competitive Programming Master Guide

This repository provides a high-performance environment for C++ competitive programming, now featuring **Competitest** and **Competitive Companion** integration.

## 🛠️ Automated Setup
To install or restore everything automatically, run the included `install.sh` script:

```bash
chmod +x ~/nvim-snippets/install.sh
~/nvim-snippets/install.sh
```

### What it does:
1.  **Snippets**: Deploys `cpp.lua` to `~/.config/nvim/lua/custom/snippets/`.
2.  **Options**: Configures 4-space tabs in `options.lua`.
3.  **Mappings**: Injects all Compile, Run, Debug, and Competitest shortcuts.
4.  **Plugins**: Registers `auto-session`, `LuaSnip`, `nvim-cmp`, and `competitest.nvim` in `plugins/init.lua`.

---

## ⌨️ Commands & Shortcuts

| Shortcut | Action |
| :--- | :--- |
| **Competitest** | |
| `<leader>tc` | **Receive Contest**: Import all problems from Competitive Companion. |
| `<leader>tp` | **Receive Problem**: Import a single problem. |
| `<leader>tr` | **Run Tests**: Execute all test cases and show UI. |
| `<leader>ta` | **Add Case**: Add a manual test case. |
| `<leader>te` | **Edit Case**: Modify an existing test case. |
| **Manual Tools** | |
| `<leader>cc` | **Compile & Run (Files)**: Redirects `input.txt` -> `output.txt`. |
| `<leader>cx` | **Compile & Run (Interactive)**: Runs in a horizontal terminal. |
| `<leader>db` | **Instant Debug**: Inserts `debug(word_under_cursor);`. |
| `<C-k>` | **Manual Expansion**: Manual fallback for LuaSnip. |

---

## 📝 Snippet Overview (Prefixes)

| Prefix | Description |
| :--- | :--- |
| `cp_base` | **Core Template**: `myrtle()`, `FASTIO`, `YES_NO`, and `debug(x)` macro. |
| `db` | **Manual Debug**: Inserts `debug(x);` |
| `dsu` | **DSU Struct**: Full Disjoint Set Union implementation. |
| `combi` | **Combinatorics**: Factorial pre-calculation logic. |
| `minpq` | **Smart Min-PQ**: Auto-mirrors types. |

---

## 📖 Related Guides
- **[SHORTCUTS.md](SHORTCUTS.md)**: Detailed guide on snippet usage.
- **[MAPPINGS.md](MAPPINGS.md)**: Detailed explanation of the compilation logic.
