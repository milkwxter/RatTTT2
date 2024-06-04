net.Receive("ttt2_rat_exposed_net", function()
    local stringTitleRat = net.ReadString()
	EPOP:AddMessage({text =  stringTitleRat, color = TRAITOR.color}, {text = "The Traitors can see your location now. Get ready for a fight!", color = RAT.color}, 6, nil, true)
end)