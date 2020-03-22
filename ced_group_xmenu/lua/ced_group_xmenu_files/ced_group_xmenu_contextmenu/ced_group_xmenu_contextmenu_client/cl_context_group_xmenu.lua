-- PanelMenu Variables --
local OpenContextMenu_MainFrame 
local OpenContextInfo_PlayerModel
local OpenContextInfo_BackgroundBtnPlMenu
local OpenContextInfo_PlayerName 
local OpenContextInfo_BackgroundModel 
-------------------------

-- Data Variables --
local cedFolderDataName   = "cedxmenu/"
local cedScriptName       = "ced_context_menu/"
local cedPlayerDataFolder = "OwnPlayerColor/"
local cedPlayerDataFile   = "filedata_savecolor"
local cedDataExtension    = ".txt"
local cedData             = "DATA"
--------------------

-- Sound Variable --
local cedSound = "ced_group_xmenu_sounds/pop_up.wav"
--------------------

-- Fonts Variables --
local cedContextMenuFont55 = "ced_fonts_Xmenu:Font55"
local cedContextMenuFont35 = "ced_fonts_Xmenu:Font35"
local cedContextMenuFont27 = "ced_fonts_Xmenu:Font27"
local cedContextMenuFont24 = "ced_fonts_Xmenu:Font24"
---------------------

-- Image Variable --
local cedPicture1 = "ced_group_xmenu_img/settings.png"
--------------------

-- String Variable --
local cedNWID         = "CheckStatutOfPlayer"
local cedTimerName    = "ccM_TimerSendLink"
local cedPlayerHealth = "Vie : "
local cedPlayerArmor  = "Armure : "
local CedPlayerFood   = "Faim : "
---------------------

-- Addon ID --
local cedContextMenu = 3
--------------


-- Cancel Menu
local function ccM_GenericCancelBtn(posx, posy, cedPanel)

	local scrw, scrh = ScrW(), ScrH()

	local GenericCancelBt_Panel = vgui.Create("DButton", cedPanel)
	GenericCancelBt_Panel:SetSize(scrw * 0.1, scrh * 0.05)
	GenericCancelBt_Panel:SetPos(scrw * posx, scrh * posy)
	GenericCancelBt_Panel:SetText(cedGroupXmenuConfig.ContextMenu.CancelBtn)
	GenericCancelBt_Panel:SetFont(cedContextMenuFont24)
	GenericCancelBt_Panel:SetTextColor(cedGroupXmenuConfig.WhiteText)
	GenericCancelBt_Panel.Paint = function(self, w, h)
		if self:IsHovered() then 
				surface.SetDrawColor(Color(0, 0, 0, 220))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
				surface.DrawOutlinedRect(0, 0, w, h)
			else
				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
				surface.DrawOutlinedRect(0, 0, w, h)
		end 
	end
	GenericCancelBt_Panel.DoClick = function()
		if IsValid(cedPanel) then cedPanel:Remove() end 
	end 
end 


