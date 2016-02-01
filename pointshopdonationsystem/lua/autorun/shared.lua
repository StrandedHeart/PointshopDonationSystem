//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
--																--
--						TicklesTheMLGPro						--
--																--
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

if (CLIENT) then

	local width = ScrW()
	local height = ScrH()
	
	function openDonationPanel()
		local DonationFrame = vgui.Create( "DFrame" )
		DonationFrame:SetPos( width / 4, height / 4 )
		DonationFrame:SetSize( width / 2, height / 2 )
		DonationFrame:SetTitle( "Donate to " .. DonateNetworkName )
		DonationFrame:SetDraggable( false )
		DonationFrame:SetBackgroundBlur( true )
		DonationFrame:ShowCloseButton( false )
		DonationFrame:MoveToBack()
		function DonationFrame:OnClose()
			gui.EnableScreenClicker( false )
			donateaccept:Remove()
		end
		gui.EnableScreenClicker( true )
		
		donateaccept = vgui.Create( "DButton" )
		donateaccept:SetSize( 140, 40 )
		donateaccept:SetPos(ScrW() / 2 - 75, 700)
		donateaccept:SetText( "Donate Now" )
		function donateaccept.DoClick(ply)
			local donateFor = pointsentry:GetValue()
			local finalPrice = donateFor * DonatePointPrice
			gui.OpenURL("https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=" .. DonatePayPalEmail .. "&lc=NZ&item_name=" .. DonateNetworkName .. "&item_number=" .. donateFor .. DonatePointshopPointName .. " " .. steamidentry:GetValue() .. "&amount=" .. math.Round(finalPrice, 0) .. "%2e00&currency_code=" .. DonateCurrency .. "&no_note=0&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHostedGuest")
			donateaccept:Remove()
			DonationFrame:Remove()
			pointsentry:Remove()
			lblPointEntry:Remove()
			closemenu:Remove()
			gui.EnableScreenClicker( false )
		end
		
		closemenu = vgui.Create( "DButton" )
		closemenu:SetSize( 90, 25 )
		closemenu:SetPos(ScrW() / 2 - 50, 750)
		closemenu:SetText( "Cancel" )
		function closemenu.DoClick()
			closemenu:Remove()
			donateaccept:Remove()
			DonationFrame:Remove()
			pointsentry:Remove()
			lblPointEntry:Remove()
			gui.EnableScreenClicker( false )
		end
		
		pointsentry = vgui.Create("DTextEntry", DonationFrame)	-- create the form as a child of frame
		pointsentry:SetMultiline(false)
		pointsentry:SetSize(90,20) 
		pointsentry:SetPos(width / 2 - 50, height / 2 - 150)
		pointsentry:MakePopup()
		
		steamidentry = vgui.Create("DTextEntry", DonationFrame)	-- create the form as a child of frame
		steamidentry:SetMultiline(false)
		steamidentry:SetSize(140,20) 
		local ply = LocalPlayer()
		steamidentry:SetText( ply:SteamID() )
		steamidentry:SetPos(width / 2 - 75, height / 2 - 50)
		steamidentry:MakePopup()
		
		
		lblPointEntry = vgui.Create( "DLabel", DonationFrame )
		lblPointEntry:SetPos( 375, 75 )
		lblPointEntry:SetFont("DermaLarge")
		lblPointEntry:SetText( "How many Points" )
		lblPointEntry:SizeToContents()
		
		lblSteamID = vgui.Create( "DLabel", DonationFrame )
		lblSteamID:SetPos( 425, 175 )
		lblSteamID:SetFont("DermaLarge")
		lblSteamID:SetText( "SteamID" )
		lblSteamID:SizeToContents()
		
		
	end
	
	
	concommand.Add( "ticklesdonate", openDonationPanel )
end

if (SERVER) then

hook.Add( "PlayerSay", "Donate", function( ply, text, public )
	text = string.lower( text )
	if ( text == DonatePointsCommand ) then
		ply:ConCommand("ticklesdonate")
	end
end )
			

end