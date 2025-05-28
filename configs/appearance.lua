local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
	config.font_size = 15
	-- See: https://wezterm.org/colorschemes/index.html
	config.color_scheme = "Catppuccin Latte"
end

return module
