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
	-- Create a table
	traitorTable = {}

	-- loop through each player currently in the server
	for i, v in ipairs( player.GetAll() ) do
		if ( v:GetRealTeam() == "traitors" ) then
			-- add traitors to that table
			table.insert(traitorTable, v:GetName())
		end
	end

	--Randomly select an element in that table
	local randTraitor = traitorTable[math.random(#traitorTable)]

	-- Create a string for the traitor
	local ratTraitorString = "One of the traitors is: " .. randTraitor .. ". Kill him or die trying."
	-- Tell the traitor and the rat certain messages
	net.Start("ttt2_rat_exposed_net")
	net.WriteString(ratTraitorString)
	net.Broadcast()
end

if SERVER then
	-- hook that exposes the traitor to the rat
    hook.Add("EVENT_RAT_EXPOSE", "ttt_rat_exposeHook", exposeTraitorToRat)
	-- required for network messages
	util.AddNetworkString("ttt2_rat_exposed_net")
end