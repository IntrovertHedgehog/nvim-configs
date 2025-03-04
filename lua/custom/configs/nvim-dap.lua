local dap = require "dap"

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

local gdb = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    pid = function()
      local name = vim.fn.input "Executable name (filter): "
      return require("dap.utils").pick_process { filter = name }
    end,
    cwd = "${workspaceFolder}",
  },
  {
    name = "Attach to gdbserver :1234",
    type = "gdb",
    request = "attach",
    target = "localhost:1234",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.c = gdb
dap.configurations.cpp = gdb
dap.configurations.rust = gdb

-- keymap
-- vim.keymap.set("n", "<F5>", dap.continue, { desc = "" })
-- vim.keymap.set("n", "<F9>", dap.step_over, { desc = "" })
-- vim.keymap.set("n", "<F10>", dap.step_into, { desc = "" })
-- vim.keymap.set("n", "<F11>", dap.step_out, { desc = "" })
-- vim.keymap.set("n", "<F12>", dap.step_back, { desc = "" })
-- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "" })
-- vim.keymap.set("n", "<leader>dp", function()
--   dap.set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
-- end, { desc = "" })
-- vim.keymap.set("n", "<leader>dB", dap.list_breakpoints, { desc = "" })
-- vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints, { desc = "" })
-- vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "" })
-- vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "" })
-- vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "" })
-- vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "" })
