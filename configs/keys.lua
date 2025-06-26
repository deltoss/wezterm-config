local wezterm = require("wezterm")
local act = wezterm.action

local renameUtils = require("utils.rename")
local terminalUtils = require("utils.terminal")

local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
	config.leader = {
		key = "Insert",
		mods = "",
		timeout_milliseconds = 5000,
	}

	config.key_tables = {
		rename_mode = {
			{ key = "r", mods = "ALT", action = renameUtils.renameTabAction },
			{ key = "r", action = renameUtils.renameTabAction },
			{ key = "t", action = renameUtils.renameTabAction },
			{ key = "w", action = renameUtils.renameWorkspaceAction },

			-- Cancel the mode by pressing escape
			{ key = "Escape", action = "PopKeyTable" },
		},
	}

	config.keys = {
		{
			-- Send proper sequence vim expects
			-- See: https://stackoverflow.com/a/42461580
			key = "Enter",
			mods = "SHIFT",
			action = wezterm.action.SendString("\x1b[13;2u"),
		},
		{
			key = "Enter",
			mods = "CTRL",
			action = wezterm.action.SendString("\x1b[13;5u"),
		},
		{
			key = "o",
			mods = "LEADER",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "u",
			mods = "LEADER",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "p",
			mods = "LEADER",
			action = act.ActivateCommandPalette,
		},
		{
			key = "c",
			mods = "LEADER",
			action = act.ActivateCopyMode,
			-- See Copy Mode: https://wezterm.org/copymode.html
		},
		{
			key = "s",
			mods = "LEADER",
			action = act.QuickSelect,
		},
		{
			key = "/",
			mods = "LEADER",
			action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		{
			key = ".",
			mods = "LEADER",
			action = act.SwitchWorkspaceRelative(1),
		},
		{
			key = ",",
			mods = "LEADER",
			action = act.SwitchWorkspaceRelative(-1),
		},
		{
			key = "w",
			mods = "LEADER",
			action = act.CloseCurrentPane({ confirm = false }),
		},
		{
			key = "W",
			mods = "LEADER|SHIFT",
			action = act.CloseCurrentTab({ confirm = false }),
		},
		{
			key = "f",
			mods = "LEADER",
			action = act.Search({ CaseSensitiveString = "" }),
		},
		{
			key = "t",
			mods = "LEADER",
			action = act.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS|TABS|WORKSPACES" }),
		},
		{
			key = "T",
			mods = "LEADER|SHIFT",
			action = act.ShowTabNavigator,
		},
		{
			key = "UpArrow",
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				direction = "Up",
				size = { Percent = 70 },
			}),
		},
		{
			key = "RightArrow",
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				direction = "Right",
				size = { Percent = 30 },
			}),
		},
		{
			key = "DownArrow",
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 30 },
			}),
		},
		{
			key = "LeftArrow",
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				direction = "Left",
				size = { Percent = 70 },
			}),
		},
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "rename_mode",
				timeout_milliseconds = 5000,
			}),
		},
		{
			key = "z",
			mods = "LEADER",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = ";",
			mods = "LEADER",
			action = terminalUtils.toggleTerminalAction,
		},
		{
			key = "o",
			mods = "ALT",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "u",
			mods = "ALT",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "PageDown",
			mods = "ALT",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "PageUp",
			mods = "ALT",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "{",
			mods = "SHIFT|ALT",
			action = act.MoveTabRelative(-1),
		},
		{
			key = "}",
			mods = "SHIFT|ALT",
			action = act.MoveTabRelative(1),
		},
		{
			key = "o",
			mods = "ALT|CTRL",
			action = act.MoveTabRelative(-1),
		},
		{
			key = "u",
			mods = "ALT|CTRL",
			action = act.MoveTabRelative(1),
		},
		{
			key = "PageDown",
			mods = "ALT|CTRL",
			action = act.MoveTabRelative(-1),
		},
		{
			key = "PageUp",
			mods = "ALT|CTRL",
			action = act.MoveTabRelative(1),
		},
		{
			key = "p",
			mods = "ALT",
			action = act.ActivateCommandPalette,
		},
		{
			key = "F1",
			action = act.ActivateCommandPalette,
		},
		{
			key = "c",
			mods = "ALT",
			action = act.ActivateCopyMode,
			-- See Copy Mode: https://wezterm.org/copymode.html
		},
		{
			key = "s",
			mods = "ALT",
			action = act.QuickSelect,
		},
		{
			key = "/",
			mods = "ALT",
			action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
		},
		{
			key = ".",
			mods = "ALT",
			action = act.SwitchWorkspaceRelative(1),
		},
		{
			key = ",",
			mods = "ALT",
			action = act.SwitchWorkspaceRelative(-1),
		},
		{
			key = "w",
			mods = "ALT",
			action = act.CloseCurrentPane({ confirm = false }),
		},
		{
			key = "W",
			mods = "CTRL|ALT|SHIFT",
			action = act.CloseCurrentTab({ confirm = false }),
		},
		{
			key = "F4",
			mods = "CTRL",
			action = act.CloseCurrentTab({ confirm = false }),
		},
		{
			key = "f",
			mods = "ALT",
			action = act.Search({ CaseSensitiveString = "" }),
		},
		{
			key = "T",
			mods = "CTRL|ALT|SHIFT",
			action = act.ShowTabNavigator,
		},
		{
			key = "t",
			mods = "ALT",
			action = act.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS|TABS|WORKSPACES" }),
		},
		{
			key = "UpArrow",
			mods = "CTRL|ALT|SHIFT",
			action = wezterm.action.SplitPane({
				direction = "Up",
				size = { Percent = 70 },
			}),
		},
		{
			key = "RightArrow",
			mods = "CTRL|ALT|SHIFT",
			action = wezterm.action.SplitPane({
				direction = "Right",
				size = { Percent = 30 },
			}),
		},
		{
			key = "DownArrow",
			mods = "CTRL|ALT|SHIFT",
			action = wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 30 },
			}),
		},
		{
			key = "LeftArrow",
			mods = "CTRL|ALT|SHIFT",
			action = wezterm.action.SplitPane({
				direction = "Left",
				size = { Percent = 70 },
			}),
		},
		{
			key = "r",
			mods = "ALT",
			action = act.ActivateKeyTable({
				name = "rename_mode",
				timeout_milliseconds = 5000,
			}),
		},
		{
			key = "z",
			mods = "ALT",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = ";",
			mods = "CTRL|ALT|SHIFT",
			action = terminalUtils.toggleTerminalAction,
		},
		{
			key = ";",
			mods = "CTRL",
			action = terminalUtils.toggleTerminalAction,
		},
		{
			key = ";",
			mods = "ALT",
			action = terminalUtils.toggleTerminalAction,
		},
	}

	for i = 1, 9 do
		-- leader + number to activate that tab
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = wezterm.action.ActivateTab(i - 1),
		})

		-- ALT + number to activate that tab
		table.insert(config.keys, {
			key = tostring(i),
			mods = "ALT",
			action = wezterm.action.ActivateTab(i - 1),
		})
	end
end

return module
