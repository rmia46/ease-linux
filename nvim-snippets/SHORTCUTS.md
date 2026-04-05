# C++ Snippets Usage Guide

This guide explains how to use the competitive programming snippets in your Neovim environment.

## 1. General Controls
- **Trigger**: Type the **Prefix** and press `<Tab>`.
- **Navigate Forward**: Press `<Tab>` to jump to the next placeholder.
- **Navigate Backward**: Press `<S-Tab>` to go back to the previous placeholder.
- **Exit Snippet**: Once you reach the last placeholder (usually marked `i(0)` in code), typing will resume normal editing.

---

## 2. Snippet Reference

### 🚀 Base Templates & Tools
| Prefix | Description |
| :--- | :--- |
| `cp_base` | **Simplified Template**: Includes `myrtle()`, `FASTIO`, `YES_NO`, and **`debug(x)` macro**. |
| `db` | **Debug Print**: Inserts `debug(x);` standalone. |
| `dsu` | **DSU Struct**: Inserts the full Disjoint Set Union structure with path compression and rank union. |
| `combi` | **Combinatorics**: Inserts `fact[]` array and `precompute()` function for factorials. |

### 📦 STL Containers & Algorithms
| Prefix | Description |
| :--- | :--- |
| `pq` | Standard Priority Queue: `priority_queue<int> pq;` |
| `minpq` | **Smart Min-Priority Queue**: Type the data type once, and it automatically updates all fields. |
| `map` | Standard Map: `map<int, int> mp;` |
| `custom_sort` | Inline Lambda Sort: `sort(all(v), [](const int &a, const int &b) { return a < b; });` |

### 🔢 Number Theory & Math
| Prefix | Description |
| :--- | :--- |
| `expo` | Modular Exponentiation: `long long expo(a, b, m)` function. |
| `gcd` | GCD Function: `long long gcd(a, b)` using recursion. |
| `bits` | Popcount: `__builtin_popcountll(n)` for counting set bits. |
| `pref2d` | 2D Prefix Sum: Generates nested loops for 1-based 2D prefix sums. |

---

## 3. Examples

### Using `cp_base`
1. Type `cp_base` and press `<Tab>`.
2. Start coding your logic inside the `myrtle()` function immediately.

### Adding DSU or Combinatorics
If a problem requires advanced tools:
1. Move your cursor above the `myrtle()` function.
2. Type `dsu` or `combi` and press `<Tab>`.
3. If using `combi`, remember to add a call to `precompute();` inside your `main` or `myrtle` function.

### Using `debug(x)` Shortcut
1. Place cursor on a variable name in Normal mode.
2. Press **`<leader>db`**.
3. A new line is created below with `debug(variable_name);`. This works perfectly with both terminal and file-based output (`output.txt`).
