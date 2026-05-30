local mainMod = SUPER
local terminal = ghostty
local fileManager = dolphin
local menu = fuzzel
local qs = "~/workspaces/lazy-shell/shell.qml"

require("modules/animations")
require("modules/env")
require("modules/monitors")
require("modules/shortcuts")
require("modules/windows")
require("modules/workspaces")
require("modules/submaps")

-- Autostart (exec-once equivalent)
hl.on("hyprland.start", function()
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Breeze'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
	hl.exec_cmd("kanshi")
	hl.exec_cmd("qs -p " .. qs)
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 1,
		col = {
			active_border = "rgba(39bae6ff)", -- single color, no gradient
			inactive_border = "rgba(1e2530aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 4,
			vibrancy = 0.1696,
		},
	},
	-- animations go here via hl.curve() + hl.animation() calls, not inside hl.config
	dwindle = {
		preserve_split = true,
		-- pseudotile removed in 0.55
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 2,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
