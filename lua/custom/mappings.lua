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

return M
