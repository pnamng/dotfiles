-- windowrule = match:class .*, suppress_event maximize
hl.window_rule({
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- xwayland/floating popup no-focus rule
-- hl.window_rule({
-- 	name = "test",
-- 	match = {
-- 		class = "^$",
-- 		title = "^$",
-- 		xwayland = true,
-- 		float = true,
-- 		fullscreen = false,
-- 		pin = false,
-- 	},
-- 	no_focus = true,
-- })

-- App workspace assignments
hl.window_rule({
	name = "obsidian",
	match = { class = "obsidian" },
	workspace = "3",
})

hl.window_rule({
	name = "chromium",
	match = { class = "chromium", float = false },
	workspace = "2",
})

-- Everything on a special workspace floats: a window opened there, and one
-- sent there (SUPER + SHIFT + S). Done from events rather than a window rule
-- because `float` in a rule is only read when a window opens, so a rule
-- cannot reach a window that is moved in later.
local function float_on_special(window, workspace)
	workspace = workspace or window.workspace
	if workspace and workspace.special then
		hl.dispatch(hl.dsp.window.float({ action = "enable", window = window }))
	end
end

hl.on("window.open", float_on_special)
hl.on("window.move_to_workspace", float_on_special)
