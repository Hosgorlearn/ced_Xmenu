util.AddNetworkString("ced_context_menu.SetAdminPlayer")
util.AddNetworkString("ced_context_menu.SendInfoToPlayer")

-- Boolean Variable --
local cedAdminBoolean
----------------------

-- String Variable --
local cedNWID = "CheckStatutOfPlayer"
---------------------


-- Send Server Info (Collection, Discord)
net.Receive("ced_context_menu.SendInfoToPlayer", function(len, cedPly)
	if not IsValid(cedPly) then return end 

	local Read_Player = net.ReadEntity()
	if not IsValid(Read_Player) then return end 
	
	Read_Player:ChatPrint(cedGroupXmenuConfig.ContextMenu.LinkDiscord .. "\n" .. cedGroupXmenuConfig.ContextMenu.LinkCollection .. "\n" .. cedGroupXmenuConfig.ContextMenu.LinkServerStore)
end)


-- Set Player Admin Mode
net.Receive("ced_context_menu.SetAdminPlayer", function(len, cedPly)
	local cedBool = net.ReadBool()

	if not IsValid(cedPly) then return end 
	if not cedGroupXmenuConfig.WlUserGroup[cedPly:GetUserGroup()] then return end

	if cedBool == true then 
		cedAdminBoolean = true
		cedPly:SetMoveType(MOVETYPE_NOCLIP)
		cedPly:GodEnable()
		cedPly:SetRenderMode(RENDERMODE_NONE)
	else
		cedAdminBoolean = false
		cedPly:SetMoveType(MOVETYPE_WALK)
		cedPly:GodDisable()
		cedPly:SetRenderMode(RENDERMODE_NORMAL)
	end
end)


-- Reset Player Value
hook.Add("PlayerSpawn", "ced_context_menu:LeaveStepValue", function(cedPly)
	if not IsValid(cedPly) then return end 
	cedAdminBoolean = false
end)


-- Cancel noclip
if cedGroupXmenuConfig.ContextMenu.NoClip == true then
	hook.Add("PlayerNoClip", "ced_context_menu:DisableNoclip", function(cedPly)
		if not IsValid(cedPly) then return end 
		if not DarkRP then print("Vous n'avez pas le Darkrp sur votre serveur ! ") return end 

		if cedAdminBoolean == false then 
			DarkRP.notify(cedPly, 1, 5, cedGroupXmenuConfig.ContextMenu.PlayerNoclipping)
		end 
		return cedAdminBoolean == true
	end)
end 

