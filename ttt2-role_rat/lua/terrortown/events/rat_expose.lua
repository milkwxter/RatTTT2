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
	-- loop through each player currently in the server
	local ratTraitorString = "The traitors are as follows: "
	local ratTraitorCount = 0
	for i, v in ipairs( player.GetAll() ) do
		if (v:GetRealTeam() == "traitors") then
			ratTraitorString = ratTraitorString .. v:GetName() .. ", "
			ratTraitorCount = ratTraitorCount + 1
		end
	end

	-- tell rat how many traitors there are
	LANG.Msg(ROLE_RAT, "There are " ..  ratTraitorCount .. " traitors in the match.", nil, MSG_MSTACK_WARN)

	-- Print our final string
	LANG.Msg(ROLE_RAT, ratTraitorString, nil, MSG_MSTACK_WARN)
end

-- hook that do all the exposing logic
if SERVER then
    hook.Add("EVENT_RAT_EXPOSE", "ttt_rat_exposeHook", exposeTraitorToRat)
end