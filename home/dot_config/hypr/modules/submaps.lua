local mainMod = "SUPER"

hl.bind("ALT + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("Right", hl.dsp.window.resize({ x = 25, y = 0, relative = true }), { repeating = true })
	hl.bind("Left", hl.dsp.window.resize({ x = -25, y = 0, relative = true }), { repeating = true })
	hl.bind("Up", hl.dsp.window.resize({ x = 0, y = -25, relative = true }), { repeating = true })
	hl.bind("Down", hl.dsp.window.resize({ x = 0, y = 25, relative = true }), { repeating = true })
	hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Entered and left by soft-shell (SwitcherState), never by a key. It binds nothing but a
-- way out, which is the point: with no Super+arrow binds in force, those keys go to the
-- switcher, which has the keyboard. Escape leaves it and the shell cancels the switch.
hl.define_submap("switcher", function()
	-- hl.bind("Escape", hl.dsp.submap("reset"))
	hl.bind(mainMod .. " + Escape", hl.dsp.submap("reset"))
end)
