--PanelMenu variables --
local ShowScoreboard_MainFrame
local ShowScoreboard_OpenSearchBtn
------------------------

-- Data Variables --
local cedFolderDataName   = "cedxmenu/"
local cedScriptName       = "ced_scoreboard_menu/"
local cedPlayerDataFolder = "ownplayercolor/"
local cedPlayerDataFile   = "filedata_savecolor"
local cedDataExtension    = ".txt"
local cedData             = "DATA"
--------------------

-- Sound Variable --
local cedPopSound = "ced_group_xmenu_sounds/pop_up.wav"
--------------------

-- Fonts Variables --
local cedScFont60 = "ced_fonts_Xmenu:Font60"
local cedScFont35 = "ced_fonts_Xmenu:Font35"
local cedScFont30 = "ced_fonts_Xmenu:Font30"
---------------------

-- Image Variables --
local cedPicture1 = "ced_group_xmenu_img/settings.png"
local cedPicture2 = "ced_group_xmenu_img/heart.png"
local cedPicture3 = "ced_group_xmenu_img/kevlar.png"
local cedPicture4 = "ced_group_xmenu_img/food.png"
local cedPicture5 = "ced_group_xmenu_img/magnifier.png"
local cedIcon     = "icon16/cross.png"
---------------------

-- Addon ID --
local cedScoreboardMenu = 2
--------------

-- Variable Value --
local cedListValue
--------------------

-- Color Variable --
local cedWhiteText = cedGroupXmenuConfig.WhiteText
--------------------


-- Hide ScrollHorizontal button
local function ParamDhorizontal(self)
    local w, h = self:GetSize()
    local x = 0
    self.pnlCanvas:SetTall(h)

    for _, v in pairs(self.Panels) do

        if (!IsValid( v )) then continue end
        if (!v:IsVisible()) then continue end

        v:SetPos(x, 0)
        v:SetTall(h)
        v:ApplySchemeSettings()
        x = x + v:GetWide() - self.m_iOverlap
    end

    self.pnlCanvas:SetWide(x + self.m_iOverlap)

    if (w < self.pnlCanvas:GetWide()) then
        self.OffsetX = math.Clamp(self.OffsetX, 0, self.pnlCanvas:GetWide() - self:GetWide())
    else
        self.OffsetX = 0
    end
    self.pnlCanvas.x = self.OffsetX * -1
end 


-- Fadmin Action On Player
local function csU_PlayerSettingsFA(cedPly, cedPanel)
    if not IsValid(cedPanel) then return end
     
	local scrw, scrh = ScrW(), ScrH()

	local PlayerSettingsFA_Background = vgui.Create("DPanel", cedPanel)
    PlayerSettingsFA_Background:SetSize(scrw * 0.15, cedPanel:GetTall())
    PlayerSettingsFA_Background:SetPos(scrw * 0.46, scrh * 0.005)
    PlayerSettingsFA_Background:SetMouseInputEnabled(true)
    PlayerSettingsFA_Background.Paint = nil

    PlayerSettingsFA_Dscrollpanel = vgui.Create("DScrollPanel", PlayerSettingsFA_Background)
   	PlayerSettingsFA_Dscrollpanel:SetSize(PlayerSettingsFA_Background:GetWide(), PlayerSettingsFA_Background:GetTall() - 10)
    PlayerSettingsFA_Dscrollpanel:SetPos(0, 0)

    PlayerSettingsFA_ColorScrollbar = PlayerSettingsFA_Dscrollpanel:GetVBar()
    PlayerSettingsFA_ColorScrollbar.Paint = nil 
    PlayerSettingsFA_ColorScrollbar.btnUp.Paint = nil 
    PlayerSettingsFA_ColorScrollbar.btnDown.Paint = nil
    PlayerSettingsFA_ColorScrollbar.btnGrip.Paint = nil

    PlayerSettingsFA_DlistLayout= vgui.Create("DListLayout",  PlayerSettingsFA_Dscrollpanel)
    PlayerSettingsFA_DlistLayout:SetSize(PlayerSettingsFA_Dscrollpanel:GetWide() - 20, 100)
    PlayerSettingsFA_DlistLayout:SetPos(0, 0)

    local ply = cedPly or FAdmin.ScoreBoard.Player.Player
    FAdmin.ScoreBoard.Player.Player = cedPly

    if not IsValid(ply) or not IsValid(FAdmin.ScoreBoard.Player.Player) then FAdmin.ScoreBoard.ChangeView("Main") return end
                
    for _, v in ipairs(FAdmin.ScoreBoard.Player.ActionButtons) do
        if v.Visible == true or (type(v.Visible) == "function" and v.Visible(FAdmin.ScoreBoard.Player.Player) == true) then

            local Actionbutton_Onplayer = vgui.Create("FAdminActionButton", PlayerSettingsFA_DlistLayout)

            if type(v.Image) == "string" then
                Actionbutton_Onplayer:SetImage(v.Image or "icon16/exclamation")
            elseif type(v.Image) == "table" then
                Actionbutton_Onplayer:SetImage(v.Image[1])
                if v.Image[2] then Actionbutton_Onplayer:SetImage2(v.Image[2]) end
            elseif type(v.Image) == "function" then
                local img1, img2 = v.Image(ply)
                Actionbutton_Onplayer:SetImage(img1)
                if img2 then Actionbutton_Onplayer:SetImage2(img2) end
            else
                Actionbutton_Onplayer:SetImage("icon16/exclamation")
            end

            local name = v.Name
            if type(name) == "function" then name = name(FAdmin.ScoreBoard.Player.Player) end
            Actionbutton_Onplayer:SetText(DarkRP.deLocalise(name))
            Actionbutton_Onplayer:SetBorderColor(Color(255, 255, 255, 100))
            Actionbutton_Onplayer.DoClick = function(self)
                if not IsValid(cedPly) then return end
                return v.Action(cedPly, self)
            end
            if v.OnButtonCreated then
                v.OnButtonCreated(FAdmin.ScoreBoard.Player.Player, Actionbutton_Onplayer)
            end
        end
    end
    return Actionsonplayer_Fadmin
