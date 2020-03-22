-- PanelMenu Variables --
local CreatePanel_MainFrame 
local OpenShowHelp_MainFrame 
-------------------------

-- Data Variables --
local cedFolderDataName   = "cedxmenu/"
local cedScriptName       = "ced_fone_menu/"
local cedPlayerDataFolder = "OwnPlayerColor/"
local cedPlayerDataFile   = "filedata_savecolor"
local cedDataExtension    = ".txt"
local cedData             = "DATA"
--------------------

-- Sound Variable --
local cedSound = "ced_group_xmenu_sounds/pop_up.wav"
--------------------

-- Fonts Variables --
local cedF1Font35 = "ced_fonts_Xmenu:Font35"
local cedF1Font24 = "ced_fonts_Xmenu:Font24"
local cedF1Font27 = "ced_fonts_Xmenu:Font27"
---------------------

-- Image Variable --
local cedPicture1 = "ced_group_xmenu_img/settings.png"
--------------------

-- String Variables --
local cedLawsText       = "loi"
local cedPunishmentText = "Peine"
local cedFineText       = "[Amende de]:"
local cedRulesText      = "Règle"
local cedSanctionText   = "sanction"
local cedTutorialText   = "Tutorial"
local cedLinkText       = "Yt"
----------------------

-- Addon ID --
local cedF1Menu = 1
--------------


