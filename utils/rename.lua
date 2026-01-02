local wezterm = require("wezterm")
local act = wezterm.action
local module = {}

local renameTabAction = act.PromptInputLine({
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

local renameWorkspaceAction = act.PromptInputLine({
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

module.promptRenameAction = act.InputSelector({
	title = "✏️ Rename Mode",
	alphabet = "123456789abcdefghijklmnopqrstuvwxyz",
	choices = {
		{ label = "1. 🏷️ Rename Tab", id = "rename_tab" },
		{ label = "2. 🗄️ Rename Workspace", id = "rename_workspace" },
	},
	action = wezterm.action_callback(function(window, pane, id, label)
		if id == "rename_tab" then
			window:perform_action(renameTabAction, pane)
		elseif id == "rename_workspace" then
			window:perform_action(renameWorkspaceAction, pane)
		end
	end),
})

return module
