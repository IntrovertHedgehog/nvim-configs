local options = {
  sync_root_with_cwd = false,
  git = {
    enable = true,
  },
  renderer = {
    root_folder_label = true,
    highlight_git = false,
    highlight_opened_files = "icon",

    indent_markers = {
      enable = true,
    },

    icons = {
      show = {
        git = true,
      },
    },
  },
}

return options
