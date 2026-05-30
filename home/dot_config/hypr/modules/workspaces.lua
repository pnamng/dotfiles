-- workspace = 1, gapsout:0, gapsin:0
hl.workspace_rule({ workspace = "1", gaps_out = 0, gaps_in = 0 })

-- workspace = 10, gapsout:12 12 12 12
hl.workspace_rule({ workspace = "10", gaps_out = { top = 12, right = 12, bottom = 12, left = 12 } })
