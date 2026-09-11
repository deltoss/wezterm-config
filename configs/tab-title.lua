local wezterm = require("wezterm")

-- Extract the final path component and hide Windows executable extensions.
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  local name = s:match("[^/\\]+$") or s
  return (name:gsub("%.[eE][xX][eE]$", ""))
end

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  local tabNumber = tab_info.tab_index + 1
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return tabNumber .. ": " .. title
  end
  -- if the PROG user variable is detected, take that
  local prog = tab_info.active_pane.user_vars.PROG
  if prog and #prog > 0 then
    return tabNumber .. ": " .. prog
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tabNumber .. ": " .. basename(tab_info.active_pane.title)
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  return tab_title(tab)
end)

return {
  apply_to_config = function(config) end,
}
