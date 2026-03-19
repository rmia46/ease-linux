local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Function to mirror the first input node
local function mirror(args)
  return args[1][1]
end

return {
  -- Simplified Base Template
  s("cp_base", {
    t({"#include <bits/stdc++.h>", "using namespace std;", "using ll = long long;", "", ""}),
    t({"#define FASTIO() ios_base::sync_with_stdio(false); cin.tie(nullptr)", "#define YES_NO(v) (cout << (v ? \"YES\\n\" : \"NO\\n\"))", ""}),
    t({"#define all(x) (x).begin(), (x).end()", "#define sz(x) (int)(x).size()", "", ""}),
    t({"const int MOD = 1e9 + 7;", "", "void myrtle() {", "    "}),
    i(0),
    t({"", "}", "", "int main() {", "    FASTIO();", "    int t; cin >> t;", "    while(t--)", "        myrtle();", "    return 0;", "}"}),
  }),

  -- DSU Structure (Standalone)
  s("dsu", {
    t({"struct DSU {", ""}),
    t({"    vector<int> parent, rank;", ""}),
    t({"    DSU(int n) {", "        parent.resize(n + 1); rank.resize(n + 1, 0);"}),
    t({"        iota(all(parent), 0);", "    }", ""}),
    t({"    int find(int i) {", "        if (parent[i] == i) return i;"}),
    t({"        return parent[i] = find(parent[i]); // Path Compression", "    }", ""}),
    t({"    void unite(int i, int j) {", "        int root_i = find(i), root_j = find(j);"}),
    t({"        if (root_i != root_j) {", "            if (rank[root_i] < rank[root_j]) swap(root_i, root_j);"}),
    t({"            parent[root_j] = root_i;", "            if (rank[root_i] == rank[root_j]) rank[root_i]++;", "        }"}),
    t({"    }", "};", ""}),
  }),

  -- Combinatorics / Precompute (Standalone)
  s("combi", {
    t({"ll fact[200005];", ""}),
    t({"void precompute() {", "    fact[0] = 1;"}),
    t({"    for (int i = 1; i <= 200000; i++) fact[i] = (fact[i-1] * i) % MOD;", "}", ""}),
  }),

  -- Priority Queue (Standard)
  s("pq", {
    t("priority_queue<"), i(1, "int"), t("> "), i(2, "pq"), t(";"),
  }),

  -- Min-Priority Queue (Architectural Mirroring)
  s("minpq", {
    t("priority_queue<"), i(1, "int"), 
    t(", vector<"), f(mirror, {1}), 
    t(">, greater<"), f(mirror, {1}), 
    t(">> "), i(2, "pq"), t(";"),
  }),

  -- Custom Sort Template
  s("custom_sort", {
    t({"sort(all("}), i(1, "v"), t({")), [](const int &a, const int &b) {", ""}),
    t("    return "), i(2, "a < b"), t({";", ""}),
    t("});"),
  }),

  s("map", {
    t("map<"), i(1, "int"), t(", "), i(2, "int"), t("> "), i(3, "mp"), t(";"),
  }),

  -- Modular Exponentiation: expo(a, b, m)
  s("expo", {
    t({"long long expo(long long a, long long b, long long m) {", ""}),
    t({"    long long res = 1; a %= m;", ""}),
    t({"    while (b > 0) {", ""}),
    t({"        if (b & 1) res = (res * a) % m;", ""}),
    t({"        a = (a * a) % m; b >>= 1;", ""}),
    t({"    }", ""}),
    t({"    return res;", ""}),
    t("}"),
  }),

  -- GCD Snippet
  s("gcd", {
    t("long long gcd(long long a, long long b) { return b == 0 ? a : gcd(b, a % b); }"),
  }),

  -- O(1) Bit Counting
  s("bits", {
    t("__builtin_popcountll("), i(1, "n"), t(")")
  }),

  -- 2D Prefix Sum (1-Based Indexing)
  s("pref2d", {
    t({"for (int i = 1; i <= n; i++) {", ""}),
    t({"    for (int j = 1; j <= m; j++) {", ""}),
    t({"        pref[i][j] = a[i][j] + pref[i-1][j] + pref[i][j-1] - pref[i-1][j-1];", "    }"}),
    t({"", "}"}),
  }),
}
