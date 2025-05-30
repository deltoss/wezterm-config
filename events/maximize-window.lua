local wezterm = require("wezterm")
local mux = wezterm.mux

-- Maximize window on start
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)
