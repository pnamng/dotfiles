hl.monitor({
output = "eDP-1",
mode = "1920x1200@60",
position = "0x0",
scale = "1.25",
icc = "/usr/share/color/icc/R133NW4K_R0.icm",
  -- disabled = true
})

-- kanshi decides which outputs are on and where (~/.config/kanshi/config).
-- These rules only pre-set the same modes and scales as its `laptop` and
-- `docked` profiles, so its first pass at login changes nothing visible —
-- and qs-greeter's compositor uses the same ones, so neither does the
-- handoff from the login screen.
hl.monitor({
	output = "DP-1",
	mode = "2560x1440@144",
	position = "0x0",
	scale = "1.25",
})
--
-- monitorv2 {
--   output = HDMI-A-1
--   mode = 1920x1080@60
--   position = 1536x0
--   scale = 1.25
-- }

hl.workspace_rule({ workspace = 1, monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = 2, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 3, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 4, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 5, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 6, monitor = "DP-1" })
hl.workspace_rule({ workspace = 7, monitor = "DP-1" })
hl.workspace_rule({ workspace = 8, monitor = "DP-1" })
hl.workspace_rule({ workspace = 9, monitor = "DP-1" })
hl.workspace_rule({ workspace = 10, monitor = "DP-1" })
