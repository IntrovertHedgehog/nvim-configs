local M = {}

M.open_picker = function()
  local utils = require "custom.utils"
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  local panes = utils.tmux_capture()
  pickers
    .new({}, {
      prompt_title = "attach tmux pane",
      finder = finders.new_table {
        results = panes,
        entry_maker = function(entry)
          return { value = entry, display = entry[1], ordinal = entry[1] }
        end,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(bf, map)
        actions.select_default:replace(function()
          actions.close(bf)
          local selection = action_state.get_selected_entry()
          vim.b.target_tmux_pane = selection["value"][2]
        end)
        return true
      end,
    })
    :find()

  vim.b.target_tmux_pane = "side:5.3"
end

M.send_cmd = function()
  if vim.b.target_tmux_pane == nil then
    return vim.notify("No tmux pane attached to this buffer", 4)
  end
  local cmd = vim.api.nvim_buf_get_lines(0, vim.fn.getcurpos()[2] - 1, vim.fn.getcurpos()[2], false)[1]
  cmd = cmd:gsub('"', '\\"')
  -- vim.cmd('silent! !tmux send-keys -t "' .. vim.b.target_tmux_pane .. '" "' .. cmd .. '" Enter')
  os.execute('tmux send-keys -t "' .. vim.b.target_tmux_pane .. '" "' .. cmd .. '" Enter')
end

M.send_cmd_vis = function()
  if vim.b.target_tmux_pane == nil then
    return vim.notify("No tmux pane attached to this buffer", 4)
  end

  local vst = vim.fn.getpos "v"
  local ven = vim.fn.getpos "."
  if vst[2] > ven[2] or (vst[2] == ven[2] and vst[3] > ven[3]) then
    vst, ven = ven, vst
  end

  local text = {}
  local mode = vim.fn.mode()
  if mode == "v" then
    text = vim.api.nvim_buf_get_text(0, vst[2] - 1, vst[3] - 1, ven[2] - 1, ven[3], {})
  elseif mode == "V" then
    text = vim.api.nvim_buf_get_lines(0, vst[2] - 1, ven[2], false)
  elseif mode == "\22" then
    if vst[3] > ven[3] then
      vst[3], ven[3] = ven[3], vst[3]
    end

    local uncut_text = vim.api.nvim_buf_get_lines(0, vst[2] - 1, ven[2], false)
    for _, v in ipairs(uncut_text) do
      print(v)
      table.insert(text, v:sub(vst[3], ven[3]))
    end
  end

  vim.g.log = { vst, ven, text, mode }

  for _, cmd in ipairs(text) do
    cmd = cmd:gsub('"', '\\"')
    os.execute('tmux send-keys -t "' .. vim.b.target_tmux_pane .. '" "' .. cmd .. '" Enter')
  end

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "v", false)
end

return M
