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

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Left Pane"},
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Right Pane"},
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Lower Pane"},
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Upper Pane"},
  }
}

return M
