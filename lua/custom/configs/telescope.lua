local options = {
  pickers = {
    buffers = {
      mappings = {
        n = {
          ["dd"] = require("telescope.actions").delete_buffer,
        },
        i = {
          ["C-d"] = require("telescope.actions").delete_buffer,
        },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  extensions_list = { "themes", "terms", "fzf" },
}

return options
