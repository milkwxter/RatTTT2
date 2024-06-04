if CLIENT then
	--if client since only the rat should be hearing noise, and seeing the message
	net.Receive("ttt2_rat_exposed_net", function()
		--reading the string sent by the server
		local stringTitleRat = net.ReadString()
		--displaying the proper message
		EPOP:AddMessage({text =  stringTitleRat, color = TRAITOR.color}, {text = "The Traitors can see your location now. Get ready for a fight!", color = RAT.color}, 6, nil, true)
		--playing the squeak!
		surface.PlaySound("rat_squeak.mp3")
	end)
end