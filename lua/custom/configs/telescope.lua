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
}

return options
