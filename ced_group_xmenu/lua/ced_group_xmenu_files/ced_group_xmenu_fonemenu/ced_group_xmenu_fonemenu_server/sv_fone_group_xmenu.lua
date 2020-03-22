util.AddNetworkString("ced_fone_menu_unitrp.OpenShowHelp")

if cedGroupXmenuConfig.EnabledF1Menu == true then 

	local function cfmU_Openf1Menu(cedPly)
		net.Start("ced_fone_menu_unitrp.OpenShowHelp")
		net.Send(cedPly)
	end 
	hook.Add("ShowHelp", "ced_f1menu_unitrp:OpenShowHelp", cfmU_Openf1Menu) 
else
	return 
end 