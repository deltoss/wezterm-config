local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.default_prog = { "pwsh", "-NoLogo" }

config.launch_menu = {
	{
		label = "Neovim",
		args = {
			"nvim",
		},
	},
	{
		label = "lf",
		args = {
			"lf",
		},
	},
	{
		label = "LazyGit",
		args = {
			"LazyGit",
		},
	},
	{
		label = "LazyDocker",
		args = {
			"LazyDocker",
		},
	},
}

config.initial_cols = 120
config.initial_rows = 28

config.font_size = 15
-- See: https://wezterm.org/colorschemes/index.html
config.color_scheme = "Catppuccin Latte"

return config
