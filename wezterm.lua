local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'Dracula'
config.font = wezterm.font('FiraCode Nerd Font')
-- Set font size based on operating system
if wezterm.target_triple:find("linux") then
  configenable_wayland = true
  config.font_size = 10.0
elseif wezterm.target_triple:find("darwin") then
  config.font_size = 14.0
else
  config.font_size = 12.0 -- default for other systems
end
config.initial_rows = 40
config.initial_cols = 132

config.audible_bell = 'Disabled'

config.scrollback_lines = 100000

config.keys = {
    -- paste from the clipboard
    { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  
    -- paste from the primary selection
    { key = 'V', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
  }

return config
