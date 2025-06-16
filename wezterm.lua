local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font('FiraCode Nerd Font')
-- Set font size based on operating system
if wezterm.target_triple:find("linux") then
  config.enable_wayland = true
  config.font_size = 10.0
elseif wezterm.target_triple:find("darwin") then
  config.font_size = 14.0
else
  config.font_size = 12.0 -- default for other systems
end
-- config.font_shaper = "Allsorts",

-- Font rendering options
config.freetype_load_target = "HorizontalLcd"
config.freetype_render_target = "HorizontalLcd"
config.freetype_interpreter_version = 40
config.harfbuzz_features = {"zero", "ss01", "cv05"}
-- config.font_antialias = "Subpixel",
-- config.font_hinting = "Full",

-- Theme
config.color_scheme = 'Dracula'
config.window_decorations = "RESIZE"
-- config.tab_bar_at_bottom = true,
-- config.use_fancy_tab_bar = false,

-- Cursor settings
-- config.default_cursor_style = "Block",
config.cursor_blink_rate = 0 -- Disable cursor blinking

-- Window size
config.initial_rows = 40
config.initial_cols = 132

-- Scrollback
config.scrollback_lines = 100000

-- Shell integration
config.enable_kitty_graphics = true

-- Bell settings
config.audible_bell = 'Disabled'

-- Key bindings
config.keys = {
    -- paste from the clipboard
    { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  
    -- paste from the primary selection
    { key = 'V', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
}

return config
