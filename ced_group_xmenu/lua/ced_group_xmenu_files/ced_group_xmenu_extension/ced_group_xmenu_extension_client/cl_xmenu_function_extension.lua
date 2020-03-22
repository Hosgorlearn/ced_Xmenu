-- PanelMenu Variables --
local MenuOfSettings_Checkbox1
local MenuOfSettings_Checkbox2
local GenericNotify_Panel
-------------------------

-- Table Variable --
local cedSaveDataTable = {}
--------------------

-- Data Variables ---
local cedFolderDataName   = "cedxmenu/"
local cedPlayerDataFolder = "ownplayercolor/"
local cedPlayerDataFile   = "filedata_savecolor"
local cedDataExtension    = ".txt"
local cedData             = "DATA"
---------------------

-- Sound Variable ---
local cedSound = "ced_group_xmenu_sounds/pop_up.wav"
---------------------

-- Color Variables --
local cedFirtsColor
local cedSecondColor
---------------------

-- Font Variable --
local cedExtFont24 = "ced_fonts_Xmenu:Font24"
local CedExtFont35 = "ced_fonts_Xmenu:Font35"
-------------------


-- Create Own Notify
function caE_GenericNotify(cedStatutText, cedMainColor, cedBackColor)
	local scrw, scrh = ScrW(), ScrH()

	if not IsColor(cedMainColor) then return end
	if not IsColor(cedBackColor) then return end 
	if not isstring(cedStatutText) then return end  

	if IsValid(GenericNotify_Panel) then 
		GenericNotify_Panel:Remove()
	end 

	GenericNotify_Panel = vgui.Create("DNotify")
	GenericNotify_Panel:SetSize(scrw * 0.25, scrh * 0.05)
	GenericNotify_Panel:SetPos(scrw * 0.7, 0)

	local GenericNotify_Background = vgui.Create("DPanel", GenericNotify_Panel)
	GenericNotify_Background:Dock(FILL)
	GenericNotify_Background.Paint = function(self, w, h)
		surface.SetDrawColor(cedMainColor)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(cedBackColor)
		surface.DrawRect(0, 0, w, 10)
	end 

	local GenericNotify_TextInfo = vgui.Create("DLabel", GenericNotify_Background)
	GenericNotify_TextInfo:SetSize(GenericNotify_Panel:GetWide(), GenericNotify_Panel:GetTall())
	GenericNotify_TextInfo:SetPos(0, scrh * 0.005)
	GenericNotify_TextInfo:SetText(cedStatutText)
	GenericNotify_TextInfo:SetFont(CedExtFont35)
	GenericNotify_TextInfo:SetTextColor(Color(255, 255, 255, 255))
	GenericNotify_TextInfo:SetContentAlignment(5)

	GenericNotify_Panel:AddItem(GenericNotify_Background)
end 


-- Save the Own PLayer Color
function caE_PlayerOwnColor(cedMainColor, cedSecColor, cedNameScript)

	if not isstring(cedNameScript) then return end 

	if cedMainColor == nil then 
		if file.Size(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData) == 0 then 
			cedMainColor = Color(255, 255, 255, 255)
		else
			cedSaveDataTable = util.JSONToTable(file.Read(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData))
			cedMainColor = cedSaveDataTable.MainColor
		end
	end 

	if cedSecColor == nil then 
		if file.Size(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData) == 0 then 
			cedSecColor = Color(41, 41, 41, 255)
		else
			cedSaveDataTable = util.JSONToTable(file.Read(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData))
			cedSecColor = cedSaveDataTable.cedSecColor
		end
	end 

	cedSaveDataTable.cedSecColor = cedSecColor
	cedSaveDataTable.MainColor = cedMainColor
	
	if file.Exists(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData) then 
		file.Write(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder.. cedPlayerDataFile .. cedDataExtension, util.TableToJSON(cedSaveDataTable))	
	end
end


-- Check Player Data
function caE_CheckOfData(cedNameScript)

	if not isstring(cedNameScript) then return end 

	if cedNameScript == "ced_context_menu/" then 
		cedFirtsColor = cedGroupXmenuConfig.ContextMenu.DfMainColor 
		cedSecondColor = cedGroupXmenuConfig.ContextMenu.DfSecondColor
	elseif cedNameScript == "ced_scoreboard_menu/" then 
		cedFirtsColor = cedGroupXmenuConfig.Scoreboard.DfMainColor
		cedSecondColor = cedGroupXmenuConfig.Scoreboard.DfSecondColor 
	else
		cedFirtsColor = cedGroupXmenuConfig.FoneMenu.DfMainColor
		cedSecondColor = cedGroupXmenuConfig.FoneMenu.DfSecondColor
	end 

	if not file.Exists(cedFolderDataName .. cedNameScript, cedData) then 
		file.CreateDir(cedFolderDataName .. cedNameScript)
	end

	if not file.Exists(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder, cedData) then 
		file.CreateDir(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder)
	end  

	if not file.Exists(cedFolderDataName .. cedNameScript ..cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData) then
		cedSaveDataTable["MainColor"]   = cedFirtsColor
		cedSaveDataTable["cedSecColor"] = cedSecondColor
		file.Write(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, util.TableToJSON(cedSaveDataTable))
	else
		local Ced_Read = util.JSONToTable(file.Read(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder .. cedPlayerDataFile .. ".txt", "DATA"))
		if not istable(Ced_Read) then 
			cedSaveDataTable["MainColor"]   = cedFirtsColor
			cedSaveDataTable["cedSecColor"] = cedSecondColor
			file.Write(cedFolderDataName .. cedNameScript .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, util.TableToJSON(cedSaveDataTable))
		end
	end 