end 


-- Fadmin Server Button
local function csU_ServerSettingsFA()
	if not FAdmin then return end 
    local scrw, scrh = ScrW(), ScrH()

    local _, YPos, Width = 20, FAdmin.ScoreBoard.Y + 120 + FAdmin.ScoreBoard.Height / 5 + 20, (FAdmin.ScoreBoard.Width - 40) / 3

    local ServerSettingsFA_MainFrame = vgui.Create("DFrame")
    ServerSettingsFA_MainFrame:SetSize(scrw * 0.35, scrh * 0.5)
    ServerSettingsFA_MainFrame:Center()
    ServerSettingsFA_MainFrame:SetTitle("")
    ServerSettingsFA_MainFrame:MakePopup()
    ServerSettingsFA_MainFrame:SetDraggable(false)
    ServerSettingsFA_MainFrame:ShowCloseButton(false)
    ServerSettingsFA_MainFrame.Paint = function(self, w, h)
        Derma_DrawBackgroundBlur(self)
    end

    local ServerSettingsFA_ClosButton = vgui.Create("DButton", ServerSettingsFA_MainFrame)
    ServerSettingsFA_ClosButton:SetSize(scrw * 0.05, scrh * 0.02)
    ServerSettingsFA_ClosButton:SetPos(scrw * 0.3, scrh * 0.005)
    ServerSettingsFA_ClosButton:SetText("X")
    ServerSettingsFA_ClosButton:SetTextColor(cedWhiteText)
    ServerSettingsFA_ClosButton.DoClick = function(self, w, h)
        if IsValid(ServerSettingsFA_MainFrame) then 
        	surface.PlaySound(cedPopSound) 
            ServerSettingsFA_MainFrame:Close()
        end 
    end 
    ServerSettingsFA_ClosButton.Paint = function(self, w, h)
        draw.RoundedBox(5, 0, 0, w, h, Color(255, 0, 0, 255))
    end 

    local MainFrame_DScrollPanel_P = vgui.Create("DScrollPanel", ServerSettingsFA_MainFrame)
    MainFrame_DScrollPanel_P:SetSize(ServerSettingsFA_MainFrame:GetWide(), ServerSettingsFA_MainFrame:GetTall() - 25)
    MainFrame_DScrollPanel_P:SetPos(0, 25)

    local sbar = MainFrame_DScrollPanel_P:GetVBar()

    sbar.Paint = function(self, w, h)  
        surface.SetDrawColor(216, 215, 215, 50)
        surface.DrawRect(0, 0, w, h)
    end
    sbar.btnUp.Paint = function(self, w, h) 
        surface.SetDrawColor(45, 41, 41, 255)
        surface.DrawRect(0, 0, w, h)
    end
    sbar.btnDown.Paint = function(self, w, h) 
        surface.SetDrawColor(45, 41, 41, 255)
        surface.DrawRect(0, 0, w, h)
    end
    sbar.btnGrip.Paint = function(self, w, h) 
        surface.SetDrawColor(45, 41, 41, 255)
        surface.DrawRect(0, 0, w, h)
    end

    FAdmin.ScoreBoard.Server.Controls.ServerActionsCat = vgui.Create("FAdminPlayerCatagory", MainFrame_DScrollPanel_P)
    FAdmin.ScoreBoard.Server.Controls.ServerActionsCat:SetLabel("")
    FAdmin.ScoreBoard.Server.Controls.ServerActionsCat.CatagoryColor = Color(155, 0, 0, 255)
    FAdmin.ScoreBoard.Server.Controls.ServerActionsCat:SetSize(MainFrame_DScrollPanel_P:GetWide(), 100)
    FAdmin.ScoreBoard.Server.Controls.ServerActionsCat:SetPos(0, 0)
    FAdmin.ScoreBoard.Server.Controls.ServerActionsCat:SetVisible(true)

    FAdmin.ScoreBoard.Server.Controls.ServerActions = vgui.Create("FAdminPanelList")
    FAdmin.ScoreBoard.Server.Controls.ServerActionsCat:SetContents(FAdmin.ScoreBoard.Server.Controls.ServerActions)
    FAdmin.ScoreBoard.Server.Controls.ServerActions:SetTall(FAdmin.ScoreBoard.Height - 20 - YPos)
    for k, v in pairs(FAdmin.ScoreBoard.Server.Controls.ServerActions:GetChildren()) do
        if k == 1 then continue end
        v:Remove()
    end

    FAdmin.ScoreBoard.Server.Controls.PlayerActionsCat = vgui.Create("FAdminPlayerCatagory", MainFrame_DScrollPanel_P)
    FAdmin.ScoreBoard.Server.Controls.PlayerActionsCat:SetLabel("")
    FAdmin.ScoreBoard.Server.Controls.PlayerActionsCat.CatagoryColor = Color(0, 155, 0, 255)
    FAdmin.ScoreBoard.Server.Controls.PlayerActionsCat:SetSize(MainFrame_DScrollPanel_P:GetWide(), 100)
    FAdmin.ScoreBoard.Server.Controls.PlayerActionsCat:SetPos(0, 275)
    FAdmin.ScoreBoard.Server.Controls.PlayerActionsCat:SetVisible(true)

    FAdmin.ScoreBoard.Server.Controls.PlayerActions = vgui.Create("FAdminPanelList")
    FAdmin.ScoreBoard.Server.Controls.PlayerActionsCat:SetContents(FAdmin.ScoreBoard.Server.Controls.PlayerActions)
    FAdmin.ScoreBoard.Server.Controls.PlayerActions:SetTall(FAdmin.ScoreBoard.Height - 20 - YPos)
    for k, v in pairs(FAdmin.ScoreBoard.Server.Controls.PlayerActions:GetChildren()) do
        if k == 1 then continue end
        v:Remove()
    end

    FAdmin.ScoreBoard.Server.Controls.ServerSettingsCat = vgui.Create("FAdminPlayerCatagory", MainFrame_DScrollPanel_P)
    FAdmin.ScoreBoard.Server.Controls.ServerSettingsCat:SetLabel("")
    FAdmin.ScoreBoard.Server.Controls.ServerSettingsCat.CatagoryColor = Color(0, 0, 155, 255)
    FAdmin.ScoreBoard.Server.Controls.ServerSettingsCat:SetSize(MainFrame_DScrollPanel_P:GetWide(), 100)
    FAdmin.ScoreBoard.Server.Controls.ServerSettingsCat:SetPos(0, 505)
    FAdmin.ScoreBoard.Server.Controls.ServerSettingsCat:SetVisible(true)

    FAdmin.ScoreBoard.Server.Controls.ServerSettings = vgui.Create("FAdminPanelList")
    FAdmin.ScoreBoard.Server.Controls.ServerSettingsCat:SetContents(FAdmin.ScoreBoard.Server.Controls.ServerSettings)
    FAdmin.ScoreBoard.Server.Controls.ServerSettings:SetTall(0)
    for k, v in pairs(FAdmin.ScoreBoard.Server.Controls.ServerSettings:GetChildren()) do
        if k == 1 then continue end
        v:Remove()
    end

    for k, v in pairs(FAdmin.ScoreBoard.Server.ActionButtons) do

        local FadminActions = vgui.Create("FAdminActionButton")

        if type(v.Image) == "string" then
            FadminActions:SetImage(v.Image or cedIcon)
        elseif type(v.Image) == "table" then 
            FadminActions:SetImage(v.Image[1])
            if v.Image[2] then FadminActions:SetImage2(v.Image[2]) end 
        elseif type(v.Image) == "function" then 
            local active, disable = v.Image()
            FadminActions:SetImage(active)
            if disable then FadminActions:SetImage2(disable) end 
        else 
            FadminActions:SetImage(cedIcon)
        end

        local Names = v.Name
        if type(Names) == "function" then Names = Names() end 

        FadminActions:SetText(Names)
        FadminActions:SetBorderColor(v.color)
        FadminActions:Dock(TOP)

        FadminActions.DoClick = function(self)
           return v.Action(self)
        end
        FAdmin.ScoreBoard.Server.Controls[v.TYPE]:Add(FadminActions)
    end 
