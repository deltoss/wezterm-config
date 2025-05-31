local wezterm = require("wezterm")
local act = wezterm.action

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
	config.keys = {
		{
			key = "PageDown",
			mods = "CTRL|ALT",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "PageUp",
			mods = "CTRL|ALT",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "p",
			mods = "CTRL|ALT",
			action = act.ActivateCommandPalette,
		},
		{
			key = "F1",
			action = act.ActivateCommandPalette,
		},
		{
			key = "c",
			mods = "CTRL|ALT",
			action = act.ActivateCopyMode,
			-- See Copy Mode: https://wezterm.org/copymode.html
		},
		{
			key = "s",
			mods = "CTRL|ALT",
			action = act.QuickSelect,
		},
		{
			key = "/",
			mods = "CTRL|ALT",
			action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		{
			key = ".",
			mods = "CTRL|ALT",
			action = act.SwitchWorkspaceRelative(1),
		},
		{
			key = ",",
			mods = "CTRL|ALT",
			action = act.SwitchWorkspaceRelative(-1),
		},
		{
			key = "w",
			mods = "CTRL|ALT|SHIFT",
			action = act.CloseCurrentTab({ confirm = false }),
		},
		{
			key = "w",
			mods = "CTRL|ALT",
			action = act.CloseCurrentPane({ confirm = false }),
		},
		{
			key = "F4",
			mods = "CTRL",
			action = act.CloseCurrentTab({ confirm = false }),
		},
		{
			key = "f",
			mods = "CTRL|ALT",
			action = act.Search({ CaseSensitiveString = "" }),
		},
		{
			key = "t",
			mods = "CTRL|ALT|SHIFT",
			action = act.ShowTabNavigator,
		},
		{
			key = "t",
			mods = "CTRL|ALT",
			action = act.ShowLauncher,
		},
		{
			key = "UpArrow",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitPane({
				direction = "Up",
				size = { Percent = 50 },
			}),
		},
		{
			key = "RightArrow",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitPane({
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			key = "DownArrow",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 50 },
			}),
		},
		{
			key = "LeftArrow",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitPane({
				direction = "Left",
				size = { Percent = 50 },
			}),
		},
		{
			key = "r",
			mods = "CTRL|ALT",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				initial_value = "My Tab Name",
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = "z",
			mods = "CTRL|ALT",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = ";",
			mods = "CTRL",
			-- Based on: https://github.com/wezterm/wezterm/discussions/3779#discussioncomment-8923369
			action = wezterm.action_callback(function(_, pane)
				local tab = pane:tab()
				local panes = tab:panes_with_info()
				if #panes == 1 then
					pane:split({
						direction = "Bottom",
						size = 0.4,
					})
				elseif not panes[1].is_zoomed then
					panes[1].pane:activate()
					tab:set_zoomed(true)
				elseif panes[1].is_zoomed then
					tab:set_zoomed(false)
					panes[2].pane:activate()
				end
			end),
		},
	}

	for i = 0, 9 do
		-- leader + number to activate that tab
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = wezterm.action.ActivateTab(i),
		})
	end
end

return module
