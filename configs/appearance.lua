local wezterm = require("wezterm")
local mux = wezterm.mux
local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
	config.font_size = 15
	-- See: https://wezterm.org/colorschemes/index.html
	config.color_scheme = "Catppuccin Latte"
end

-- Maximize window on start
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

return module