end 


-- Show Firts Player Info
local function csU_MainPlayerInfo(cedPly, cedPanel)
	if not IsValid(cedPly) then return end 
    if not DarkRP then print("Vous n'avez pas le Darkrp sur votre serveur ! ") return end 

    local scrh = ScrH()


	local csU_TableInfoPlayer = {
		[1] = {info = cedPly:GetUserGroup(), posX = 0, posY = 0.12},
		[2] = {info = cedPly:Ping(), posX = 0, posY =  0.3},
		[3] = {info = cedPly:getDarkRPVar("rpname"), posX = 0, posY = 0.05},
	}

	for _, vInfo in ipairs(csU_TableInfoPlayer) do

		local InfoOfPlayer_MainDlabel = vgui.Create("DLabel", cedPanel)
		InfoOfPlayer_MainDlabel:SetSize(cedPanel:GetWide(), scrh * 0.2)
		InfoOfPlayer_MainDlabel:SetPos(vInfo.posX, scrh * vInfo.posY)
		InfoOfPlayer_MainDlabel:SetText(vInfo.info)
		InfoOfPlayer_MainDlabel:SetTextColor(cedWhiteText)
		InfoOfPlayer_MainDlabel:SetFont(cedScFont60)
		InfoOfPlayer_MainDlabel:SetContentAlignment(5)
	end 
