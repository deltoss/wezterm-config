local wezterm = require("wezterm")
local act = wezterm.action

local renameUtils = require("utils.rename")
local terminalUtils = require("utils.terminal")
require("utils.scrollback")

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
    -- Turn off problematic default key bindings
    { key = "p", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
    { key = "PageUp", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    { key = "PageDown", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
    {
      key = "o",
      mods = "CTRL|SHIFT",
      action = act.EmitEvent("trigger-editor-with-scrollback"),
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
      action = act.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = "T",
      mods = "LEADER|SHIFT",
      action = act.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS|TABS|WORKSPACES" }),
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
      action = renameUtils.promptRenameAction,
    },
    {
      key = "z",
      mods = "LEADER",
      action = wezterm.action.TogglePaneZoomState,
    },
    {
      key = "i",
      mods = "LEADER",
      action = terminalUtils.toggleTerminalAction,
    },
    {
      key = ";",
      mods = "LEADER",
      action = terminalUtils.toggleTerminalAction,
    },
    {
      key = ",",
      mods = "ALT",
      action = act.ActivateTabRelative(-1),
    },
    {
      key = ".",
      mods = "ALT",
      action = act.ActivateTabRelative(1),
    },
    {
      key = ",",
      mods = "ALT|CTRL",
      action = act.MoveTabRelative(-1),
    },
    {
      key = ".",
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
      key = "i",
      mods = "ALT",
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