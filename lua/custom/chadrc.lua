local M = {}
M.ui = {
  theme = "tokyodark",
  tabufline = { enabled = false },
  statusline = {
    overriden_modules = function(modules)
      local cursor_position = function()
        local current_line = vim.fn.line(".", vim.g.statusline_winid)
        local current_col = vim.fn.col(".", vim.g.statusline_winid)
        local total_line = vim.fn.line("$", vim.g.statusline_winid)
        local text = "| " .. current_line .. ":" .. current_col .. "/" .. total_line
        return text
      end
      modules[10] = modules[10] .. cursor_position()
    end,
  },
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
