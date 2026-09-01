local wezterm = require("wezterm")

local M = {}

local STATUS_GLOB = wezterm.home_dir .. "/.agents/statuses/*.json"
local MAX_NAME_CHARACTERS = 10
local NAME_ELLIPSIS = "..."
local NAME_PREFIX_CHARACTERS = MAX_NAME_CHARACTERS - #NAME_ELLIPSIS
local DEFAULT_NAME = "agent"
local DEFAULT_ICON = "•"

local STATUS_ICONS = {
  attention = { "󰳦" },
  working = { "○", "◎", "◉", "◎" },
  ready = { "✓" },
}
local animation_frame = 0

local function read_json(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end

  local content = file:read("*a")
  file:close()

  local ok, value = pcall(wezterm.json_parse, content)
  if ok and type(value) == "table" then
    return value
  end

  return nil
end

local function status_paths()
  local ok, paths = pcall(wezterm.glob, STATUS_GLOB)
  if ok and type(paths) == "table" then
    return paths
  end

  return {}
end

local function clean_text(value)
  local cleaned = value:gsub("[%c]", " "):gsub("%s+", " ")
  return cleaned:match("^%s*(.-)%s*$")
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
    return DEFAULT_NAME
  end

  name = clean_text(name)
  if name == "" then
    return DEFAULT_NAME
  end

  return truncate_name(name)
end

local function display_icon(status)
  if type(status.icon) ~= "string" then
    return DEFAULT_ICON
  end

  local icon = wezterm.truncate_right(clean_text(status.icon), 2)
  return icon ~= "" and icon or DEFAULT_ICON
end

local function to_session(status, path, now)
  if
      type(status) ~= "table"
      or type(status.expiresAt) ~= "number"
      or status.expiresAt <= now
      or not STATUS_ICONS[status.state]
  then
    return nil
  end

  return {
    icon = display_icon(status),
    instance_id = tostring(status.instanceId or path),
    name = display_name(status),
    started_at = type(status.startedAt) == "number" and status.startedAt or 0,
    state = status.state,
  }
end

local function load_sessions()
  local sessions = {}
  local now = os.time() * 1000

  for _, path in ipairs(status_paths()) do
    local session = to_session(read_json(path), path, now)
    if session then
      sessions[#sessions + 1] = session
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
  local sessions = load_sessions()
  local segments = {}
  animation_frame = animation_frame % #STATUS_ICONS.working + 1

  for index, session in ipairs(sessions) do
    local frames = STATUS_ICONS[session.state]
    local status_icon = frames[(animation_frame - 1) % #frames + 1]
    segments[index] = session.icon .. " " .. status_icon .. " " .. session.name
  end

  return segments
end

return M