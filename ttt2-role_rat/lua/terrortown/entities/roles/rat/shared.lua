if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_rat.vmt")
end

function ROLE:PreInitialize()
  self.color = Color(143, 127, 100, 255)

  self.abbr = "rat" -- abbreviation
  self.surviveBonus = 0 -- bonus multiplier for every survive while another player was killed
  self.scoreKillsMultiplier = 2 -- multiplier for kill of player of another team
  self.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
  self.unknownTeam = true

  self.defaultTeam = TEAM_INNOCENT

  self.conVarData = {
    pct = 0.17, -- necessary: percentage of getting this role selected (per player)
    maximum = 1, -- maximum amount of roles in a round
    minPlayers = 6, -- minimum amount of players until this role is able to get selected
    credits = 0, -- the starting credits of a specific role
    togglable = true, -- option to toggle a role for a client if possible (F1 menu)
    random = 100,
    traitorButton = 0, -- can use traitor buttons
    shopFallback = SHOP_DISABLED
  }
end

-- now link this subrole with its baserole
function ROLE:Initialize()
  roles.SetBaseRole(self, ROLE_INNOCENT)
end

if SERVER then
	-- Give Loadout on respawn and rolechange
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
    --Start the rat clock
    STATUS:AddTimedStatus(ply, "ttt2_rat_expose_timer", 5, true)
    timer.Create("ttt2_rat_clock_timer", 5, 1, function()
      -- call our custom function to out the traitors
      exposeTraitorToRat()
      -- highlight the rat for all traitors
      for _, ply in ipairs( player.GetAll() ) do
        -- check if player is valid
        if not IsValid(ply) then return end
        -- check if player is actually a rat
        if ply:GetRoleString() == "rat" then
          -- do rat marker
          local mvObject = ply:AddMarkerVision("player_rat")
          mvObject:SetOwner(TEAM_TRAITOR)
          mvObject:SetVisibleFor(VISIBLE_FOR_TEAM)
          mvObject:SyncToClients()
        end
		  end
    end)
	end

	-- Remove Loadout on death and rolechange
	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
  timer.Stop("ttt2_rat_clock_timer")
	end

  -- Remove wallhacks when the rat dies
	hook.Add("TTTOnCorpseCreated", "RatRoleDies", function(rag, ply)
		if not IsValid(rag) or not IsValid(ply) then return end
    if ply:GetRoleString() == "rat" then
      ply:RemoveMarkerVision("player_rat")
    end
	end)
end

-- actual wallhacks part
if CLIENT then
	local TryT = LANG.TryTranslation
	local ParT = LANG.GetParamTranslation

	local materialRat = Material("vgui/ttt/dynamic/roles/icon_rat.vmt")

	hook.Add("TTT2RenderMarkerVisionInfo", "HUDDrawMarkerVisionRatPlayer", function(mvData)
		local ent = mvData:GetEntity()
		local mvObject = mvData:GetMarkerVisionObject()

    if not mvObject:IsObjectFor(ent, "player_rat") then return end

		local distance = math.Round(util.HammerUnitsToMeters(mvData:GetEntityDistance()), 1)

		mvData:EnableText()

		mvData:AddIcon(materialRat)
		mvData:SetTitle("The Rat! Kill him before he exposes your role!")

		mvData:AddDescriptionLine(ParT("marker_vision_distance", {distance = distance}))
		mvData:AddDescriptionLine(TryT(mvObject:GetVisibleForTranslationKey()), COLOR_SLATEGRAY)
	end)
end

if CLIENT then
  net.Receive("ttt2_rat_exposed_net", function()
      -- read the string from the net message
      local stringTitleRat = net.ReadString()
      -- Play a sound for the rat
      surface.PlaySound("rat_squeak.mp3")
      -- present the rat the message the server sent
      EPOP:AddMessage(self, {text =  stringTitleRat, color = TRAITOR.color}, {text = "The Traitors can see your location now. Get ready for a fight!", color = RAT.color}, 6, true)
  end)
end