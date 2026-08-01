local mainMod = "SUPER"
local terminal = "ghostty"
local fileManager = "thunar"
local qs = "~/workspaces/lazy-shell/shell.qml"
local menu = "qs -p " .. qs .. " ipc call launcher toggle"

-- basic
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("~/.config/hypr/scripts/power-menu.sh"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/theme-switcher.sh"))

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

local screenshotDir = "~/Pictures/Screenshots"

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Lid close → lock
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })

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
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Playerctl (custom script)
hl.bind(mainMod .. " + Delete", hl.dsp.exec_cmd("~/.config/hypr/scripts/player.sh play-pause"))
hl.bind(mainMod .. " + End", hl.dsp.exec_cmd("~/.config/hypr/scripts/player.sh next"))
hl.bind(mainMod .. " + Home", hl.dsp.exec_cmd("~/.config/hypr/scripts/player.sh prev"))

-- Screenshots: capture with grim, annotate/save/copy with satty
local ts = "$(date +%Y%m%d_%H%M%S).png"
local function satty(grimArgs)
	return hl.dsp.exec_cmd(
		"grim "
			.. grimArgs
			.. " - | satty --filename - --output-filename "
			.. screenshotDir
			.. "/"
			.. ts
			.. " --early-exit --copy-command wl-copy"
	)
end

-- Full screen
hl.bind("Print", satty(""))

-- Active window
hl.bind(
	"ALT + Print",
	satty('-g "$(hyprctl activewindow -j | jq -r \'"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])"\')"')
)

-- Selection (region)
hl.bind("CTRL + Print", satty('-g "$(slurp)"'))

-- Shell IPC toggles (Quickshell)
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("qs -p " .. qs .. " ipc call controlcenter toggle"))

-- Alt+Tab window switcher: hold Alt, tap Tab to cycle, release Alt to commit
local alttab = "qs -p " .. qs .. " ipc call alttab "
hl.bind("ALT + Tab", hl.dsp.exec_cmd(alttab .. "next"), { repeating = true })
hl.bind("ALT + SHIFT + Tab", hl.dsp.exec_cmd(alttab .. "prev"), { repeating = true })
hl.bind("ALT + Escape", hl.dsp.exec_cmd(alttab .. "cancel"))
-- commit on Alt release. NO modifier here: releasing Alt clears the ALT modmask in
-- the same event, so a mod-qualified release bind never matches. bare Alt_L fires on
-- every Alt release, which is harmless since `commit` no-ops unless the switcher is open.
hl.bind("Alt_L", hl.dsp.exec_cmd(alttab .. "commit"), { release = true })
-- hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.exec_cmd("qs -p $qs ipc call controlcenter toggle"))
-- hl.bind(mainMod .. " + period",        hl.dsp.exec_cmd("qs -p $qs ipc call settings toggle"))
-- hl.bind(mainMod .. " + N",             hl.dsp.exec_cmd("qs -p $qs ipc call notifications toggleDnd"))
-- hl.bind(mainMod .. " + I",             hl.dsp.exec_cmd("qs -p $qs ipc call idle toggle"))
-- hl.bind(mainMod .. " + SHIFT + R",     hl.dsp.exec_cmd("qs -p $qs ipc call record toggle"))
