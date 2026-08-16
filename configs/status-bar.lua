local wezterm = require("wezterm")

local CLOCK_FACES = { "🕐", "🕑", "🕒", "🕓", "🕔", "🕕", "🕖", "🕗", "🕘", "🕙", "🕚", "🕛" }

local function get_clock_emoji()
  local hour = tonumber(wezterm.strftime("%I"))
  return CLOCK_FACES[hour]
end

wezterm.on("update-right-status", function(window, pane)
  -- Each element holds the text for a cell in a "powerline" style << fade
  local cells = {}

  -- Pick up the hostname for a remote pane when its shell uses OSC 7.
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local hostname = ""

    if type(cwd_uri) == "userdata" then
      hostname = cwd_uri.host or wezterm.hostname()
    else
      cwd_uri = cwd_uri:sub(8)
      local slash = cwd_uri:find("/")
      if slash then
        hostname = cwd_uri:sub(1, slash - 1)
      end
    end

    -- Remove the domain name portion of the hostname
    local dot = hostname:find("[.]")
    if dot then
      hostname = hostname:sub(1, dot - 1)
    end
    if hostname == "" then
      hostname = wezterm.hostname()
    end

    table.insert(cells, " 🖥️ " .. hostname)
  end

  -- I like my date/time in this style: "Wed Mar 3 08:14"
  local date = wezterm.strftime("%a %b %-d %H:%M")
  table.insert(cells, " " .. get_clock_emoji() .. " " .. date)

  -- An entry for each battery (typically 0 or 1 battery)
  --

  -- Show which key table is active in the status area
  local name = window:active_key_table()
  if name then
    table.insert(cells, "Table: " .. name)
  end

  -- The powerline < symbol
  local LEFT_ARROW = utf8.char(0xe0b3)
  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Color palette for the backgrounds of each cell
  local colors = {
    "#174574",
    "#365473",
    "#567594",
    "#5f8fc9",
    "#537cad",
  }
  local window_frame = window:effective_config().window_frame
  local titlebar_bg = window:is_focused() and window_frame.active_titlebar_bg or window_frame.inactive_titlebar_bg

  -- Foreground color for the text across the fade
  local text_fg = "#c0c0c0"

  -- The elements to be formatted
  local elements = {}
  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  local function push(text, is_last)
    local cell_no = num_cells + 1

    if cell_no == 1 then
      table.insert(elements, { Background = { Color = titlebar_bg } })
      table.insert(elements, { Foreground = { Color = colors[cell_no] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = " " .. text .. " " })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))
end)

return {}