end 


-- Open Settings Menu
function caE_MenuOfSettings(cedMainPanel, cedFolderColor, cedID, cedMov)

	local cedColorValue1
	local cedColorValue2

	local scrw, scrh = ScrW(), ScrH()

	if not IsValid(cedMainPanel) then return end 
	if not isstring(cedFolderColor) then return end 
	if not isnumber(cedID) then return end 
	if not isnumber(cedMov) then return end 

	if IsValid(cedMainPanel) then 
		cedMainPanel:MoveTo(scrw * cedMov, 0, 0.5,  0)
	end 

	if IsValid(MenuOfSettings_Frame) then 
		MenuOfSettings_Frame:Remove()
	end 

	MenuOfSettings_Frame = vgui.Create("DFrame")
	MenuOfSettings_Frame:SetSize(scrw * 0.35, scrh * 0.5)
	MenuOfSettings_Frame:SetPos(0, 0)
	MenuOfSettings_Frame:SetTitle("")
	MenuOfSettings_Frame:MakePopup()
	MenuOfSettings_Frame:ShowCloseButton(false)
	MenuOfSettings_Frame.Paint = function(self ,w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.BackgroundFrame)
		surface.DrawRect(0, 0, w, h)
	end 

	local MenuOfSettings_ClosButton = vgui.Create("DButton", MenuOfSettings_Frame)
    MenuOfSettings_ClosButton:SetSize(scrw * 0.07, scrh * 0.03)
    MenuOfSettings_ClosButton:SetPos(scrw * 0.28, scrh * 0.002)
    MenuOfSettings_ClosButton:SetText("X")
    MenuOfSettings_ClosButton:SetTextColor(cedGroupXmenuConfig.WhiteText)
    MenuOfSettings_ClosButton.DoClick = function(self, w, h)
        if IsValid(MenuOfSettings_Frame) then 
            MenuOfSettings_Frame:Remove()
        end 
        if IsValid(cedMainPanel) then 
        	cedMainPanel:Remove()
        end
    end 
    MenuOfSettings_ClosButton.Paint = function(self, w, h)
        draw.RoundedBox(5, 0, 0, w, h, cedGroupXmenuConfig.CloseButton)
    end 

    if file.Exists(cedFolderDataName .. cedFolderColor .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData) then 
    	
    	local MenuOfSettings_RestartBtn = vgui.Create("DButton", MenuOfSettings_Frame)
   		MenuOfSettings_RestartBtn:SetSize(scrw * 0.1, scrh * 0.03)
		MenuOfSettings_RestartBtn:SetPos(0, 0)
		MenuOfSettings_RestartBtn:SetText(cedGroupXmenuConfig.RestartButton )
		MenuOfSettings_RestartBtn:SetTextColor(cedGroupXmenuConfig.WhiteText)
		MenuOfSettings_RestartBtn:SetFont(cedExtFont24)
		MenuOfSettings_RestartBtn.Paint = function(self, w, h)
			surface.SetDrawColor(cedGroupXmenuConfig.SaveButtonCl)
			surface.DrawRect(0, 0, w, h)
		end 
		MenuOfSettings_RestartBtn.DoClick = function()
			print(cedFolderColor)
			if file.Exists(cedFolderDataName .. cedFolderColor .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension, cedData) then 
				file.Delete(cedFolderDataName .. cedFolderColor .. cedPlayerDataFolder .. cedPlayerDataFile .. cedDataExtension)
				surface.PlaySound(cedSound)
				if IsValid(MenuOfSettings_Frame) then 
		            MenuOfSettings_Frame:Remove()
		        end 
		        if IsValid(cedMainPanel) then 
		        	cedMainPanel:Remove()
		        end
			end 
		end
    end 

    local MenuOfSettings_Mixer = vgui.Create( "DColorMixer", MenuOfSettings_Frame)
	MenuOfSettings_Mixer:SetSize(scrw * 0.2, scrh *0.2)
	MenuOfSettings_Mixer:SetPos(scrw * 0.05, scrh * 0.05 )
	MenuOfSettings_Mixer:SetPalette(true)
	MenuOfSettings_Mixer:SetAlphaBar(true) 	
	MenuOfSettings_Mixer:SetWangs(true)			
	MenuOfSettings_Mixer:SetColor(Color(30, 100, 160))
	MenuOfSettings_Mixer.ValueChanged = function()
		if MenuOfSettings_Checkbox1:GetChecked() then 
			cedColorValue1 = MenuOfSettings_Mixer:GetColor()
			if cedID == 1 then
				cedGroupXmenuConfig.FoneMenu.plyMainColor = cedColorValue1
			elseif cedID == 2 then 
				cedGroupXmenuConfig.Scoreboard.plyMainColor = cedColorValue1
			else
				cedGroupXmenuConfig.ContextMenu.plyMainColor = cedColorValue1
			end 
		end 

		if MenuOfSettings_Checkbox2:GetChecked() then 
			cedColorValue2 = MenuOfSettings_Mixer:GetColor()
			if cedID == 1 then
				cedGroupXmenuConfig.FoneMenu.plySecondColor = cedColorValue2
			elseif cedID == 2 then 
				cedGroupXmenuConfig.Scoreboard.plySecondColor = cedColorValue2
			else
				cedGroupXmenuConfig.ContextMenu.plySecondColor = cedColorValue2
			end 
		end
	end 

	MenuOfSettings_Checkbox1 = vgui.Create("DCheckBox", MenuOfSettings_Frame)
	MenuOfSettings_Checkbox1:SetPos(scrw * 0.02, scrh * 0.29)
	MenuOfSettings_Checkbox1:SetValue(0)
	MenuOfSettings_Checkbox1.OnChange = function(self)
		if not IsValid(MenuOfSettings_Checkbox2) then return end 
		if self:GetChecked() then 
			MenuOfSettings_Checkbox2:Hide()
		else
			MenuOfSettings_Checkbox2:Show() 
		end 
	end 

	local MenuOfSettings_Checkbox1Text = vgui.Create("DLabel", MenuOfSettings_Frame)
	MenuOfSettings_Checkbox1Text:SetPos(scrw * 0.035, scrh * 0.287)
	MenuOfSettings_Checkbox1Text:SetText(cedGroupXmenuConfig.CheckBox1)
	MenuOfSettings_Checkbox1Text:SetFont(cedExtFont24)
	MenuOfSettings_Checkbox1Text:SetTextColor(cedGroupXmenuConfig.WhiteText)
	MenuOfSettings_Checkbox1Text:SizeToContents()

	MenuOfSettings_Checkbox2 = vgui.Create("DCheckBox", MenuOfSettings_Frame)
	MenuOfSettings_Checkbox2:SetPos(scrw * 0.02, scrh * 0.36 )
	MenuOfSettings_Checkbox2:SetValue( 0 )
	MenuOfSettings_Checkbox2.OnChange = function(self)
		if not IsValid(MenuOfSettings_Checkbox1) then return end 

		if self:GetChecked() then  
			MenuOfSettings_Checkbox1:Hide() 
		else
			MenuOfSettings_Checkbox1:Show()
		end 
	end 

	local MenuOfSettings_Checkbox2Text = vgui.Create("DLabel", MenuOfSettings_Frame)
	MenuOfSettings_Checkbox2Text:SetPos(scrw * 0.035, scrh * 0.356)
	MenuOfSettings_Checkbox2Text:SetText(cedGroupXmenuConfig.CheckBox2)
	MenuOfSettings_Checkbox2Text:SetFont(cedExtFont24)
	MenuOfSettings_Checkbox2Text:SetTextColor(cedGroupXmenuConfig.WhiteText)
	MenuOfSettings_Checkbox2Text:SizeToContents()

	local MenuOfSettings_SaveBtn = vgui.Create("DButton", MenuOfSettings_Frame)
	MenuOfSettings_SaveBtn:SetSize(scrw * 0.2, scrh * 0.05)
	MenuOfSettings_SaveBtn:SetPos(scrw * 0.06, scrh * 0.44)
	MenuOfSettings_SaveBtn:SetText(cedGroupXmenuConfig.SaveButton)
	MenuOfSettings_SaveBtn:SetTextColor(cedGroupXmenuConfig.WhiteText)
	MenuOfSettings_SaveBtn:SetFont(cedExtFont24)
	MenuOfSettings_SaveBtn.Paint = function(self, w, h)
		surface.SetDrawColor(cedGroupXmenuConfig.SaveButtonCl)
		surface.DrawRect(0, 0, w, h)
	end 
	MenuOfSettings_SaveBtn.DoClick = function()

		if MenuOfSettings_Checkbox1:GetChecked() then 
			cedColorValue = MenuOfSettings_Mixer:GetColor()
            caE_PlayerOwnColor(cedColorValue, _, cedFolderColor)
			surface.PlaySound(cedSound) 
		end 

		if MenuOfSettings_Checkbox2:GetChecked() then 
			Ced_Main = MenuOfSettings_Mixer:GetColor()
             caE_PlayerOwnColor(_, Ced_Main, cedFolderColor)
			surface.PlaySound(cedSound) 
		end 
	end
	caE_CheckOfData(cedFolderColor)
end 