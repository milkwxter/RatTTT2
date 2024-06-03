if CLIENT then
    EVENT.icon = Material("vgui/ttt/dynamic/roles/icon_rat.vmt")
    EVENT.title = "EVENT_RAT_EXPOSE"
	
	hook.Add("Initialize", "ttt2_rat_init", function()
		STATUS:RegisterStatus("ttt2_rat_expose_timer", {
			hud = Material("vgui/ttt/dynamic/roles/icon_rat.vmt"),
			type = "good",
			name = "Rat Expose Timer",
			sidebarDescription = "When this timer finishes, exposes a Traitor to you."
		})
	end)
end

-- Function that returns the name of a Traitor
function exposeTraitorToRat()
    LANG.MsgAll("It worked.", nil, MSG_MSTACK_WARN)
end

--hook that will increase bodies consumed by one
if SERVER then
    hook.Add("EVENT_RAT_EXPOSE", "ttt_rat_exposeHook", exposeTraitorToRat)
end