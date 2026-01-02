local wezterm = require("wezterm")
local module = {}

-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object.
function module.apply_to_config(config)
	config.initial_cols = 140

	config.warn_about_missing_glyphs = false

	config.font_size = 14
	-- See: https://wezterm.org/colorschemes/index.html
	config.color_scheme = "Catppuccin Latte"

	config.window_frame = {
		-- The overall background color of the tab bar when
		-- the window is focused
		active_titlebar_bg = "#152238",

		-- The overall background color of the tab bar when
		-- the window is not focused
		inactive_titlebar_bg = "#152238",

		-- The size of the font in the tab bar.
		-- Default to 10.0 on Windows but 12.0 on other systems
		font_size = 14.0,
	}

	config.window_padding = {
		left = "0cell",
		right = "0cell",
		top = "0cell",
		bottom = "0cell",
	}

	config.tab_and_split_indices_are_zero_based = true

	config.colors = {
		tab_bar = {
			-- The active tab is the one that has focus in the window
			active_tab = {
				-- The color of the background area for the tab
				bg_color = "#174574",
				-- The color of the text for the tab
				fg_color = "#c0c0c0",
			},

			-- Inactive tabs are the tabs that do not have focus
			inactive_tab = {
				bg_color = "#1b1032",
				fg_color = "#808080",

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over inactive tabs
			inactive_tab_hover = {
				bg_color = "#3b3052",
				fg_color = "#909090",
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab_hover`.
			},

			-- The new tab button that let you create new tabs
			new_tab = {
				bg_color = "#152238",
				fg_color = "#808080",

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over the new tab button
			new_tab_hover = {
				bg_color = "#192843",
				fg_color = "#909090",
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab_hover`.
			},
		},
	}
end

return module
