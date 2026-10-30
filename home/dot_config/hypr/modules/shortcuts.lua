local mainMod = "SUPER"
local terminal = "ghostty"
local fileManager = "thunar"
local menu = "noctalia msg panel-toggle launcher"

-- basic
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
-- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("noctalia msg session lock"))

-- workspaces
for i = 1, 9 do
	hl.bind(mainMod .. "+ " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. "+ 0", hl.dsp.focus({ workspace = 10 }))
for i = 1, 9 do
	hl.bind(mainMod .. "+SHIFT+" .. i, hl.dsp.window.move({ workspace = i, follow = true }))
end
hl.bind(mainMod .. "+SHIFT+0", hl.dsp.window.move({ workspace = 10, follow = true }))

local dirs = {
	{ key = "Left", dir = "l" },
	{ key = "Right", dir = "r" },
	{ key = "Up", dir = "u" },
	{ key = "Down", dir = "d" },
}

-- traverse
for _, d in ipairs(dirs) do
	hl.bind(mainMod .. "  + " .. d.key, hl.dsp.focus({ direction = d.dir }))
end

for _, d in ipairs(dirs) do
	hl.bind(mainMod .. " + SHIFT + " .. d.key, hl.dsp.window.move({ direction = d.dir }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- Multimedia keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- Playerctl (custom script)
hl.bind(mainMod .. " + Delete", hl.dsp.exec_cmd("~/.config/hypr/scripts/player.sh play-pause"))
hl.bind(mainMod .. " + End", hl.dsp.exec_cmd("~/.config/hypr/scripts/player.sh next"))
hl.bind(mainMod .. " + Home", hl.dsp.exec_cmd("~/.config/hypr/scripts/player.sh prev"))

-- Screenshots (noctalia)
hl.bind("Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("noctalia msg screenshot-window"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("noctalia msg screenshot-region"))

-- soft-shell's binds (screenshots, Super+Tab / Alt+Tab switchers) are disabled; the
-- originals are in shortcuts.lua.bak-softshell.