-- Show the Server link
local function ccM_MenuServerInfo()
	local scrw, scrh = ScrW(), ScrH()
	local cedPly = LocalPlayer()
	local cedPlyName

	if not IsValid(cedPly) then return end 
	if IsValid(OpenContextMenu_MainFrame) then OpenContextMenu_MainFrame:Remove() end
	

	local MenuServerInfo_MainFrame = vgui.Create("DFrame")
	MenuServerInfo_MainFrame:SetSize(0, 0)
	MenuServerInfo_MainFrame:SetPos(scrw * 0.7, 0)
	MenuServerInfo_MainFrame:SetTitle("")
	MenuServerInfo_MainFrame:MakePopup()
	MenuServerInfo_MainFrame:SetDraggable(false)
	MenuServerInfo_MainFrame:ShowCloseButton(false)
	MenuServerInfo_MainFrame.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	ccM_GenericCancelBtn(0.17, 0.17, MenuServerInfo_MainFrame)

	MenuServerInfo_MainFrame:SizeTo(scrw * 0.3, scrh * 0.23, 0.5, 0, -1, function()

		local MenuServerInfo_Text = vgui.Create("RichText", MenuServerInfo_MainFrame)
		MenuServerInfo_Text:SetSize(scrw * 0.3, scrh * 0.168)
		MenuServerInfo_Text:SetPos(0, 0)
		MenuServerInfo_Text:SetVerticalScrollbarEnabled(false)
		MenuServerInfo_Text.PerformLayout = function()
			MenuServerInfo_Text:SetFontInternal(cedContextMenuFont24)
		end 

		MenuServerInfo_Text:InsertColorChange(255, 255, 255, 255)
		MenuServerInfo_Text:AppendText(cedGroupXmenuConfig.ContextMenu.LinkDiscord .. "\n\n")

		MenuServerInfo_Text:InsertColorChange(255, 255, 255, 255)
		MenuServerInfo_Text:AppendText(cedGroupXmenuConfig.ContextMenu.LinkCollection .. "\n\n")

		MenuServerInfo_Text:InsertColorChange(255, 255, 255, 255)
		MenuServerInfo_Text:AppendText(cedGroupXmenuConfig.ContextMenu.LinkServerStore .. "\n")

		local MenuServerInfo_SendToBtn = vgui.Create("DButton", MenuServerInfo_MainFrame)
		MenuServerInfo_SendToBtn:SetSize(scrw * 0.1, scrh * 0.05)
		MenuServerInfo_SendToBtn:SetPos(scrw * 0.05, scrh * 0.17)
		MenuServerInfo_SendToBtn:SetText(cedGroupXmenuConfig.ContextMenu.SendTo)
		MenuServerInfo_SendToBtn:SetFont(cedContextMenuFont24)
		MenuServerInfo_SendToBtn:SetTextColor(cedGroupXmenuConfig.WhiteText)
		MenuServerInfo_SendToBtn.Paint = function(self, w, h)
			if self:IsHovered() then 
					surface.SetDrawColor(Color(0, 0, 0, 220))
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
					surface.DrawOutlinedRect(0, 0, w, h)
				else
					surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
					surface.DrawOutlinedRect(0, 0, w, h)
			end 
		end
		MenuServerInfo_SendToBtn.DoClick = function()
			if IsValid(MenuServerInfo_MainFrame) then MenuServerInfo_MainFrame:Remove() end 
			

			local MenuServerInfo_SecondFrame = vgui.Create("DFrame")
			MenuServerInfo_SecondFrame:SetSize(scrw * 0.3, scrh * 0.35)
			MenuServerInfo_SecondFrame:Center()
			MenuServerInfo_SecondFrame:SetTitle("")
			MenuServerInfo_SecondFrame:MakePopup()
			MenuServerInfo_SecondFrame:SetDraggable(false)
			MenuServerInfo_SecondFrame:ShowCloseButton(false)
			MenuServerInfo_SecondFrame.Paint = function(self, w, h)
				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			ccM_GenericCancelBtn(0.17, 0.28, MenuServerInfo_SecondFrame)

			local MenuServerInfo_PlayerList = vgui.Create("DListView", MenuServerInfo_SecondFrame)
			MenuServerInfo_PlayerList:SetSize(MenuServerInfo_SecondFrame:GetWide(), scrh * 0.2)
			MenuServerInfo_PlayerList:SetPos(0, scrh * 0.03)
			MenuServerInfo_PlayerList:SetMultiSelect(false)
			MenuServerInfo_PlayerList:SetHideHeaders(true)
			MenuServerInfo_PlayerList:AddColumn("")

			for _, vPly in ipairs(player.GetAll()) do  
				MenuServerInfo_PlayerList:AddLine(vPly)
			end 

			MenuServerInfo_PlayerList.OnRowSelected = function(self, _, pnl)
				cedPlyName = pnl:GetColumnText(1)
			end

			local MenuServerInfo_SendButton = vgui.Create("DButton", MenuServerInfo_SecondFrame)
			MenuServerInfo_SendButton:SetSize(scrw * 0.1, scrh * 0.05)
			MenuServerInfo_SendButton:SetPos(scrw * 0.03, scrh * 0.28)
			MenuServerInfo_SendButton:SetText(cedGroupXmenuConfig.ContextMenu.SendLinks)
			MenuServerInfo_SendButton:SetTextColor(cedGroupXmenuConfig.WhiteText)
			MenuServerInfo_SendButton:SetFont(cedContextMenuFont24)
			MenuServerInfo_SendButton.Paint = function(self, w, h)
				if self:IsHovered() then 
					surface.SetDrawColor(Color(0, 0, 0, 220))
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
					surface.DrawOutlinedRect(0, 0, w, h)
				else
					surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
					surface.DrawRect(0, 0, w, h)

					surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
					surface.DrawOutlinedRect(0, 0, w, h)
				end 
			end

			if timer.Exists(cedTimerName) then 
				MenuServerInfo_SendButton:SetText(cedGroupXmenuConfig.ContextMenu.SendMessageTime .. cedGroupXmenuConfig.ContextMenu.TimeToSendMessage .. "s")
				MenuServerInfo_SendButton:SetEnabled(false)
			end  

			MenuServerInfo_SendButton.DoClick = function()
				if not IsValid(cedPlyName) then return end

				if cedPlyName == cedPly then 
					chat.AddText(cedGroupXmenuConfig.WhiteText, cedGroupXmenuConfig.ContextMenu.SendingCanceled)
				else
					timer.Create(cedTimerName, cedGroupXmenuConfig.ContextMenu.TimeToSendMessage, 1, function() end)
					MenuServerInfo_SendButton:SetEnabled(false)
					MenuServerInfo_SendButton:SetText(cedGroupXmenuConfig.ContextMenu.SendMessageTime .. cedGroupXmenuConfig.ContextMenu.TimeToSendMessage .. "s") 

					net.Start("ced_context_menu.SendInfoToPlayer")
					net.WriteEntity(cedPlyName)
					net.SendToServer()
					chat.AddText(cedGroupXmenuConfig.WhiteText, cedGroupXmenuConfig.ContextMenu.SendingAccepted .. cedPlyName:Nick())
				end
			end 
		end 
	end)
