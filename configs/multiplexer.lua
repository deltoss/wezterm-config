local wezterm = require("wezterm")
local mux = wezterm.mux

local module = {}

-- Maximize/restore round trip on reattach: forces a window state change and
-- repaint, clearing stale content when the compositor resizes after first paint.
wezterm.on("gui-attached", function()
	if os.getenv("WEZTERM_SKIP_ATTACH_MAXIMIZE") == "1" then
		return
	end

	local workspace = mux.get_active_workspace()
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			local gui_window = window:gui_window()
			gui_window:maximize()
			wezterm.time.call_after(0.3, function()
				gui_window:restore()
			end)
		end
	end
end)

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
	-- Persist terminal sessions through multiplexing
	config.unix_domains = {
		{
			name = "unix",
		},
	}

	-- This causes `wezterm` to act as though it was started as
	-- `wezterm connect unix` by default, connecting to the unix
	-- domain on startup.
	-- If you prefer to connect manually, leave out this line.
	config.default_gui_startup_args = { "connect", "unix" }
end

return module
