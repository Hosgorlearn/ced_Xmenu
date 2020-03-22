if SERVER then 
	--------------------------------Config---------------------------------------
	include("ced_group_xmenu_files/ced_group_xmenu_config/ced_xmenu_general_config/sh_group_xmenu_config.lua")
	AddCSLuaFile("ced_group_xmenu_files/ced_group_xmenu_config/ced_xmenu_general_config/sh_group_xmenu_config.lua")
	-----------------------------------------------------------------------------

	-------------------------------- Extension ----------------------------------
	AddCSLuaFile("ced_group_xmenu_files/ced_group_xmenu_extension/ced_group_xmenu_extension_client/cl_xmenu_fonts_extension.lua")
	AddCSLuaFile("ced_group_xmenu_files/ced_group_xmenu_extension/ced_group_xmenu_extension_client/cl_xmenu_function_extension.lua")
	-----------------------------------------------------------------------------
	
	--------------------------------FONE MENU---------------------------------
	include("ced_group_xmenu_files/ced_group_xmenu_fonemenu/ced_group_xmenu_fonemenu_server/sv_fone_group_xmenu.lua") 
	AddCSLuaFile("ced_group_xmenu_files/ced_group_xmenu_fonemenu/ced_group_xmenu_fonemenu_server/sv_fone_group_xmenu.lua")
	AddCSLuaFile("ced_group_xmenu_files/ced_group_xmenu_fonemenu/ced_group_xmenu_fonemenu_client/cl_fone_group_xmenu.lua")
	--------------------------------------------------------------------------

	--------------------------------Context Menu------------------------------
	include("ced_group_xmenu_files/ced_group_xmenu_contextmenu/ced_group_xmenu_contextmenu_server/sv_context_group_xmenu.lua") 
	AddCSLuaFile("ced_group_xmenu_files/ced_group_xmenu_contextmenu/ced_group_xmenu_contextmenu_server/sv_context_group_xmenu.lua")
	AddCSLuaFile("ced_group_xmenu_files/ced_group_xmenu_contextmenu/ced_group_xmenu_contextmenu_client/cl_context_group_xmenu.lua")
	--------------------------------------------------------------------------

	--------------------------------Scoreboard-----------------------------------
	include("ced_group_xmenu_files/ced_group_xmenu_scoreboard/ced_group_xmenu_scoreboard_server/sv_scoreboard_group_xmenu.lua") 
	AddCSLuaFile("ced_group_xmenu_files/ced_group_xmenu_scoreboard/ced_group_xmenu_scoreboard_server/sv_scoreboard_group_xmenu.lua")
	AddCSLuaFile("ced_group_xmenu_files/ced_group_xmenu_scoreboard/ced_group_xmenu_scoreboard_client/cl_scoreboard_group_xmenu.lua")
	-----------------------------------------------------------------------------


end 

if CLIENT then 

	--------------------------------Config---------------------------------------
	include("ced_group_xmenu_files/ced_group_xmenu_config/ced_xmenu_general_config/sh_group_xmenu_config.lua")
	-----------------------------------------------------------------------------
	
	-------------------------------- Extension ----------------------------------
	include("ced_group_xmenu_files/ced_group_xmenu_extension/ced_group_xmenu_extension_client/cl_xmenu_fonts_extension.lua")
	include("ced_group_xmenu_files/ced_group_xmenu_extension/ced_group_xmenu_extension_client/cl_xmenu_function_extension.lua")
	-----------------------------------------------------------------------------

	--------------------------------FONE MENU---------------------------------	
	include("ced_group_xmenu_files/ced_group_xmenu_fonemenu/ced_group_xmenu_fonemenu_client/cl_fone_group_xmenu.lua")
	--------------------------------------------------------------------------

	--------------------------------Context Menu------------------------------
	include("ced_group_xmenu_files/ced_group_xmenu_contextmenu/ced_group_xmenu_contextmenu_client/cl_context_group_xmenu.lua")
	--------------------------------------------------------------------------

	--------------------------------Scoreboard-----------------------------------
	include("ced_group_xmenu_files/ced_group_xmenu_scoreboard/ced_group_xmenu_scoreboard_client/cl_scoreboard_group_xmenu.lua")
	-----------------------------------------------------------------------------

end 