local utils = require "custom.utils"
local M = {}

M.disabled = {
  n = {
    ["<leader>ca"] = "",
    ["<leader>e"] = "",
  },
}

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
    ["<leader>D"] = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definition" },
    ["<leader>s"] = { "<cmd>Lspsaga outline<CR>", "Peek Definition" },
  },
}

M.tmux_navigation = {
  plugin = true,
  n = {
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Left Pane" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Right Pane" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Lower Pane" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Upper Pane" },
  },
}

M.general = {
  n = {
    ["<leader>o"] = {
      require("custom.configs.tmux-attach").open_picker,
    },
    ["<leader>u"] = {
      require("custom.configs.tmux-attach").send_cmd,
      "Execute current line in selected tmux pane",
    },
  },
  v = {
    ["<leader>u"] = {
      require("custom.configs.tmux-attach").send_cmd_vis,
      "Execute current line in selected tmux pane",
    },
  },
}

return M
