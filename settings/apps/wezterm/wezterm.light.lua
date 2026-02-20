-- WezTerm configuration file
-- Part of GPP

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'GruvboxLight'
-- config.color_scheme = 'GruvboxDark'

-- config.font = wezterm.font 'PlemolJP Console NFJ'
config.font = wezterm.font_with_fallback {
	'MesloLGS NF',
	'PlemolJP Console NF'
}
config.initial_cols = 114
config.initial_rows = 40

config.font = wezterm.font('Cica')
config.font_size = 14.0
config.display_pixel_geometry = "RGB"
-- config.display_pixel_geometry = "BGR"
config.anti_alias_custom_block_glyphs = true
-- config.window_background_opacity = 0.75
config.macos_window_background_blur = 15

config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
-- config.freetype_render_target = "VerticalLcd"

--[[
-- List all built-in color schemes
local schemes = wezterm.color.get_builtin_schemes()
local names = {}

for name, _ in pairs(schemes) do
  table.insert(names, name)
end

table.sort(names)

wezterm.log_info("Built-in color schemes:")
for _, name in ipairs(names) do
  wezterm.log_info("  " .. name)
end
--]]
-- return {}


wezterm.on('format-window-title', function ()
  return 'Wezterm'
end)


-- and finally, return the configuration to wezterm
return config