end 


-- Throw Weapons --
local function ccM_MenuDropWeapons()
	local cedPly = LocalPlayer()
	if not IsValid(cedPly) then return end

	if not cedGroupXmenuConfig.ContextMenu.BlackListWeapons[cedPly:GetActiveWeapon():GetClass()] then 
		RunConsoleCommand("say", "/drop")
		caE_GenericNotify(cedGroupXmenuConfig.ContextMenu.DropWeapons, cedGroupXmenuConfig.ContextMenu.plyMainColor, cedGroupXmenuConfig.ContextMenu.plySecondColor)
	else
		caE_GenericNotify(cedGroupXmenuConfig.ContextMenu.NoDropWeapons, cedGroupXmenuConfig.ContextMenu.plyMainColor, cedGroupXmenuConfig.ContextMenu.plySecondColor)
	end 
end 


-- Throw Money --
local function ccM_MenuDropMoney()

	if IsValid(OpenContextMenu_MainFrame) then OpenContextMenu_MainFrame:Remove() end 

	local scrw, scrh = ScrW(), ScrH()
	local cedPly = LocalPlayer()

	if not IsValid(cedPly) then return end 

	local MenuDropMoney_MainFrame = vgui.Create("DFrame")
	MenuDropMoney_MainFrame:SetSize(scrw * 0.3, scrh * 0.25)
	MenuDropMoney_MainFrame:Center()
	MenuDropMoney_MainFrame:MakePopup()
	MenuDropMoney_MainFrame:SetDraggable(false)
	MenuDropMoney_MainFrame:SetTitle("")
	MenuDropMoney_MainFrame:ShowCloseButton(false)
	MenuDropMoney_MainFrame.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	ccM_GenericCancelBtn(0.17, 0.19, MenuDropMoney_MainFrame)

	local MenuDropMoney_Title = vgui.Create("DLabel", MenuDropMoney_MainFrame)
	MenuDropMoney_Title:SetSize(MenuDropMoney_MainFrame:GetWide(), scrh * 0.05)
	MenuDropMoney_Title:SetPos(0, scrh * 0.005)
	MenuDropMoney_Title:SetText(cedGroupXmenuConfig.ContextMenu.DropMoneyTitle)
	MenuDropMoney_Title:SetTextColor(cedGroupXmenuConfig.WhiteText)
	MenuDropMoney_Title:SetFont(cedContextMenuFont35)
	MenuDropMoney_Title:SetContentAlignment(5)

	local MenuDropMoney_MoneyAmount = vgui.Create("DTextEntry", MenuDropMoney_MainFrame)
	MenuDropMoney_MoneyAmount:SetSize(scrw * 0.2, scrh * 0.05)
	MenuDropMoney_MoneyAmount:SetPos(scrw * 0.05, scrh * 0.1)
	MenuDropMoney_MoneyAmount:SetNumeric(true)
	MenuDropMoney_MoneyAmount:SetDrawLanguageID(false)
	MenuDropMoney_MoneyAmount:SetText(cedGroupXmenuConfig.ContextMenu.DfDropMoney)

	local MenuDropMoney_ThrowMoney = vgui.Create("DButton", MenuDropMoney_MainFrame)
	MenuDropMoney_ThrowMoney:SetSize(scrw * 0.1, scrh * 0.05)
	MenuDropMoney_ThrowMoney:SetPos(scrw * 0.03, scrh * 0.19)
	MenuDropMoney_ThrowMoney:SetText(cedGroupXmenuConfig.ContextMenu.DropMoney)
	MenuDropMoney_ThrowMoney:SetTextColor(cedGroupXmenuConfig.WhiteText)
	MenuDropMoney_ThrowMoney.Paint = function(self, w, h)
		if self:IsHovered() then 
			surface.SetDrawColor(Color(0, 0, 0, 220))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
			surface.DrawOutlinedRect(0, 0, w, h)
		else
			surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
			surface.DrawOutlinedRect(0, 0, w, h)
		end 
	end
	MenuDropMoney_ThrowMoney.DoClick = function()
		local cedMoneyValue = MenuDropMoney_MoneyAmount:GetValue()
		if cedMoneyValue == cedGroupXmenuConfig.ContextMenu.DfDropMoney then return end 

		if cedPly:canAfford(cedMoneyValue) then 
			surface.PlaySound(cedSound)
			caE_GenericNotify(cedGroupXmenuConfig.ContextMenu.DropMoneyTofloor .. cedMoneyValue .. "€", cedGroupXmenuConfig.ContextMenu.plyMainColor, cedGroupXmenuConfig.ContextMenu.plySecondColor)
			RunConsoleCommand("say", "/dropmoney  " .. cedMoneyValue)
			if IsValid(MenuDropMoney_MainFrame) then MenuDropMoney_MainFrame:Remove() end 
		else
			return 
		end 
	end 
