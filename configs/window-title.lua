local wezterm = require("wezterm")

wezterm.on("format-window-title", function()
	local title = wezterm.mux.get_active_workspace()
	title = title .. " → Domain: " .. wezterm.mux.get_domain():name()
	return title
end)

return {
	apply_to_config = function(config) end,
}