end 


-- Draw info about Player
local function csU_InfoPlayerPanel(cedPly, cedPanel, ShowScoreboard_Scroller)
	if not IsValid(cedPly) then return end 
    if not DarkRP then print("Vous n'avez pas le Darkrp sur votre serveur ! ") return end 

	local scrw, scrh  = ScrW(), ScrH()
	local cedPlayerHealth
	local cedPlayerArmor
    local cedPlyName   = cedPly:GetName() 
    local cedAlignText = TEXT_ALIGN_CENTER
	
	if not cedPly:IsBot() then 
		cedPlayerHealth = math.Clamp(cedPly:Health(), 0, 100)
		cedPlayerArmor  = math.Clamp(cedPly:Armor(), 0, 100)
	else
        cedPlayerHealth = 100
        cedPlayerArmor = 100
        --return
	end 

	local csU_InfoPlayerPanel_InfoTable = {
		[1] = {name = "Vous avez copié le nom Steam de : ", Text = "Nom Steam : " .. cedPlyName, posY = 0.005, posX = 0.085},
		[2] = {name = "Vous avez copié le SteamID de : ", Text = "Steam ID : " .. cedPly:SteamID(), posY = 0.055, posX = 0.085},
		[3] = {name = "", Text = "Profil Steam : ", posY = 0.11, posX = 0.085},
		[4] = {name = "", Text = "Kills : " .. cedPly:Frags(), posY = 0.18, posX = 0.005},
		[5] = {name = "", Text = "Morts : " .. cedPly:Deaths(), posY = 0.14, posX = 0.005}
	}	

	local InfoPlayerPanel_MainFrame = vgui.Create("DPanel", cedPanel)
	InfoPlayerPanel_MainFrame:SetMouseInputEnabled(false)
	InfoPlayerPanel_MainFrame:SetPos(0, scrh * 0.035)
	InfoPlayerPanel_MainFrame:SetMouseInputEnabled(true)
	InfoPlayerPanel_MainFrame.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plyMainColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
		surface.DrawOutlinedRect(0, 0, w, h)
	end 
	InfoPlayerPanel_MainFrame.OnMousePressed = function(self, key)
		if key ~= 107 then return end 

		if IsValid(InfoPlayerPanel_MainFrame) then
			InfoPlayerPanel_MainFrame:SetMouseInputEnabled(false)
			surface.PlaySound(cedPopSound) 

			InfoPlayerPanel_MainFrame:SizeTo(0, 0, 0.8, 0,-1, function()
				InfoPlayerPanel_MainFrame:Remove()
				ShowScoreboard_Scroller:Show()
				ShowScoreboard_OpenSearchBtn:SetEnabled(true)
			end)
		end 
	end

	InfoPlayerPanel_MainFrame:SizeTo(cedPanel:GetWide(), cedPanel:GetTall() - 28,  0.8, 0,-1, function() 
	
        if IsValid(cedPanel) then 
            timer.Create("InfoPlayerPanel_FadminButton", 0.1, 1, function()
                csU_PlayerSettingsFA(cedPly, InfoPlayerPanel_MainFrame)
            end)
        end 

    	local InfoPlayerPanel_PlayerAvatar = vgui.Create("AvatarImage", InfoPlayerPanel_MainFrame)
    	InfoPlayerPanel_PlayerAvatar:SetSize(scrw * 0.08, scrh * 0.14)
    	InfoPlayerPanel_PlayerAvatar:SetPos(scrw * 0.002, scrh * 0.002)
    	InfoPlayerPanel_PlayerAvatar:SetPlayer(cedPly, 124)

    	for id, vInfo in ipairs(csU_InfoPlayerPanel_InfoTable) do

    		local InfoPlayerPanel_SteamName = vgui.Create( "DLabel", InfoPlayerPanel_MainFrame)
    		InfoPlayerPanel_SteamName:SetPos(scrw * vInfo.posX, scrh * vInfo.posY)
    		InfoPlayerPanel_SteamName:SetText(vInfo.Text)
    		InfoPlayerPanel_SteamName:SetFont(cedScFont35)
    		InfoPlayerPanel_SteamName:SetTextColor(cedWhiteText)
    		InfoPlayerPanel_SteamName:SetMouseInputEnabled(true)
    		InfoPlayerPanel_SteamName:SizeToContents()
    		InfoPlayerPanel_SteamName.DoClick = function()
    			if id >= 3  then return end
                caE_GenericNotify(vInfo.name .. cedPlyName, cedGroupXmenuConfig.Scoreboard.plyMainColor, cedGroupXmenuConfig.Scoreboard.plySecondColor)
    		end 
    		InfoPlayerPanel_SteamName.Paint = function(self, w, h)
    			if id >= 3  then return end 
    			if self:IsHovered() then 
    				surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
    				surface.DrawRect(0, 0, w, h)
    			else
    				return 
    			end 
    		end

    		if id == 3 then 
    			local InfoPlayerPanel_ProfilBtn = vgui.Create("DButton", InfoPlayerPanel_MainFrame)
    			InfoPlayerPanel_ProfilBtn:SetPos(scrw * 0.16, scrh * 0.119)
    			InfoPlayerPanel_ProfilBtn:SetText(cedGroupXmenuConfig.Scoreboard.SteamProfil)
    			InfoPlayerPanel_ProfilBtn:SetTextColor(cedWhiteText)
    			InfoPlayerPanel_ProfilBtn:SizeToContents()
    			InfoPlayerPanel_ProfilBtn.DoClick = function()
    				cedPly:ShowProfile()
    			end 
    			InfoPlayerPanel_ProfilBtn.Paint = nil
    		end
    	end

    	if cedGroupXmenuConfig.WlUserGroup[LocalPlayer():GetUserGroup()] then 

    		local InfoPlayerPanel_TableAdminInfo = {
    			[1] = {Text = "Métier: " .. team.GetName(cedPly:Team()), posY = 0.045, posX = 0.25},
    			[2] = {Text = "Grade: " .. cedPly:GetUserGroup(), posY = 0.145, posX = 0.25},
    			[3] = {Text = "Argent: " .. cedPly:getDarkRPVar("money") .. " €", posY = 0.093, posX = 0.25},
    		}

    		local InfoPlayerPanel_DarkrpInfo = vgui.Create("DPanel", InfoPlayerPanel_MainFrame)
    		InfoPlayerPanel_DarkrpInfo:SetSize(scrw * 0.415, scrh * 0.2)
    		InfoPlayerPanel_DarkrpInfo:SetPos(scrw * 0.005, scrh * 0.27)
    		InfoPlayerPanel_DarkrpInfo.Paint = function(self, w, h)
                local cedFood      = cedPly:getDarkRPVar("Energy") or 0
                
    			surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
    			surface.DrawOutlinedRect(0, 0, w, h)

    			-- HEALTH 
    			surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
    			surface.DrawOutlinedRect(scrw * 0.039, scrh * 0.05, 200, 25)

    			surface.SetDrawColor(Color(255, 0, 0, 255))
    			surface.DrawRect(scrw * 0.039, scrh * 0.05, cedPlayerHealth * 2, 25)

    			surface.SetMaterial(Material(cedPicture2))
    			surface.DrawTexturedRect(scrw * 0.01, scrh * 0.05, 25, 25)

    			draw.SimpleText(cedPly:Health(), cedScFont30, scrw * 0.098, scrh * 0.0457, cedGroupXmenuConfig.WhiteText, cedAlignText)

    			-- ARMOR
    			surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
    			surface.DrawOutlinedRect(scrw * 0.039, scrh * 0.1, 200, 25)

    			surface.SetDrawColor(Color(7, 141, 236, 255))
    			surface.DrawRect(scrw * 0.039, scrh * 0.1, cedPlayerArmor * 2, 25)

    			surface.SetMaterial(Material(cedPicture3))
    			surface.DrawTexturedRect(scrw * 0.01, scrh * 0.1, 25, 25)

    			draw.SimpleText(cedPly:Armor(), cedScFont30, scrw * 0.098, scrh * 0.095, cedGroupXmenuConfig.WhiteText, cedAlignText)

    			-- FOOD
    			surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
    			surface.DrawOutlinedRect(scrw * 0.039, scrh * 0.15, 200, 25)

    			surface.SetDrawColor(Color(29, 236, 7, 255))
    			surface.DrawRect(scrw * 0.039, scrh * 0.15, cedFood * 2 , 25)

    			surface.SetMaterial(Material(cedPicture4))
    			surface.DrawTexturedRect(scrw * 0.01, scrh * 0.15, 25, 25)
    			
    			draw.SimpleText(cedFood, cedScFont30, scrw * 0.098, scrh * 0.145, cedGroupXmenuConfig.WhiteText, cedAlignText)
    		end  

    		for _, vInfo in ipairs(InfoPlayerPanel_TableAdminInfo) do

    			local InfoPlayerPanel_StaffInfo = vgui.Create("DLabel", InfoPlayerPanel_DarkrpInfo)
    			InfoPlayerPanel_StaffInfo:SetPos(scrw * vInfo.posX, scrh * vInfo.posY)
    			InfoPlayerPanel_StaffInfo:SetText(vInfo.Text)
    			InfoPlayerPanel_StaffInfo:SetTextColor(cedWhiteText)
    			InfoPlayerPanel_StaffInfo:SetFont(cedScFont35)
    			InfoPlayerPanel_StaffInfo:SizeToContents()	
    		end

    		local InfoPlayerPanel_Title = vgui.Create("DLabel", InfoPlayerPanel_DarkrpInfo)
    		InfoPlayerPanel_Title:SetPos(scrw * 0.12, scrh * 0.00)
    		InfoPlayerPanel_Title:SetText(cedGroupXmenuConfig.Scoreboard.InfoPlayer)
    		InfoPlayerPanel_Title:SetTextColor(cedWhiteText)
    		InfoPlayerPanel_Title:SetFont(cedScFont35)
    		InfoPlayerPanel_Title:SizeToContents()
    	end 
	end)
