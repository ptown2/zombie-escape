include('shared.lua')

--[[---------------------------------------
		HUD
-----------------------------------------]]
CVars.ZombieFOV = CreateClientConVar( "ze_zfov", 110, true, false )

-- Because vignettes make everything look nicer	
local VignetteMat = Material("ze/vignette")
function GM:HUDPaintBackground()
	surface.SetDrawColor(0,0,0,200)
	surface.SetMaterial(VignetteMat)
	-- surface.DrawTexturedRect(0,0,ScrW(),ScrH())
end

/*---------------------------------------------------------
	HUDShouldDraw
	Determine whether to draw parts of HUD
---------------------------------------------------------*/
GM.HideHUD = { "CHudCrosshair" }
GM.ShowHUD = { "CHudGMod", "CHudChat" }
function GM:HUDShouldDraw(name)

	-- Hide certain HUD elements
	if table.HasValue(self.HideHUD, name) then
		return false
	end

	-- Don't draw too much over the win overlays
	if WinningTeam != nil and !table.HasValue(self.ShowHUD,name) then
		return false
	end

	-- Sanity check
	if !LocalPlayer().IsZombie or !LocalPlayer().IsSpectator then
		return true
	end

	-- Hide parts of HUD for zombies and during weapon selection
	if ( !LocalPlayer():IsHuman() or self.bSelectingWeapons ) and name == "CHudWeaponSelection" then
		return false
	end
	
	return true

end

function GM:PlayerBindPress( ply, bind, pressed )

	if ( bind == "+menu" && pressed ) then
		LocalPlayer():ConCommand( "lastinv" )
		return true
	end
	
	return false

end