end


-- Admin Mode function -- 
local function ccM_AdminMode()
	local cedPly = LocalPlayer()
	local cedNoOwner

	if not IsValid(cedPly) then return end 
	if not cedGroupXmenuConfig.WlUserGroup[cedPly:GetUserGroup()] then return end 

	if cedPly:GetNWBool(cedNWID) == false then 
		cedPly:SetNWBool(cedNWID, true)
		hook.Add("HUDPaint", "ced_context_menu:AdminModeHUD", function()

			for _, vPly in pairs(player.GetAll()) do
				if cedPly:SteamID() == cedGroupXmenuConfig.Scoreboard.WlSteamID[vPly:SteamID()] then continue end 
			 	if cedPly != vPly then 
			 		local pos = vPly:GetShootPos() 

			 		pos.z = pos.z + 5 
			 		pos = pos:ToScreen() 

			 		if pos.visible == false then continue end 

			 		local x, y = pos.x, pos.y 

			 		if vPly:GetPos():Distance(cedPly:GetPos()) < 15000 then 
			 			surface.SetDrawColor(team.GetColor(vPly:Team()))
						surface.DrawTexturedRect(x - 5, y - 25, 20, 20)
			 			draw.DrawText(vPly:GetName(), cedContextMenuFont55, x+10 , y - 90, cedGroupXmenuConfig.WhiteText, TEXT_ALIGN_CENTER) 
			 		end 
			 	end 
			end 

			for _, vEntity in pairs (ents.GetAll()) do 

				if vEntity:IsVehicle() then
					if vEntity:getDoorOwner() == nil then 
						cedNoOwner = cedGroupXmenuConfig.ContextMenu.NoOwner
					else
						cedNoOwner = vEntity:getDoorOwner():GetName()
					end

					local pos = vEntity:GetPos()
					pos.z = pos.z + 20
					pos = pos:ToScreen()
					if pos.visible == false then continue end 

					local x, y = pos.x, pos.y

					if cedPly:GetPos():Distance(vEntity:GetPos()) < 15000 then
						draw.DrawText(cedNoOwner, cedContextMenuFont55, x - 32 , y - 32, cedGroupXmenuConfig.WhiteText, TEXT_ALIGN_CENTER)
					end
				end 
			end 
		end)
	else
		hook.Remove("HUDPaint", "ced_context_menu:AdminModeHUD")
		cedPly:SetNWBool(cedNWID, false)
	end 

	net.Start("ced_context_menu.SetAdminPlayer")
	net.WriteBool(cedPly:GetNWBool(cedNWID))
	net.SendToServer()

	if cedPly:GetNWBool(cedNWID) == true then 
		caE_GenericNotify(cedGroupXmenuConfig.ContextMenu.JoinAdminMode, cedGroupXmenuConfig.ContextMenu.plyMainColor, cedGroupXmenuConfig.ContextMenu.plySecondColor)
	else
		caE_GenericNotify(cedGroupXmenuConfig.ContextMenu.LeaveAdminMode, cedGroupXmenuConfig.ContextMenu.plyMainColor, cedGroupXmenuConfig.ContextMenu.plySecondColor)
	end 