end 


-- Show the Main Menu 
local function csU_ShowScoreboard()
    
    local scrw, scrh = ScrW(), ScrH()
    local plyOnline  = player.GetCount()
    local maxPlayers = game.MaxPlayers()

	if cedGroupXmenuConfig.Scoreboard.WlSteamID[LocalPlayer():SteamID()] then 
		plyOnline = plyOnline - 1
	end 

	if file.Exists(cedFolderDataName .. cedScriptName .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData) then 
		local cedDataValue = file.Read(cedFolderDataName .. cedScriptName .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData)  
        cedDataValue  = util.JSONToTable(cedDataValue)

        cedGroupXmenuConfig.Scoreboard.plyMainColor = Color(cedDataValue["MainColor"].r, cedDataValue["MainColor"].g, cedDataValue["MainColor"].b, cedDataValue["MainColor"].a)
        cedGroupXmenuConfig.Scoreboard.plySecondColor = Color(cedDataValue["cedSecColor"].r, cedDataValue["cedSecColor"].g, cedDataValue["cedSecColor"].b, cedDataValue["cedSecColor"].a)
    else
        cedGroupXmenuConfig.Scoreboard.plyMainColor   = cedGroupXmenuConfig.Scoreboard.DfMainColor
        cedGroupXmenuConfig.Scoreboard.plySecondColor = cedGroupXmenuConfig.Scoreboard.DfSecondColor
	end 

	ShowScoreboard_MainFrame = vgui.Create("DFrame")
	ShowScoreboard_MainFrame:SetSize(scrw * 0.6, scrh * 0.52)
	ShowScoreboard_MainFrame:Center()
	ShowScoreboard_MainFrame:MakePopup()
	ShowScoreboard_MainFrame:SetDraggable(false)
	ShowScoreboard_MainFrame:ShowCloseButton(false)
	ShowScoreboard_MainFrame:SetTitle("")
	ShowScoreboard_MainFrame.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plyMainColor)
		surface.DrawRect(0, 0, w, h)
	end 

	local ShowScoreboard_Title = vgui.Create("DLabel", ShowScoreboard_MainFrame)
    ShowScoreboard_Title:SetSize(scrw * 0.22, scrh * 0.03)
	ShowScoreboard_Title:SetPos(scrw * 0.18, 0)
	ShowScoreboard_Title:SetFont(cedScFont35)
	ShowScoreboard_Title:SetText(cedGroupXmenuConfig.Scoreboard.ServerName)
	ShowScoreboard_Title:SetTextColor(cedWhiteText)
    ShowScoreboard_Title:SetContentAlignment(5)
	ShowScoreboard_Title:SetMouseInputEnabled(true)
	ShowScoreboard_Title.Paint = function(self, w, h)
		if self:IsHovered() then 
			surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
			surface.DrawRect(0, 0, w, h)
		end 
	end 
	ShowScoreboard_Title.DoClick = function()
		if IsValid(ShowScoreboard_MainFrame) then
            surface.PlaySound(cedPopSound) 
			ShowScoreboard_MainFrame:Remove()
			csU_ServerSettingsFA()
		end 
	end 

	local ShowScoreboard_PlayerNumber = vgui.Create("DLabel", ShowScoreboard_MainFrame)
	ShowScoreboard_PlayerNumber:SetPos(scrw * 0.005, scrh * 0.003)
	ShowScoreboard_PlayerNumber:SetText(cedGroupXmenuConfig.Scoreboard.OnlinePlayer  .. plyOnline .. "/" .. maxPlayers)
	ShowScoreboard_PlayerNumber:SetTextColor(cedWhiteText)
	ShowScoreboard_PlayerNumber:SetFont(cedScFont30)
	ShowScoreboard_PlayerNumber:SizeToContents()

	local ShowScoreboard_SettingsBtn = vgui.Create("DImageButton", ShowScoreboard_MainFrame)
	ShowScoreboard_SettingsBtn:SetSize(scrw * 0.020, scrh * 0.030)
	ShowScoreboard_SettingsBtn:SetPos(scrw * 0.57, scrh * 0.005)
	ShowScoreboard_SettingsBtn:SetImage(cedPicture1)
	ShowScoreboard_SettingsBtn.DoClick = function()
        caE_CheckOfData(cedScriptName)
        caE_MenuOfSettings(ShowScoreboard_MainFrame, cedScriptName, cedScoreboardMenu, 0.4)
		ShowScoreboard_SettingsBtn:SetEnabled(false)
	end 

	local ShowScoreboard_Scroller = vgui.Create( "DHorizontalScroller", ShowScoreboard_MainFrame)
	ShowScoreboard_Scroller:SetSize(ShowScoreboard_MainFrame:GetWide() - 10, scrh * 0.47)
	ShowScoreboard_Scroller:SetPos(5, scrh * 0.045)
	ShowScoreboard_Scroller:SetOverlap(-6)
    ShowScoreboard_Scroller.btnLeft:Remove()
    ShowScoreboard_Scroller.btnRight:Remove()
    ShowScoreboard_Scroller.Think = function() end 
    ShowScoreboard_Scroller.PerformLayout = ParamDhorizontal

	for _, vPly in ipairs(player.GetAll()) do

		local ShowScoreboard_PlayerPanel = vgui.Create("DPanel", ShowScoreboard_Scroller)
		ShowScoreboard_PlayerPanel:SetSize(250, 5)
		ShowScoreboard_PlayerPanel:SetMouseInputEnabled(true)
		ShowScoreboard_PlayerPanel.Paint = function(self, w, h)
			if self:IsHovered() then 
				surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
				surface.DrawRect(0, 0, w, h)
			else
				surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plyMainColor)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end 

		ShowScoreboard_PlayerPanel.OnMousePressed = function(self, key)
			if key == 107 then 
				surface.PlaySound(cedPopSound)
				ShowScoreboard_OpenSearchBtn:SetEnabled(false)
				if IsValid(self) then 
					ShowScoreboard_Scroller:Hide()
				end  
			
				csU_InfoPlayerPanel(vPly, ShowScoreboard_MainFrame, ShowScoreboard_Scroller)

			elseif key == 108 then 

				local ShowScoreboard_PlayerAvatar = vgui.Create( "AvatarImage", ShowScoreboard_PlayerPanel)
				ShowScoreboard_PlayerAvatar:SetSize(0, ShowScoreboard_PlayerPanel:GetTall())
				ShowScoreboard_PlayerAvatar:SetPos(0, 0)
				ShowScoreboard_PlayerAvatar:SetPlayer(vPly, 184)
				ShowScoreboard_PlayerPanel:SetMouseInputEnabled(false)
				ShowScoreboard_PlayerAvatar:SizeTo(ShowScoreboard_PlayerPanel:GetWide(), ShowScoreboard_PlayerPanel:GetTall(), 0.5, 0, -1, function()
					SetClipboardText(vPly:SteamID())
                    caE_GenericNotify(" SteamID copié de : " ..  vPly:getDarkRPVar("rpname"), cedGroupXmenuConfig.Scoreboard.plyMainColor, cedGroupXmenuConfig.Scoreboard.plySecondColor)
					ShowScoreboard_PlayerPanel:SetMouseInputEnabled(true)
				end)
				ShowScoreboard_PlayerAvatar.OnMousePressed = function(self, key)
					if key ~= 108 then return end 
					if IsValid(ShowScoreboard_PlayerAvatar) then 
						ShowScoreboard_PlayerAvatar:SizeTo(0, ShowScoreboard_PlayerPanel:GetTall(), 0.5, 0, -1, function() ShowScoreboard_PlayerAvatar:Remove() end)
					end 
				end
			end
		end 

		ShowScoreboard_OpenSearchBtn = vgui.Create("DImageButton", ShowScoreboard_MainFrame)
		ShowScoreboard_OpenSearchBtn:SetSize(scrw * 0.020, scrh * 0.030)
		ShowScoreboard_OpenSearchBtn:SetPos(scrw * 0.53, scrh * 0.005)
		ShowScoreboard_OpenSearchBtn:SetImage(cedPicture5)
		ShowScoreboard_OpenSearchBtn.DoClick = function(self)
			if IsValid(ShowScoreboard_Scroller) then 
				ShowScoreboard_Scroller:Hide()
			end
			ShowScoreboard_OpenSearchBtn:SetEnabled(false)

			local ShowScoreboard_SearchPanel = vgui.Create("DPanel", ShowScoreboard_MainFrame)
			ShowScoreboard_SearchPanel:SetSize(scrw * 0.4, ShowScoreboard_MainFrame:GetTall() - scrh * 0.05)
			ShowScoreboard_SearchPanel:SetPos(scrw * 0.1, scrh * 0.05)
			ShowScoreboard_SearchPanel.Paint = function(self, w, h)
				surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plyMainColor)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
				surface.DrawOutlinedRect(0, 0, w, h)
			end 

			local ShowScoreboard_PlayerList = vgui.Create("DListView", ShowScoreboard_SearchPanel)
			ShowScoreboard_PlayerList:SetSize(200, ShowScoreboard_SearchPanel:GetTall() - 10)
			ShowScoreboard_PlayerList:SetPos(10, 5)
			ShowScoreboard_PlayerList:SetMultiSelect(false)
			ShowScoreboard_PlayerList:AddColumn("")
			ShowScoreboard_PlayerList:SetHideHeaders(true)
			ShowScoreboard_PlayerList:SetPaintBackground(true)
			ShowScoreboard_PlayerList:SetBackgroundColor(Color(255, 0, 0, 255)) 

			for k, v in ipairs(player.GetAll()) do
				ShowScoreboard_PlayerList:AddLine(v)
			end 
			ShowScoreboard_PlayerList.OnRowSelected = function(self, _, pnl)
				cedListValue = pnl:GetColumnText(1)
			end

			local ShowScoreboard_SearchPlayer = vgui.Create("DButton", ShowScoreboard_SearchPanel)
			ShowScoreboard_SearchPlayer:SetSize(scrw * 0.19, scrh * 0.05)
			ShowScoreboard_SearchPlayer:SetPos(scrw * 0.16, scrh * 0.2)
			ShowScoreboard_SearchPlayer:SetText(cedGroupXmenuConfig.Scoreboard.SearchPlayer)
			ShowScoreboard_SearchPlayer:SetTextColor(cedGroupXmenuConfig.WhiteText)
			ShowScoreboard_SearchPlayer.Paint = function(self, w, h)
				if self:IsHovered() then 
					surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
					surface.DrawRect(0, 0, w, h)
				else
					surface.SetDrawColor(cedGroupXmenuConfig.Scoreboard.plySecondColor)
					surface.DrawOutlinedRect(0, 0, w, h)
				end 

			end
			ShowScoreboard_SearchPlayer.DoClick = function(self)
				if cedListValue == nil then return end 
				if IsValid(ShowScoreboard_SearchPanel) then 
					ShowScoreboard_SearchPanel:Remove()
				end
				surface.PlaySound(cedPopSound) 
				csU_InfoPlayerPanel(cedListValue, ShowScoreboard_MainFrame, ShowScoreboard_Scroller)
			end 
		end 

		if cedGroupXmenuConfig.Scoreboard.WlSteamID[vPly:SteamID()] then 
			if IsValid(ShowScoreboard_PlayerPanel) then 
				ShowScoreboard_PlayerPanel:Remove()
			end
		end 
		ShowScoreboard_Scroller:AddPanel(ShowScoreboard_PlayerPanel)
		csU_MainPlayerInfo(vPly, ShowScoreboard_PlayerPanel)
	end	
	return true
end 


-- Hide Scorebaord 
local function csU_HideScoreboard()

	if IsValid(ShowScoreboard_MainFrame)then 
		ShowScoreboard_MainFrame:Remove()
	end 

	if IsValid(MenuOfSettings_Frame) then 
		MenuOfSettings_Frame:Remove() 
	end 	

	return true 
end

if cedGroupXmenuConfig.EnabledScoreboard == true then 
    hook.Add("ScoreboardShow", "ced_scoreboard_unitrp:ShowScoreboard", csU_ShowScoreboard)
    hook.Add("ScoreboardHide", "ced_scoreboard_unitrp:HideScoreboard", csU_HideScoreboard)
else
    return 
end 