if CLIENT then
    EVENT.icon = Material("vgui/ttt/dynamic/roles/icon_rat.vmt")
    EVENT.title = "EVENT_RAT_EXPOSE"
	
	hook.Add("Initialize", "ttt2_rat_init", function()
		STATUS:RegisterStatus("ttt2_rat_expose_timer", {
			hud = Material("vgui/ttt/dynamic/roles/icon_rat.vmt"),
			type = "good",
			name = "ratTimerName",
			sidebarDescription = "ratTimerDesc"
		})
	end)
end

-- Function that returns the name of a Traitor
function exposeTraitorToRat()
	noTraitors = false
	-- Create a table
	traitorTable = {}

	-- loop through each player currently in the server
	for i, v in ipairs( player.GetAll() ) do
		if ( v:GetRealTeam() == "traitors" ) then
			-- add traitors to that table
			table.insert(traitorTable, v:GetName())
		end
	end
	--Check if table is empty, end function if so
	if next(traitorTable) == nil then 
		noTraitors = true
		return end
	--Randomly select an element in that table
	local randTraitor = traitorTable[math.random(#traitorTable)]
	
	-- Create a string for the traitor
	ratTraitorString = "One of the traitors is: " .. randTraitor .. ". Kill him or die trying."
	-- Since this string is not local, we can access it later in the shared.lua file
end

if SERVER then
	-- hook that exposes the traitor to the rat
    hook.Add("EVENT_RAT_EXPOSE", "ttt_rat_exposeHook", exposeTraitorToRat)
end