cedGroupXmenuConfig = cedGroupXmenuConfig or {}

cedGroupXmenuConfig.Scoreboard  = {}
cedGroupXmenuConfig.FoneMenu    = {}
cedGroupXmenuConfig.ContextMenu = {}

--[[-------------------------------------------------------------------------
						General Settings
 ---------------------------------------------------------------------------]] 
				-- [[ All Sentences configuration ]] --
-- Settings Option Menu
cedGroupXmenuConfig.CheckBox1  = "Cochez pour définir la couleur principal de votre menu"
cedGroupXmenuConfig.CheckBox2  = "Cochez pour définir la couleur secondaire de votre menu"
cedGroupXmenuConfig.SaveButton = "Sauvegarder"
cedGroupXmenuConfig.RestartButton = "Remettre à zéro"

 				-- [[ General Colors ]] --
cedGroupXmenuConfig.WhiteText = Color(255, 255, 255, 255)

-- Settings Menu
cedGroupXmenuConfig.BackgroundFrame = Color(0, 47, 85, 255)
cedGroupXmenuConfig.CloseButton     = Color(74, 108, 136, 255)
cedGroupXmenuConfig.SaveButtonCl    = Color(74, 108, 136, 255)

				-- [[ General configuration ]] --	
-- Restart you'r server		
cedGroupXmenuConfig.EnabledF1Menu      = true
cedGroupXmenuConfig.EnabledContextMenu = true
cedGroupXmenuConfig.EnabledScoreboard  = true


-- Acces to Admin Menu, Show Player info 
cedGroupXmenuConfig.WlUserGroup = {
	["superadmin"] = true
}

cedGroupXmenuConfig.ContextMenu.BlackListWeapons = {
	["keys_ced_weapons"]     = true,
	["arrest_stick"]         = true,
	["door_ram"]             = true,
	["gmod_camera"]          = true,
	["gmod_tool"]            = true,
	["keys"]                 = true,
	["lockpick"]             = true,
	["med_kit"]              = true,
	["pocket"]               = true,
	["stunstick"]            = true,
	["unarrest_stick"]       = true,
	["weapon_keypadchecker"] = true,
	["weapon_physcannon"]    = true,
	["weapon_physgun"]       = false,
	["weaponchecker"]        = true
}


--[[-------------------------------------------------------------------------
						Scoreboard Configuration
---------------------------------------------------------------------------]]	
				-- [[ All Sentences configuration ]] --
cedGroupXmenuConfig.Scoreboard.ServerName   = "Test Serveur"
cedGroupXmenuConfig.Scoreboard.InfoPlayer   = "Informations sur le joueur"
cedGroupXmenuConfig.Scoreboard.OnlinePlayer = "Joueurs connectés : "
cedGroupXmenuConfig.Scoreboard.SteamProfil  = "Cliquez pour afficher le Profil"
cedGroupXmenuConfig.Scoreboard.SearchPlayer = "Appuyez pour effectuer votre recherche !"
				
				-- [[ All Colors configuration ]] --
cedGroupXmenuConfig.Scoreboard.DfMainColor   =  Color(0, 47, 85, 255)
cedGroupXmenuConfig.Scoreboard.DfSecondColor = Color(74, 108, 136, 255)

				-- [[ All Value configuration ]] --
cedGroupXmenuConfig.Scoreboard.EnabledFadminSound = true

-- Hide the player in the Scoreboard and in the Context Menu
cedGroupXmenuConfig.Scoreboard.WlSteamID = {
	["STEAM_0:0:171741668"] = false
}



