hl.monitor({
output = "eDP-1",
mode = "1920x1200@60",
position = "0x0",
scale = "1.25",
icc = "/home/froggo/Downloads/R133NW4K_R0.icm",
  disabled = true
})

hl.monitor({
	output = "DP-1",
	mode = "2560x1440@144",
	position = "0x-1152",
	scale = "1.25",
})
--
-- monitorv2 {
--   output = HDMI-A-1
--   mode = 1920x1080@60
--   position = 1536x0
--   scale = 1.25
-- }

hl.workspace_rule({ workspace = 1, monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = 2, monitor = "DP-1" })
hl.workspace_rule({ workspace = 3, monitor = "DP-1" })
hl.workspace_rule({ workspace = 4, monitor = "DP-1" })
hl.workspace_rule({ workspace = 5, monitor = "DP-1" })
hl.workspace_rule({ workspace = 6, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 7, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 8, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 9, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 10, monitor = "eDP-1" })
