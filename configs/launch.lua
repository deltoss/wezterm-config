local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
	config.default_prog = { "pwsh", "-NoLogo" }

	config.launch_menu = {
		{
			label = "Default Shell",
			args = {},
		},
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
		{
			label = "Neovim: Note Taking",
			args = { "pwsh", "-NoLogo", "-NoProfile", "-c", 'cd (zoxide query "Note Taking"); nvim .' },
		},
		{
			label = "Neovim: Neovim Configs",
			args = { "pwsh", "-NoLogo", "-NoProfile", "-c", 'cd (zoxide query "Local\\nvim"); nvim .' },
		},
		{
			label = "Neovim: Wezterm Configs",
			args = { "pwsh", "-NoLogo", "-NoProfile", "-c", 'cd (zoxide query ".config\\wezterm"); nvim .' },
		},
	}
end

return module
