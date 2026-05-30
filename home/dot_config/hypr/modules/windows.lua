-- windowrule = match:class .*, suppress_event maximize
hl.window_rule({
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- xwayland/floating popup no-focus rule
hl.window_rule({
	name = "test",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- App workspace assignments
hl.window_rule({
	name = "obsidian",
	match = { class = "obsidian" },
	workspace = "1",
})

hl.window_rule({
	name = "chromium",
	match = { class = "chromium" },
	workspace = "2",
})