end 		


-- ConsoleCommand function --
local function ccM_RunConsole()
	local cedPly = LocalPlayer()
	if not IsValid(cedPly) then return end 

	cedPly:ConCommand("stopsound")
	caE_GenericNotify(cedGroupXmenuConfig.ContextMenu.StopSounds, cedGroupXmenuConfig.ContextMenu.plyMainColor, cedGroupXmenuConfig.ContextMenu.plySecondColor)
end 


local Ced_Action_Table = {
	[1] = {Name = "Les liens communautaires", func = ccM_MenuServerInfo},
	[2] = {Name = "Stopsound", func = ccM_RunConsole},
	[3] = {Name = "Mode Admin", func = ccM_AdminMode},
	[4] = {Name = "Drop Arme", func = ccM_MenuDropWeapons},
	[5] = {Name = "Drop Money", func = ccM_MenuDropMoney},
}


-- Main Context Menu
local function ccM_OpenContextInfo(cedPlyGroup, OpenContextMenu_MainFrame, scrw, scrh)

	local cedPly = LocalPlayer()
	local cedBoolean = false
	if not IsValid(cedPly) then return end 
	if not DarkRP then print("Vous n'avez pas le Darkrp sur votre serveur !") return end 

	
	local OpenContextInfo_Title = vgui.Create("DLabel", OpenContextMenu_MainFrame)
	OpenContextInfo_Title:SetSize(OpenContextMenu_MainFrame:GetWide(), scrh * 0.05)
	OpenContextInfo_Title:SetPos(0, scrh * 0.037)
	OpenContextInfo_Title:SetFont("ced_fonts_Xmenu:Font55")
	OpenContextInfo_Title:SetTextColor(cedGroupXmenuConfig.WhiteText)
	OpenContextInfo_Title:SetText(cedGroupXmenuConfig.ContextMenu.Title)
	OpenContextInfo_Title:SetContentAlignment(5)
	
	local cedHealth = math.Clamp(cedPly:Health(), 0, 100)
	local cedArmor = math.Clamp(cedPly:Armor(), 0, 100)
	local cedHungry = math.Clamp(cedPly:getDarkRPVar("Energy"), 0, 100)

	local OpenContextInfo_PlayerInfoTable = {
		[1] = {Text = "Métier: " .. team.GetName(cedPly:Team()), PosX = 0.35 , PosY = 0.3},
		[2] = {Text = "Grade: " .. cedPly:GetUserGroup(), PosX = 0.06, PosY = 0.3},
		[3] = {Text = "Argent: " .. DarkRP.formatMoney(cedPly:getDarkRPVar("money")) .. " €", PosX = 0.06, PosY = 0.45},
		[4] = {Text = "Salaire: " .. cedPly:getDarkRPVar("salary") .. " €", PosX = 0.35, PosY = 0.45},
		[5] = {Text = "Nom: " .. cedPly:getDarkRPVar("rpname") or cedPly:Nick(), PosX = 0.19, PosY = 0.05}
	}

	local OpenContextInfo_BackgroundBtn = vgui.Create("DPanel", OpenContextMenu_MainFrame)
	OpenContextInfo_BackgroundBtn:SetSize(scrw * 0.19, scrh * 0.45)
	OpenContextInfo_BackgroundBtn:SetPos(scrw * 0.005, scrh * 0.2)
	OpenContextInfo_BackgroundBtn.Paint = nil 

	local OpenContextInfo_Scroll = vgui.Create("DScrollPanel", OpenContextInfo_BackgroundBtn)
	OpenContextInfo_Scroll:SetSize(OpenContextInfo_BackgroundBtn:GetWide(), OpenContextInfo_BackgroundBtn:GetTall() - scrh * 0.02)

	local OpenContextInfo_BtnList = vgui.Create("DListLayout", OpenContextInfo_Scroll)
	OpenContextInfo_BtnList:SetSize(OpenContextInfo_Scroll:GetWide(), OpenContextInfo_Scroll:GetTall())
	OpenContextInfo_BtnList:SetPos(0, 0)
	
	for _, vPly in ipairs(Ced_Action_Table) do

		local OpenContextInfo_ActionBtn = vgui.Create("DButton", OpenContextInfo_BtnList)
		OpenContextInfo_ActionBtn:SetSize(OpenContextInfo_BtnList:GetWide(), scrh * 0.05)
		OpenContextInfo_ActionBtn:SetText(vPly.Name)
		OpenContextInfo_ActionBtn:SetFont(cedContextMenuFont24)
		OpenContextInfo_ActionBtn:SetTextColor(cedGroupXmenuConfig.WhiteText)
		OpenContextInfo_ActionBtn.Paint = function(self, w, h)
			if self:IsHovered() then 
				surface.SetDrawColor(Color(0, 0, 0, 220))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
				surface.DrawOutlinedRect(0, 0, w, h)
			else
				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
				surface.DrawOutlinedRect(0, 0, w, h)
			end 
		end 
		OpenContextInfo_ActionBtn.DoClick = function()
			if IsValid(OpenContextInfo_BackgroundBtnPlMenu) then
				OpenContextInfo_PlayerModel:SetParent(OpenContextInfo_BackgroundModel)
				OpenContextInfo_PlayerName:MoveTo(0, scrh * 0.9, 1.5, 0, -1, function() end)	
				OpenContextInfo_PlayerModel:SizeTo(scrw * 0.2, scrh * 0.45, 1.5, 0, -1, function() end)
				OpenContextInfo_PlayerModel:MoveTo(0, 0, 1.5, 0, -1, function() end)
				OpenContextInfo_BackgroundBtnPlMenu:Remove()
				cedBoolean = false
			end 
			vPly.func() 
		end 
	end

	OpenContextInfo_PlayerName = vgui.Create("DLabel", OpenContextMenu_MainFrame)
	OpenContextInfo_PlayerName:SetSize(OpenContextMenu_MainFrame:GetWide(), scrh * 0.07)
	OpenContextInfo_PlayerName:SetPos(0, scrh * 0.9)
	OpenContextInfo_PlayerName:SetText(cedPly:getDarkRPVar("rpname") or cedPly:Nick())
	OpenContextInfo_PlayerName:SetTextColor(cedGroupXmenuConfig.WhiteText)
	OpenContextInfo_PlayerName:SetFont(cedContextMenuFont55)
	OpenContextInfo_PlayerName:SetContentAlignment(5)

	OpenContextInfo_BackgroundModel = vgui.Create("DPanel", OpenContextMenu_MainFrame)
	OpenContextInfo_BackgroundModel:SetSize(OpenContextMenu_MainFrame:GetWide(), scrh * 0.43)
	OpenContextInfo_BackgroundModel:SetPos(0, scrh * 0.47)
	OpenContextInfo_BackgroundModel.Paint = nil 

	OpenContextInfo_PlayerModel = vgui.Create("DModelPanel", OpenContextInfo_BackgroundModel)
	OpenContextInfo_PlayerModel:SetSize(scrw * 0.2, scrh * 0.45)
	OpenContextInfo_PlayerModel:SetPos(0, 0)
	OpenContextInfo_PlayerModel:SetModel(cedPly:GetModel())
	
	OpenContextInfo_PlayerModel.LayoutEntity = function(cedEntity) return end 
	OpenContextInfo_PlayerModel.DoClick = function()
		if cedBoolean == false then 

			OpenContextInfo_BackgroundBtnPlMenu = vgui.Create("DPanel")
			OpenContextInfo_BackgroundBtnPlMenu:SetSize(scrw * 0.5, scrh * 0.8)
			OpenContextInfo_BackgroundBtnPlMenu:SetPos(scrw * 0.3, scrh * 0.05)
			OpenContextInfo_BackgroundBtnPlMenu.Paint = nil	

			OpenContextInfo_PlayerModel:SetParent(OpenContextInfo_BackgroundBtnPlMenu)

			OpenContextInfo_PlayerName:MoveTo(scrw * 0.5, scrh * 0.5 , 1.5, 0, -1, function() end)
			OpenContextInfo_PlayerModel:SizeTo(scrw * 0.5, scrh * 0.8, 1.5, 0, -1, function() end)
			OpenContextInfo_PlayerModel:MoveTo(0, scrh * 0.005, 1.5, 0, -1, function() 

				for _, vInfo in ipairs(OpenContextInfo_PlayerInfoTable) do

					local OpenContextInfo_PlayerMenu = vgui.Create( "DLabel", OpenContextInfo_BackgroundBtnPlMenu)
					OpenContextInfo_PlayerMenu:SetSize(scrw * 0.12, scrh * 0.05)
					OpenContextInfo_PlayerMenu:SetPos(scrw * vInfo.PosX, scrh * vInfo.PosY)
					OpenContextInfo_PlayerMenu:SetText(vInfo.Text)
					OpenContextInfo_PlayerMenu:SetFont(cedContextMenuFont24)
					OpenContextInfo_PlayerMenu:SetContentAlignment( 5 )
					OpenContextInfo_PlayerMenu:SetTextColor(cedGroupXmenuConfig.WhiteText)
					OpenContextInfo_PlayerMenu.Paint = function(self, w, h)
						surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
						surface.DrawRect(0, 0, w, h)
					end 
				end

				OpenContextInfo_PlayerHud = vgui.Create("DPanel", OpenContextInfo_BackgroundBtnPlMenu)
				OpenContextInfo_PlayerHud:SetSize(scrw * 0.15, scrh * 0.15)
				OpenContextInfo_PlayerHud:SetPos(0 , scrh * 0.64)
				OpenContextInfo_PlayerHud.Paint = function(self, w, h)
					surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor)
					surface.DrawRect(0, 0, w, h)

					draw.SimpleText(cedPlayerHealth .. cedPly:Health(), cedContextMenuFont27, scrw * 0.056, scrh * 0.007, cedGroupXmenuConfig.WhiteText)
					draw.RoundedBox(5, scrw * 0.01, scrh * 0.03, scrw * 0.125, scrh * 0.008, Color(255, 255, 255, 150))
					draw.RoundedBox(5, scrw * 0.01, scrh * 0.03, cedHealth * 2, scrh * 0.008, Color(255, 0, 0, 255))

					draw.SimpleText(cedPlayerArmor .. cedPly:Armor(), cedContextMenuFont27, scrw * 0.056, scrh * 0.057, cedGroupXmenuConfig.WhiteText)
					draw.RoundedBox(5, scrw * 0.01, scrh * 0.08, scrw * 0.125, scrh * 0.008, Color(255, 255, 255, 150))
					draw.RoundedBox(5, scrw * 0.01, scrh * 0.08, cedArmor * 2, scrh * 0.008, Color(52, 152, 219, 255))

					draw.SimpleText(CedPlayerFood .. cedHungry, cedContextMenuFont27, scrw * 0.056, scrh * 0.107, cedGroupXmenuConfig.WhiteText)
					draw.RoundedBox(5, scrw * 0.01, scrh * 0.13, scrw * 0.125, scrh * 0.008, Color(255, 255, 255, 150))
					draw.RoundedBox(5, scrw * 0.01, scrh * 0.13, cedHungry * 2, scrh * 0.008, Color(55, 219, 52, 255))

				end 	
			end)
			cedBoolean = true
		else
			OpenContextInfo_PlayerModel:SetParent(OpenContextInfo_BackgroundModel)

			if IsValid(OpenContextInfo_BackgroundBtnPlMenu) then 
				OpenContextInfo_BackgroundBtnPlMenu:Remove()
			end 

			if IsValid(OpenContextMenu_MainFrame) then 
				OpenContextInfo_PlayerName:MoveTo(0, scrh * 0.9, 1.5, 0, -1, function() end)	
				OpenContextInfo_PlayerModel:SizeTo(scrw * 0.2, scrh * 0.45, 1.5, 0, -1, function() end)
				OpenContextInfo_PlayerModel:MoveTo(0, 0, 1.5, 0, -1, function() end)
				cedBoolean = false
			else
				if IsValid(OpenContextInfo_BackgroundBtnPlMenu) then 
					OpenContextInfo_BackgroundBtnPlMenu:Remove()
				end
			end 
		end 
	end 

	local ContextInfo_Btn = vgui.Create("DImageButton", OpenContextMenu_MainFrame) 
	ContextInfo_Btn:SetSize(scrw * 0.020, scrh * 0.030)
	ContextInfo_Btn:SetPos(scrw * 0.18, scrh * 0.019)
	ContextInfo_Btn:SetImage(cedPicture1)
	ContextInfo_Btn:SetColor(Color(255, 255, 255, 255))
	ContextInfo_Btn.DoClick = function()
		caE_MenuOfSettings(OpenContextMenu_MainFrame, cedScriptName, cedContextMenu, 0.8)
	end 
