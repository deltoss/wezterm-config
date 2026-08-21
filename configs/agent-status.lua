local wezterm = require("wezterm")

local M = {}

local STATUS_DIRECTORY = wezterm.home_dir .. "/.agents/statuses"
local MAX_NAME_CHARACTERS = 10
local NAME_ELLIPSIS = "..."
local NAME_PREFIX_CHARACTERS = MAX_NAME_CHARACTERS - #NAME_ELLIPSIS

local STATUS_ICONS = {
  attention = "󰳦",
  working = "↻",
  ready = "✓",
}

local VALID_STATES = {
  attention = true,
  working = true,
  ready = true,
}

local function read_json(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end

  local content = file:read("*a")
  file:close()

  local ok, value = pcall(wezterm.json_parse, content)
  if not ok or type(value) ~= "table" then
    return nil
  end

  return value
end

local function status_paths()
  local ok, paths = pcall(wezterm.glob, STATUS_DIRECTORY .. "/*.json")
  if not ok or type(paths) ~= "table" then
    return {}
  end

  return paths
end

local function clean_text(value)
  return value:gsub("[%c]", " "):gsub("%s+", " "):match("^%s*(.-)%s*$")
end

local function truncate_name(name)
  local character_count = utf8.len(name)
  if not character_count or character_count <= MAX_NAME_CHARACTERS then
    return name
  end

  local first_removed_byte = utf8.offset(name, NAME_PREFIX_CHARACTERS + 1)
  return name:sub(1, first_removed_byte - 1) .. NAME_ELLIPSIS
end

local function display_name(status)
  local name = type(status.name) == "string" and status.name or status.agent
  if type(name) ~= "string" then
    name = "agent"
  end

  name = clean_text(name)
  if name == "" then
    name = "agent"
  end

  return truncate_name(name)
end

local function display_icon(status)
  if type(status.icon) ~= "string" then
    return "•"
  end

  local icon = wezterm.truncate_right(clean_text(status.icon), 2)
  return icon ~= "" and icon or "•"
end

local function load_sessions()
  local sessions = {}
  local now = os.time() * 1000

  for _, path in ipairs(status_paths()) do
    local status = read_json(path)
    if status
        and status.version == 1
        and type(status.expiresAt) == "number"
        and status.expiresAt >= now
        and VALID_STATES[status.state] == true
    then
      table.insert(sessions, {
        icon = display_icon(status),
        instance_id = tostring(status.instanceId or path),
        name = display_name(status),
        started_at = type(status.startedAt) == "number" and status.startedAt or 0,
        state = status.state,
      })
    end
  end

  table.sort(sessions, function(left, right)
    if left.started_at ~= right.started_at then
      return left.started_at > right.started_at
    end
    return left.instance_id > right.instance_id
  end)

  return sessions
end

function M.render()
  local segments = {}

  for _, session in ipairs(load_sessions()) do
    table.insert(segments, session.icon .. STATUS_ICONS[session.state] .. " " .. session.name)
  end

  return segments
end

return M