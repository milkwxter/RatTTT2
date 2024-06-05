if CLIENT then
	hook.Add("Run UI","ttt2_run_ui",function()
	local stringTitleRat = exposeTraitorToRat()
	--if client since only the rat should be hearing noise, and seeing the message
		--reading the string sent by the server
		--displaying the proper message
		EPOP:AddMessage({text =  stringTitleRat, color = TRAITOR.color}, {text = "The Traitors can see your location now. Get ready for a fight!", color = RAT.color}, 6, nil, true)
		--playing the squeak!
		surface.PlaySound("rat_squeak.mp3")
	end)
end