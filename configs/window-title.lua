local wezterm = require("wezterm")

wezterm.on("format-window-title", function(tab, pane)
  local title = wezterm.mux.get_active_workspace()
  title = title .. " → Domain: " .. pane.domain_name
  return title
end)

return {
  apply_to_config = function(config) end,
}
