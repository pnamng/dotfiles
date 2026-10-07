local mainMod = "SUPER"
local terminal = "ghostty"
local fileManager = "thunar"
local qs = "~/workspaces/soft-shell/shell.qml"
local menu = "qs -p " .. qs .. " ipc call launcher toggle"

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
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

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

-- Screenshots: routed through the shell so the bar button and these
-- keybinds share one code path. grim/slurp/wl-copy, the save path and the
-- notification all live in modules/screenshot/ScreenshotState.qml.
-- (This replaced a grim | satty pipeline; satty is not installed.)
local shot = "qs -p " .. qs .. " ipc call screenshot "

hl.bind("Print", hl.dsp.exec_cmd(shot .. "full"))
hl.bind("ALT + Print", hl.dsp.exec_cmd(shot .. "window"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(shot .. "region"))

-- Shell IPC toggles (Quickshell)
-- Super+Tab workspace switcher: hold Super, tap Tab to cycle workspaces, release Super to
-- commit. Same shape as Alt+Tab below, and the release bind needs the same three flags.
-- (Super+Tab used to toggle the settings window: qs ipc call controlcenter toggle.)
local wstab = "qs -p " .. qs .. " ipc call wstab "
-- submap_universal: while the switcher is drawn the shell puts Hyprland in the "switcher"
-- submap (below), so that Super+arrows reach the switcher instead of moving focus. Tab has
-- to keep working in there.
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(wstab .. "next"), { repeating = true, submap_universal = true })
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.exec_cmd(wstab .. "prev"), { repeating = true, submap_universal = true })
hl.bind("Super_L", hl.dsp.exec_cmd(wstab .. "commit"), { release = true, transparent = true, ignore_mods = true, non_consuming = true, submap_universal = true })
-- Entered and left by soft-shell (SwitcherState), never by a key. It binds nothing but a
-- way out, which is the point: with no Super+arrow binds in force, those keys go to the
-- switcher, which has the keyboard. Escape leaves it and the shell cancels the switch.
hl.define_submap("switcher", function()
	hl.bind("Escape", hl.dsp.submap("reset"))
	hl.bind(mainMod .. " + Escape", hl.dsp.submap("reset"))
end)

-- Alt+Tab window switcher: hold Alt, tap Tab to cycle, release Alt to commit
local alttab = "qs -p " .. qs .. " ipc call alttab "
hl.bind("ALT + Tab", hl.dsp.exec_cmd(alttab .. "next"), { repeating = true })
hl.bind("ALT + SHIFT + Tab", hl.dsp.exec_cmd(alttab .. "prev"), { repeating = true })
hl.bind("ALT + Escape", hl.dsp.exec_cmd(alttab .. "cancel"))
-- commit on Alt release. Three flags, each needed (read in Hyprland 0.56.2's
-- KeybindManager.cpp):
--   transparent    once the Alt+Tab bind fires, every other bind on a key still held is
--                  "shadowed" and skipped; Alt_L is still held, so without this the release
--                  never ran after a Tab -- which is the only time it matters.
--   ignore_mods    Hyprland's modmask still has ALT set while Alt's own release is handled,
--                  so an unqualified bind does not match there either.
--   non_consuming  a release bind otherwise swallows the key's *press* from applications.
-- It fires on every Alt release, which is harmless: `commit` no-ops unless a switch is on.
hl.bind("Alt_L", hl.dsp.exec_cmd(alttab .. "commit"), { release = true, transparent = true, ignore_mods = true, non_consuming = true })
-- hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.exec_cmd("qs -p $qs ipc call controlcenter toggle"))
-- hl.bind(mainMod .. " + period",        hl.dsp.exec_cmd("qs -p $qs ipc call settings toggle"))
-- hl.bind(mainMod .. " + N",             hl.dsp.exec_cmd("qs -p $qs ipc call notifications toggleDnd"))
-- hl.bind(mainMod .. " + I",             hl.dsp.exec_cmd("qs -p $qs ipc call idle toggle"))
-- hl.bind(mainMod .. " + SHIFT + R",     hl.dsp.exec_cmd("qs -p $qs ipc call record toggle"))