end 


--Animation Menu Open
local function ccM_OpenContextMenu()
	gui.EnableScreenClicker(true)

	if file.Exists(cedFolderDataName .. cedScriptName .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData) then 
		local cedDataValue  = file.Read(cedFolderDataName .. cedScriptName .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData)
		cedDataValue        = util.JSONToTable(cedDataValue)
		cedGroupXmenuConfig.ContextMenu.plyMainColor   = Color(cedDataValue["MainColor"].r, cedDataValue["MainColor"].g, cedDataValue["MainColor"].b, cedDataValue["MainColor"].a)
		cedGroupXmenuConfig.ContextMenu.plySecondColor = Color(cedDataValue["cedSecColor"].r, cedDataValue["cedSecColor"].g, cedDataValue["cedSecColor"].b, cedDataValue["cedSecColor"].a)
	else
		cedGroupXmenuConfig.ContextMenu.plyMainColor   = cedGroupXmenuConfig.ContextMenu.DfMainColor
		cedGroupXmenuConfig.ContextMenu.plySecondColor = cedGroupXmenuConfig.ContextMenu.DfSecondColor
	end 

	local scrw, scrh = ScrW(), ScrH()
	local cedPly     = LocalPlayer()
	if not IsValid(cedPly) then return end 
	local cedPlyGroup = cedPly:GetUserGroup()

	if IsValid(OpenContextMenu_MainFrame) then OpenContextMenu_MainFrame:Remove() end 

	OpenContextMenu_MainFrame = vgui.Create("DFrame")
	OpenContextMenu_MainFrame:ShowCloseButton(false)
	OpenContextMenu_MainFrame:SetDraggable(false)
	OpenContextMenu_MainFrame:SetTitle("")
	OpenContextMenu_MainFrame.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor )
		surface.DrawRect(0, 15, w, h)

		surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
		surface.DrawRect(0, 0, w, 15)
	end
	OpenContextMenu_MainFrame:SizeTo(scrw * 0.2, scrh * 0.15, 0.5, 0, -1, function()

		local OpenContextMenu_ExpendMenuBtn = vgui.Create("DButton", OpenContextMenu_MainFrame) 
		OpenContextMenu_ExpendMenuBtn:SetSize(scrw * 0.13, scrh * 0.03)
		OpenContextMenu_ExpendMenuBtn:Center()
		OpenContextMenu_ExpendMenuBtn:SetText("Context Menu de: " .. cedPlyGroup)
		OpenContextMenu_ExpendMenuBtn:SetTextColor(cedGroupXmenuConfig.WhiteText)
		OpenContextMenu_ExpendMenuBtn:SetFont(cedContextMenuFont24)
		OpenContextMenu_ExpendMenuBtn.Paint = function(self, w, h)
			if self:IsHovered() then 
				surface.SetDrawColor(Color(0, 0, 0, 220))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
				surface.DrawOutlinedRect(0, 0, w, h)
			else
				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plyMainColor )
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(cedGroupXmenuConfig.ContextMenu.plySecondColor)
				surface.DrawOutlinedRect(0, 0, w, h)
			end 
		end	
		OpenContextMenu_ExpendMenuBtn.DoClick = function(self)
			if IsValid(OpenContextMenu_ExpendMenuBtn) then 
				OpenContextMenu_ExpendMenuBtn:Remove()
			end 

			if IsValid(OpenContextMenu_MainFrame) then 
				OpenContextMenu_MainFrame:SizeTo(scrw * 0.2, scrh, 0.5, 0, -1, function() 		
					ccM_OpenContextInfo(cedPlyGroup, OpenContextMenu_MainFrame, scrw, scrh) 
				end)
			end 
		end 
	end) 
	return true
end


-- Close Context Menu --
local function ccM_CloseContextMenuy()
	gui.EnableScreenClicker(false)

	if IsValid(OpenContextMenu_MainFrame) then
		OpenContextMenu_MainFrame:Remove()
	end 

	if IsValid(OpenContextInfo_BackgroundBtnPlMenu) then 
		OpenContextInfo_BackgroundBtnPlMenu:Remove()
	end 
	return true
end 


if cedGroupXmenuConfig.EnabledContextMenu == true then
	hook.Add("OnContextMenuOpen", "ced_context_menu:OpenContextMenu_MainFrame", ccM_OpenContextMenu)
	hook.Add("OnContextMenuClose", "ced_context_menu:CloseContextMenu", ccM_CloseContextMenuy)
else
	return
end