-- Fonction for laws, rules 
local function cfmU_CreatePanel(cedFrame, cedTable, cedText1, cedText2, cedText3)

	local cedPly = LocalPlayer()
	local scrw, scrh = ScrW(), ScrH()

	if not IsValid(cedPly) then return end
	if not IsValid(cedFrame) then return end
	if not istable(cedTable) then return end
	if not isstring(cedText1) then return end
	if not isstring(cedText2) then return end
	if not isstring(cedText3) then return end

	CreatePanel_MainFrame = vgui.Create("DPanel", cedFrame)
	CreatePanel_MainFrame:SetSize(cedFrame:GetWide(), cedFrame:GetTall() - 102)
	CreatePanel_MainFrame:SetPos(0, scrh * 0.1)
	CreatePanel_MainFrame.Paint = nil

	local CreatePanel_Scroll = vgui.Create("DScrollPanel", CreatePanel_MainFrame)
	CreatePanel_Scroll:SetSize(CreatePanel_MainFrame:GetWide(), CreatePanel_MainFrame:GetTall())
	CreatePanel_Scroll:SetPos(0, 0)

    local CreatePanel_Sbar = CreatePanel_Scroll:GetVBar()
	CreatePanel_Sbar.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plyMainColor)
		surface.DrawRect(0, 0, w, h)
	end  
	CreatePanel_Sbar.btnUp.Paint   = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
		surface.DrawRect(0, 0, w, h)
	end 
	CreatePanel_Sbar.btnDown.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
		surface.DrawRect(0, 0, w, h)
	end 	
	CreatePanel_Sbar.btnGrip.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
		surface.DrawRect(0, 0, w, h)
	end 

	local CreatePanel_PanelList = vgui.Create("DListLayout", CreatePanel_Scroll)
	CreatePanel_PanelList:SetSize(CreatePanel_Scroll:GetWide(), scrh * 0.2)
	CreatePanel_PanelList:SetPos(0, 0)

	for index, vInfo in ipairs(cedTable) do

		local CreatePanel_SecondPanel = vgui.Create("DPanel", CreatePanel_PanelList)
		CreatePanel_SecondPanel:SetSize(CreatePanel_PanelList:GetWide(), scrh * 0.2)
		CreatePanel_SecondPanel:SetMouseInputEnabled(true)
		CreatePanel_SecondPanel:DockMargin(0, 0, 0, 5)
		CreatePanel_SecondPanel.Paint = function(self, w, h)
			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plyMainColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local CreatePanel_SPanelTitle = vgui.Create("DLabel", CreatePanel_SecondPanel)
		CreatePanel_SPanelTitle:SetSize(scrw * 0.15, scrh * 0.05)
		CreatePanel_SPanelTitle:SetPos(scrw * 0.02, 0)
		CreatePanel_SPanelTitle:SetText("[" .. cedText1 .. " n°".. index .. "]" .. vInfo.Name)
		CreatePanel_SPanelTitle:SetTextColor(cedGroupXmenuConfig.WhiteText)
		CreatePanel_SPanelTitle:SetFont(cedF1Font35)
		CreatePanel_SPanelTitle:SetMouseInputEnabled(true)
		CreatePanel_SPanelTitle:SetContentAlignment(5)
		CreatePanel_SPanelTitle.Paint = function(self, w, h)
			if self:IsHovered() then
				surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
				surface.DrawRect(0, 0, w, h)
			end
		end
		CreatePanel_SPanelTitle.OnMousePressed = function()
			if cedTable == cedGroupXmenuConfig.FoneMenu.Table_ServerTutorial then 
				SetClipboardText("https://" .. vInfo.punishment)
				caE_GenericNotify(cedGroupXmenuConfig.FoneMenu.CopyVideoLink, cedGroupXmenuConfig.FoneMenu.DfMainColor, cedGroupXmenuConfig.FoneMenu.plySecondColor)
			 
			else 
				SetClipboardText(vInfo.Name .. ": [" .. vInfo.description .. "]")
				caE_GenericNotify(cedGroupXmenuConfig.FoneMenu.CopyDescription, cedGroupXmenuConfig.FoneMenu.DfMainColor, cedGroupXmenuConfig.FoneMenu.plySecondColor)
			end 
		end

		local CreatePanel_SPanelDesc = vgui.Create("RichText", CreatePanel_SecondPanel)
		CreatePanel_SPanelDesc:SetSize(scrw * 0.19, scrh * 0.1)
		CreatePanel_SPanelDesc:SetPos(scrw * 0.002, scrh * 0.05)
		CreatePanel_SPanelDesc:InsertColorChange(255, 255, 255, 255)
		CreatePanel_SPanelDesc:AppendText("[Description] :" .. vInfo.description)
		CreatePanel_SPanelDesc.PerformLayout = function(self)
			self:SetFontInternal(cedF1Font27)
		end 

		local CreatePanel_SPanelInfo = vgui.Create("DLabel", CreatePanel_SecondPanel)
		CreatePanel_SPanelInfo:SetPos(scrw * 0.003, scrh * 0.175)
		CreatePanel_SPanelInfo:SetText("[" .. cedText2 .."]:" .. vInfo.punishment)
		CreatePanel_SPanelInfo:SetFont(cedF1Font27)
		CreatePanel_SPanelInfo:SetTextColor(cedGroupXmenuConfig.WhiteText)
		CreatePanel_SPanelInfo:SizeToContents()

		local CreatePanel_SPanelInfo2= vgui.Create("DLabel", CreatePanel_SecondPanel)
		CreatePanel_SPanelInfo2:SetPos(scrw * 0.097, scrh * 0.175)
		CreatePanel_SPanelInfo2:SetText(cedText3 .. vInfo.fine)
		CreatePanel_SPanelInfo2:SetFont(cedF1Font27)
		CreatePanel_SPanelInfo2:SetTextColor(cedGroupXmenuConfig.WhiteText)
		CreatePanel_SPanelInfo2:SizeToContents()
	end
end


