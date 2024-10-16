/*--------------------------------------------------
	=============== VJ Base Plugins ===============
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

---------------------------------------------------------------------------------------------------------------------------------------------
local function VJ_PLUGINS(Panel)
	local numPlugins = #VJ.Plugins
	
	Panel:AddControl("Label", {Text = "#vjbase.menu.plugins.label"})
	Panel:ControlHelp(language.GetPhrase("#vjbase.menu.plugins.version").." "..VJBASE_VERSION) -- Main Number / Version / Patches
	Panel:ControlHelp(language.GetPhrase("#vjbase.menu.plugins.totalplugins").." "..numPlugins)
	
	local CheckList = vgui.Create("DListView")
	CheckList:SetTooltip(false)
	//CheckList:Center() -- No need since Size does it already
	CheckList:SetSize(100, 300) -- Size
	CheckList:SetMultiSelect(false)
	CheckList:AddColumn("#vjbase.menu.plugins.header1") -- Add column
	CheckList:AddColumn("#vjbase.menu.plugins.header2"):SetFixedWidth(50) -- Add column
	//Panel:SetName("Test") -- Renames the blue label
	if VJ.Plugins != nil then
		for _,v in SortedPairsByMemberValue(VJ.Plugins, "Name") do
			CheckList:AddLine(v.Name, v.Type)
		end
	else
		CheckList:AddLine("#vjbase.menu.plugins.notfound", "")
	end
	CheckList.OnRowSelected = function()
		surface.PlaySound(Sound("vj_misc/illuminati_confirmed.mp3"))
		chat.AddText(Color(255,255,0),"-=-=-=-=-=-=-=-=- ", Color(255,100,0), "VJ Base", Color(255,255,0)," -=-=-=-=-=-=-=-=-")
		chat.AddText(Color(0,255,0), language.GetPhrase("#vjbase.menu.plugins.version").." "..VJBASE_VERSION)
		chat.AddText(Color(0,255,0), language.GetPhrase("#vjbase.menu.plugins.totalplugins").." "..numPlugins)
	end
	Panel:AddItem(CheckList)
	
	-- Changelog for VJ Base
	local changelog = vgui.Create("DButton")
	changelog:SetFont("TargetID")
	changelog:SetText("#vjbase.menu.plugins.changelog")
	changelog:SetSize(150, 25)
	changelog:SetColor(Color(0, 102, 0))
	changelog:SetFont("VJFont_Trebuchet24_SmallMedium")
	changelog.DoClick = function(x)
		gui.OpenURL("https://github.com/DrVrej/VJ-Base/releases")
	end
	Panel:AddPanel(changelog)
	
	-- Github Wiki
	local github = vgui.Create("DButton")
	github:SetFont("TargetID")
	github:SetText("#vjbase.menu.plugins.makeaddon")
	github:SetSize(150, 25)
	github:SetColor(Color(0, 0, 102))
	github:SetFont("VJFont_Trebuchet24_SmallMedium")
	github.DoClick = function(x)
		gui.OpenURL("https://github.com/DrVrej/VJ-Base/wiki")
	end
	Panel:AddPanel(github)
	
	-- Tutorial Video
	local tutorialVid = vgui.Create("DButton")
	tutorialVid:SetFont("TargetID")
	tutorialVid:SetText("#tool.vjstool.menu.tutorialvideo")
	tutorialVid:SetSize(150, 25)
	tutorialVid:SetColor(Color(0, 0, 102))
	tutorialVid:SetFont("VJFont_Trebuchet24_SmallMedium")
	tutorialVid.DoClick = function(x)
		gui.OpenURL("https://www.youtube.com/watch?v=dGoqEpFZ5_M")
	end
	Panel:AddPanel(tutorialVid)
end
---------------------------------------------------------------------------------------------------------------------------------------------
hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_INSTALLATIONS", function()
	spawnmenu.AddToolMenuOption("DrVrej", "Main Menu", "Installed Plugins", "#vjbase.menu.plugins", "", "", VJ_PLUGINS)
end)
---------------------------------------------------------------------------------------------------------------------------------------------