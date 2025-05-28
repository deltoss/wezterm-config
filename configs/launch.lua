local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
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
end

return module
