local M = {}
M.nvimtree = {
  plugin = true,
  n = {
    ["]m"] = {
      function()
        require("nvim-tree.api").marks.navigate.next()
      end,
      "Next Bookmark",
    },
    ["[m"] = {
      function()
        require("nvim-tree.api").marks.navigate.prev()
      end,
      "Previous Bookmark",
    },
    ["\\m"] = {
      function()
        require("nvim-tree.api").marks.navigate.select()
      end,
      "Select Bookmark",
    },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ["<leader>Ra"] = { "<cmd>Lspsaga rename ++project<CR>", "Rename in Project" },
    ["<leader>wd"] = { "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Workspace Diagnostics" },
    ["<leader>K"] = { "<cmd>Lspsaga hover_doc ++keep<CR>", "Persistent Hover" },
    ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", "Code Actions" },
  },
}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Left Pane" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Right Pane" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Lower Pane" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Upper Pane" },
  },
}

return M