--[[-------------------------------------------------------------------------
						Context Menu Configuration
---------------------------------------------------------------------------
				
				-- [[ All Sentences configuration ]] --
cedGroupXmenuConfig.ContextMenu.Title            = "Votre Serveur"

-- Send Option Menu
cedGroupXmenuConfig.ContextMenu.LinkDiscord     = " Lien discord : https://discord.gg/AtXXJYt"
cedGroupXmenuConfig.ContextMenu.LinkCollection  = " Lien Forum : https://www.google.fr/"
cedGroupXmenuConfig.ContextMenu.LinkServerStore = " Lien Boutique : https://www.google.fr/"
cedGroupXmenuConfig.ContextMenu.SendTo          = "Envoyer à"
cedGroupXmenuConfig.ContextMenu.SendLinks       = "Envoyer les liens"
cedGroupXmenuConfig.ContextMenu.SendingAccepted = "Ton message a bien été envoyé à "
cedGroupXmenuConfig.ContextMenu.SendingCanceled = "Inutile de te l'envoyer à toi même, tu peux simplement le copier"
cedGroupXmenuConfig.ContextMenu.SendMessageTime = "Bloqué pendant :"

-- Admin Option Menu
cedGroupXmenuConfig.ContextMenu.JoinAdminMode    = "Vous êtes maintenant en staff."
cedGroupXmenuConfig.ContextMenu.LeaveAdminMode   = "Vous n'êtes plus en staff."
cedGroupXmenuConfig.ContextMenu.PlayerNoclipping = "Vous ne pouvez pas noclip si vous n'êtes pas en mode Admin."
cedGroupXmenuConfig.ContextMenu.NoOwner          = "Aucun propriétaire"

-- DropWeapon Option Menu
cedGroupXmenuConfig.ContextMenu.DropWeapons   = "Vous avez jeté votre arme"
cedGroupXmenuConfig.ContextMenu.NoDropWeapons = "Vous ne pouvez pas jeter cette arme"

-- DropMoney Option Menu
cedGroupXmenuConfig.ContextMenu.DropMoneyTitle   = "Porte Monnaie Votre Serveur"
cedGroupXmenuConfig.ContextMenu.DropMoneyTofloor = " Vous avez jeté: "
cedGroupXmenuConfig.ContextMenu.DropMoney        = "Jetez l'argent"
cedGroupXmenuConfig.ContextMenu.DfDropMoney      = "Ecrivez le montant d'argent à jeter."
			
-- Stopsound Option Menu
cedGroupXmenuConfig.ContextMenu.StopSounds = "Vous avez effectué un StopSound"
	
-- Cancel Option button
cedGroupXmenuConfig.ContextMenu.CancelBtn = "Annuler"

				-- [[ All Colors configuration ]] --
cedGroupXmenuConfig.ContextMenu.DfMainColor   = Color(0, 47, 85, 255)
cedGroupXmenuConfig.ContextMenu.DfSecondColor = Color(74, 108, 136, 255)

				-- [[ All Value configuration ]] --
-- If player is not in Staff Mode then he can't noclip
cedGroupXmenuConfig.ContextMenu.NoClip = true

-- Time in second
cedGroupXmenuConfig.ContextMenu.TimeToSendMessage = 30


--[[-------------------------------------------------------------------------
						Fone Menu Configuration
---------------------------------------------------------------------------]]	
	
				-- [[ All Sentences configuration ]] --
cedGroupXmenuConfig.FoneMenu.FirstBtn        = "Code Pénal"

cedGroupXmenuConfig.FoneMenu.SecondBtn       = "Les règles"

cedGroupXmenuConfig.FoneMenu.ThirdBtn        = "Les tutoriels"

cedGroupXmenuConfig.FoneMenu.CopyVideoLink   = "Vous avez bien copié le lien de la vidéo"

cedGroupXmenuConfig.FoneMenu.CopyDescription = "Vous avez bien copié la description"

				-- [[ All Colors configuration ]] --

cedGroupXmenuConfig.FoneMenu.DfMainColor   = Color(0, 47, 85, 255)
cedGroupXmenuConfig.FoneMenu.DfSecondColor = Color(74, 108, 136, 255) 

				-- [[ All Value configuration ]] --

--[- Penal Code Table -]-- 
cedGroupXmenuConfig.FoneMenu.indexPC  = 0
cedGroupXmenuConfig.FoneMenu.Table_PenalCode = {}

cedGroupXmenuConfig.FoneMenu.indexPC = cedGroupXmenuConfig.FoneMenu.indexPC + 1
cedGroupXmenuConfig.FoneMenu.Table_PenalCode[cedGroupXmenuConfig.FoneMenu.indexPC] = {Name = " Vole à l'arraché", description = " C'est le fait de faire de ma", punishment = " 6 mois", fine = " 150€"}

cedGroupXmenuConfig.FoneMenu.indexPC = cedGroupXmenuConfig.FoneMenu.indexPC + 1
cedGroupXmenuConfig.FoneMenu.Table_PenalCode[cedGroupXmenuConfig.FoneMenu.indexPC] = {Name = " Menace de mort", description = " L'individu a profané de graves menaces à l'égard d'une personne je suis la personne qui veut de ta nourriture je sai spas mais comment veux tu faire le magasin de scure je ne sais pas je suis perdu dans mes pensées c'est étrange ", punishment = " 6 mois", fine = " 150€"}

cedGroupXmenuConfig.FoneMenu.indexPC = cedGroupXmenuConfig.FoneMenu.indexPC + 1
cedGroupXmenuConfig.FoneMenu.Table_PenalCode[cedGroupXmenuConfig.FoneMenu.indexPC] = {Name = " Excès de vitesse", description = " C'est le fait de faire de ma", punishment = "Aucune", fine = "  600€"}

cedGroupXmenuConfig.FoneMenu.indexPC = cedGroupXmenuConfig.FoneMenu.indexPC + 1
cedGroupXmenuConfig.FoneMenu.Table_PenalCode[cedGroupXmenuConfig.FoneMenu.indexPC] = {Name = " Vole à l'arraché", description = " C'est le fait de faire de ma", punishment = " 6 mois", fine = " 150€"}

cedGroupXmenuConfig.FoneMenu.indexPC = cedGroupXmenuConfig.FoneMenu.indexPC + 1
cedGroupXmenuConfig.FoneMenu.Table_PenalCode[cedGroupXmenuConfig.FoneMenu.indexPC] = {Name = " Vole à l'arraché", description = " C'est le fait de faire de ma", punishment = " 6 mois", fine = " 150€"}

cedGroupXmenuConfig.FoneMenu.indexPC = cedGroupXmenuConfig.FoneMenu.indexPC + 1
cedGroupXmenuConfig.FoneMenu.Table_PenalCode[cedGroupXmenuConfig.FoneMenu.indexPC] = {Name = " Vole à l'arraché", description = " C'est le fait de faire de ma", punishment = " 6 mois", fine = " 150€"}

--[- Rules Table -]--
cedGroupXmenuConfig.FoneMenu.indexSL  = 0
cedGroupXmenuConfig.FoneMenu.Table_ServerLaws = {}

cedGroupXmenuConfig.FoneMenu.indexSL = cedGroupXmenuConfig.FoneMenu.indexSL + 1
cedGroupXmenuConfig.FoneMenu.Table_ServerLaws[cedGroupXmenuConfig.FoneMenu.indexSL] = {Name = "Hrp Vocal", description = " Evoquer des choses qui sont hors contexte de votre action et même du jeu", punishment = "1 mois", fine = ""}


--[- Tutorial Table -]--
cedGroupXmenuConfig.FoneMenu.indexST  = 0
cedGroupXmenuConfig.FoneMenu.Table_ServerTutorial = {}

cedGroupXmenuConfig.FoneMenu.indexST = cedGroupXmenuConfig.FoneMenu.indexST + 1
cedGroupXmenuConfig.FoneMenu.Table_ServerTutorial[cedGroupXmenuConfig.FoneMenu.indexST] = {Name = "Bien débuter", description = "A travers cette vidéo, on vous explique comment commencer dans cette nouvelle ville", punishment = "www.youtube.com/watch?v=j2QXZD5tk8c", fine = ""}