-- Show The Main Menu
net.Receive("ced_fone_menu_unitrp.OpenShowHelp", function()
	local scrw, scrh  = ScrW(), ScrH()
	if not DarkRP then print("Vous n'avez pas le Darkrp sur votre serveur ! ") return end 

	if file.Exists(cedFolderDataName .. cedScriptName .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData) then 	
		local cedDataValue  = file.Read(cedFolderDataName .. cedScriptName .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData)
		
		cedDataValue        = util.JSONToTable(cedDataValue)
		cedGroupXmenuConfig.FoneMenu.plyMainColor = Color(cedDataValue["MainColor"].r, cedDataValue["MainColor"].g, cedDataValue["MainColor"].b, cedDataValue["MainColor"].a)
		cedGroupXmenuConfig.FoneMenu.plySecondColor = Color(cedDataValue["cedSecColor"].r, cedDataValue["cedSecColor"].g, cedDataValue["cedSecColor"].b, cedDataValue["cedSecColor"].a)
	else
		cedGroupXmenuConfig.FoneMenu.plyMainColor = cedGroupXmenuConfig.FoneMenu.DfMainColor
		cedGroupXmenuConfig.FoneMenu.plySecondColor = cedGroupXmenuConfig.FoneMenu.DfSecondColor
	end 

	OpenShowHelp_MainFrame = vgui.Create("DFrame")
	OpenShowHelp_MainFrame:SetSize(scrw * 0.2, scrh)
	OpenShowHelp_MainFrame:SetPos(0, 0)
	OpenShowHelp_MainFrame:SetTitle("")
	OpenShowHelp_MainFrame:MakePopup()
	OpenShowHelp_MainFrame:SetDraggable(false)
	OpenShowHelp_MainFrame:ShowCloseButton(false)
	OpenShowHelp_MainFrame.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plyMainColor)
		surface.DrawRect(0, 0, w, h)
	end

	local OpenShowHelp_CloseBtn = vgui.Create("DButton", OpenShowHelp_MainFrame)
	OpenShowHelp_CloseBtn:SetSize(scrw * 0.05, scrh * 0.025)
	OpenShowHelp_CloseBtn:SetPos(scrw * 0.15, 0)
	OpenShowHelp_CloseBtn:SetText("X")
	OpenShowHelp_CloseBtn:SetFont(cedF1Font24)
	OpenShowHelp_CloseBtn:SetTextColor(cedGroupXmenuConfig.WhiteText)
	OpenShowHelp_CloseBtn.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, cedGroupXmenuConfig.FoneMenu.plySecondColor)
	end
	OpenShowHelp_CloseBtn.DoClick = function()
		surface.PlaySound(cedSound)
		if IsValid(OpenShowHelp_MainFrame) then 
			OpenShowHelp_MainFrame:Remove()
		end 
	end 

	local OpenShowHelp_SettingsBtn = vgui.Create("DImageButton", OpenShowHelp_MainFrame)
	OpenShowHelp_SettingsBtn:SetSize(scrw * 0.020, scrh * 0.030)
	OpenShowHelp_SettingsBtn:SetPos(scrw * 0.005, scrh * 0.005)
	OpenShowHelp_SettingsBtn:SetImage(cedPicture1)
	OpenShowHelp_SettingsBtn:SetEnabled(true)
	OpenShowHelp_SettingsBtn.DoClick = function()
		if IsValid(OpenShowHelp_MainFrame) then 
			OpenShowHelp_SettingsBtn:SetEnabled(false)
			OpenShowHelp_CloseBtn:SetEnabled(false)
			caE_MenuOfSettings(OpenShowHelp_MainFrame, cedScriptName, cedF1Menu, 0.8)
		end 
	end

	local OpenShowHelp_PenalCodeBtn = vgui.Create("DButton", OpenShowHelp_MainFrame)
	OpenShowHelp_PenalCodeBtn:SetSize(scrw * 0.05, scrh * 0.05)
	OpenShowHelp_PenalCodeBtn:SetPos(scrw * 0.01, scrh * 0.038)
	OpenShowHelp_PenalCodeBtn:SetText(cedGroupXmenuConfig.FoneMenu.FirstBtn)
	OpenShowHelp_PenalCodeBtn:SetFont(cedF1Font24)
	OpenShowHelp_PenalCodeBtn:SetTextColor(cedGroupXmenuConfig.WhiteText)
	OpenShowHelp_PenalCodeBtn.Paint = function(self, w, h)
		if self:IsHovered() then 
			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
			surface.DrawRect(0, 0, w, h)
		else
			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plyMainColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
			surface.DrawOutlinedRect(0, 0, w, h)
		end 
	end 
	OpenShowHelp_PenalCodeBtn.DoClick = function()
		surface.PlaySound(cedSound) 
		if IsValid(CreatePanel_MainFrame) then 
			CreatePanel_MainFrame:Remove()
			timer.Simple(0.1, function()
				cfmU_CreatePanel(OpenShowHelp_MainFrame, cedGroupXmenuConfig.FoneMenu.Table_PenalCode, cedLawsText, cedPunishmentText, cedFineText)
			end)
		else
			cfmU_CreatePanel(OpenShowHelp_MainFrame, cedGroupXmenuConfig.FoneMenu.Table_PenalCode, cedLawsText, cedPunishmentText, cedFineText)
		end
	end 

	local OpenShowHelp_RulesBtn = vgui.Create("DButton", OpenShowHelp_MainFrame)
	OpenShowHelp_RulesBtn:SetSize(scrw * 0.05, scrh * 0.05)
	OpenShowHelp_RulesBtn:SetPos(scrw * 0.075, scrh * 0.038)
	OpenShowHelp_RulesBtn:SetText(cedGroupXmenuConfig.FoneMenu.SecondBtn)
	OpenShowHelp_RulesBtn:SetTextColor(cedGroupXmenuConfig.WhiteText)
	OpenShowHelp_RulesBtn:SetFont(cedF1Font24)
	OpenShowHelp_RulesBtn.Paint = function(self, w, h)
		if self:IsHovered() then 
			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
			surface.DrawRect(0, 0, w, h)
		else
			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plyMainColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end 
	OpenShowHelp_RulesBtn.DoClick = function()
		surface.PlaySound(cedSound) 
		if IsValid(CreatePanel_MainFrame) then 
			CreatePanel_MainFrame:Remove()
			timer.Simple(0.1, function()	
				cfmU_CreatePanel(OpenShowHelp_MainFrame, cedGroupXmenuConfig.FoneMenu.Table_ServerLaws, cedRulesText, cedSanctionText, "")
			end)
		else
			cfmU_CreatePanel(OpenShowHelp_MainFrame, cedGroupXmenuConfig.FoneMenu.Table_ServerLaws, cedRulesText, cedSanctionText, "")
		end 
	end 

	local OpenShowHelp_TutorialBtn = vgui.Create("DButton", OpenShowHelp_MainFrame)
	OpenShowHelp_TutorialBtn:SetSize(scrw * 0.05, scrh * 0.05)
	OpenShowHelp_TutorialBtn:SetPos(scrw * 0.14, scrh * 0.038)
	OpenShowHelp_TutorialBtn:SetText(cedGroupXmenuConfig.FoneMenu.ThirdBtn)
	OpenShowHelp_TutorialBtn:SetTextColor(cedGroupXmenuConfig.WhiteText)
	OpenShowHelp_TutorialBtn:SetFont(cedF1Font24)
	OpenShowHelp_TutorialBtn.Paint = function(self, w, h)
		if self:IsHovered() then 
			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
			surface.DrawRect(0, 0, w, h)
		else
			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plyMainColor)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(cedGroupXmenuConfig.FoneMenu.plySecondColor)
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end 
	OpenShowHelp_TutorialBtn.DoClick = function()
		surface.PlaySound(cedSound) 
		if IsValid(CreatePanel_MainFrame) then 
			CreatePanel_MainFrame:Remove()
			timer.Simple(0.1, function()	
				cfmU_CreatePanel(OpenShowHelp_MainFrame, cedGroupXmenuConfig.FoneMenu.Table_ServerTutorial, cedTutorialText, cedLinkText, "")
			end)
		else
			cfmU_CreatePanel(OpenShowHelp_MainFrame, cedGroupXmenuConfig.FoneMenu.Table_ServerTutorial, cedTutorialText, cedLinkText, "")
		end 
	end 
end)