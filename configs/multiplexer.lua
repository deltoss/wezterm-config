local module = {}

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
