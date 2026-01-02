local wezterm = require("wezterm")
local module = {}

-- Based on: https://github.com/wezterm/wezterm/discussions/3779#discussioncomment-8923369
module.toggleTerminalAction = wezterm.action_callback(function(_, pane)
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
end)

return module
