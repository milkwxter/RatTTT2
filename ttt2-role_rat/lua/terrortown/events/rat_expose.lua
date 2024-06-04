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
	local ratTraitorCount = 0
	traitorTable = {}
	for i, v in ipairs( player.GetAll() ) do
		if (v:GetRealTeam() == "traitors") then
			--Create a table and add traitors to that table
			table.insert(traitorTable,v:GetName())  
			ratTraitorCount = ratTraitorCount + 1
		end
	end
	--Randomly select an element in that table
	local randTraitor = traitorTable[math.random(#traitorTable)]
	local ratTraitorString = "One of the traitors is: " .. randTraitor .. ". Kill him or die trying."
	local countTraitorString = "There are " .. ratTraitorCount .. "traitors this match. And they know where you are now!"
	LANG.Msg(ROLE_RAT, countTraitorString, nil, MSG_MSTACK_WARN)
	LANG.Msg(ROLE_RAT, ratTraitorString, nil, MSG_MSTACK_WARN)
	
	-- TODO Print a message using EPOP
end

--hook that expose the traitor to the rat
if SERVER then
    hook.Add("EVENT_RAT_EXPOSE", "ttt_rat_exposeHook", exposeTraitorToRat)
end