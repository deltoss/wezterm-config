local wezterm = require("wezterm")
local act = wezterm.action
local module = {}

module.renameTabAction = act.PromptInputLine({
	description = wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { AnsiColor = "Aqua" } },
		{ Text = "Enter new name for tab" },
	}),
	initial_value = "🚀 ",
	action = wezterm.action_callback(function(window, pane, line)
		-- line will be `nil` if they hit escape without entering anything
		-- An empty string if they just hit enter
		-- Or the actual line of text they wrote
		if line then
			window:active_tab():set_title(line)
		end
	end),
})

module.renameWorkspaceAction = act.PromptInputLine({
	description = wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { AnsiColor = "Aqua" } },
		{ Text = "Enter new name for workspace" },
	}),
	action = wezterm.action_callback(function(window, pane, line)
		-- line will be `nil` if they hit escape without entering anything
		-- An empty string if they just hit enter
		-- Or the actual line of text they wrote
		if line then
			wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
		end
	end),
})

return module
