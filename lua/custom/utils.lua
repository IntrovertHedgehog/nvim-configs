M = {}

M.split = function(inp, sep) sep = sep or "%s"
  local t = {}
  for str in string.gmatch(inp, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

M.capture = function(cmd, raw)
  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read "*a")
  f:close()
  if raw then
    return s
  end
  s = string.gsub(s, "^%s+", "")
  s = string.gsub(s, "%s+$", "")
  return M.split(s, "\n")
end

M.tmux_capture = function()
  local raw_panes = M.capture('tmux list-panes -a -F "#S:#I[#W].#P #{pane_current_path} #{pane_pid} #D"', false)
  local processes_panes = {}
  for _, pane in ipairs(raw_panes) do
    -- comp: pane_name dir pid pane_id
    local comp = M.split(pane, " ")
    local _, dir = comp[2]:match "(.*/)(.*)"
    local cmdlist = M.capture("ps --ppid " .. comp[3] .. " -o comm", true):sub(9, -2):gsub("\n", " -")
    table.insert(processes_panes, {comp[1] .. " /" .. dir .. " | -" .. cmdlist, comp[4]})
  end
  return processes_panes
end

return M
