local options = {
  sync_root_with_cwd = false,
  git = {
    enable = true,
  },
  renderer = {
    root_folder_label = function(cwd)
      local len = 3
      local head = vim.fn.fnamemodify(cwd, ":~:h")
      local path = vim.fn.fnamemodify(cwd, ":~:t")
      for _ = 1, len - 1 do
        local tail = vim.fn.fnamemodify(head, ":t")
        if tail == "." or tail == "" then
          break
        end
        head = vim.fn.fnamemodify(head, ":h")
        path = tail .. "/" .. path
      end
      if head == "~" then
        return "~/" .. path
      end
      if head == "." then
        return path
      end
      if head == "/" then
        return "/" .. path
      end
      return "../" .. path
    end,

    indent_markers = {
      enable = true,
    },

    icons = {
      show = {
        git = true,
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
}

return options
