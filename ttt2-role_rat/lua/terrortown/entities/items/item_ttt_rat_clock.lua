if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("ttt2_rat_time")
	resource.AddFile("materials/vgui/ttt/perks/rat_clock.png")
end

ITEM.hud = Material("vgui/ttt/perks/rat_clock.png")
ITEM.EquipMenuData = {
	type = "item_passive",
	name = "Rat Timer",
	desc = "When this timer finishes, you will expose a Traitor."
}
ITEM.material = "vgui/ttt/perks/rat_clock.png"

if SERVER then
	--Start the rat clock
	STATUS:AddTimedStatus(self:GetOwner(), "ttt2_rat_clock_status", 10, true)
		timer.Create("ttt2_rat_clock_timer", 10, 1, function()
	end)
end