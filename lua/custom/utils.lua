local M = {}

M.split = function(inp, sep)
  sep = sep or "%s"
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
  -- using * as dilimiter, do not use this as name
  local raw_panes = M.capture('tmux list-panes -a -F "#S:#I[#W].#P*/#{b:pane_current_path}*#{pane_pid}*#D"', false)

  local ppid = {}
  for _, pane in ipairs(raw_panes) do
    local comp = M.split(pane, "*")
    table.insert(ppid, comp[3])
  end
  local ppid_str = table.concat(ppid, ",")
  local ps_result = M.capture("ps --pid " .. ppid_str .. " -o ppid,comm --no-headers", false)
  local ppid_to_pid = {}
  for _, pid in ipairs(ps_result) do
    local t = M.split(pid, " ")
    local a = t[1]
    local b = t[2]
    if ppid_to_pid[a] == nil then
      ppid_to_pid[a] = {}
    end
    table.insert(ppid_to_pid[a], b)
  end

  local processes_panes = {}
  for _, pane in ipairs(raw_panes) do
    local comp = M.split(pane, "*")
    local pid_str = " -zsh"
    if ppid_to_pid[comp[3]] ~= nil then
      pid_str = table.concat(ppid_to_pid[comp[3]], " -")
    end
    table.insert(processes_panes, { comp[1] .. " " .. comp[2] .. " | -" .. pid_str, comp[4] })
  end

  return processes_panes
end

return M
