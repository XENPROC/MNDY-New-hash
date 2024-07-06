Yourself = PLAYER.PLAYER_ID();
Yourselfpedid = PLAYER.PLAYER_PED_ID()
YourselfPED = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID());
TargetID = network.get_selected_player()
RPDropTime = 400;
MoneyDropTime = 800;
SCEWait = 800;
MNYDQuckCashTime = 800;
TransferBank2 = false
TransferBank = 0
Statamount = 0
Statamountfloat = 0.0
Selectedbool = 0
Transaction_names = {"Bank","Wallet"}
triggermode_names = {"Realistic","Unreal"}
selected_Triggermode = 0
selected_TransactionMethod = 0
selected_Computer = 0
isWaterMarkChanged = false
Watermark = false
Watermark_Featnames = {"MNYD","NewWayMenu.vip","NewWay"}
Watermark_FeatnamesAmmount = 3
Watermark_Features = 0
ShowAtAllTimes = false
LuaName = "MNDY"
gui.show_message("NewWay", LuaName.." Loaded")
PlayersTab = gui.get_tab("GUI_TAB_PLAYER")
StatisticsMNDY = gui.get_tab("MNDY Stats Editor")
recoveryTab2 = gui.get_tab("MNDY Recovery")
NightClubMNDY = gui.get_tab("MNDY NightClub")
MenuImGui = gui.get_tab("MNDY Misc")
AllPlayers = gui.get_tab("MNDY All Players")

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 --==MNDY==--
 function GetPlayerCount()
    return PLAYER.GET_NUMBER_OF_PLAYERS();
end

function GlobalInt(address, value)
	globals.set_int(address, value);
end

function CreateWorldObject(hash, xcoord, ycoord, zcoord)
    OBJECT.CREATE_OBJECT(hash, xcoord, ycoord, zcoord, true, false, false)
    OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(hash, 1, false)
end

function ForceControl(entity)
    return entities.take_control_of(entity)
end

function DrawText(I, x, y, scale1, scale2)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_PROPORTIONAL(1)
    HUD.SET_TEXT_SCALE(scale1, scale2)
    HUD.SET_TEXT_DROPSHADOW(1, 0, 0, 0, 255)
    HUD.SET_TEXT_EDGE(1, 0, 0, 0, 255)
    HUD.SET_TEXT_DROP_SHADOW()
    HUD.SET_TEXT_OUTLINE()
    HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT('STRING')
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(I)
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y)
end

function DeleteVehicle(Vehicle)
    if ENTITY.DOES_ENTITY_EXIST(Vehicle) then
        ENTITY.DETACH_ENTITY(Vehicle, true, true)
        ENTITY.SET_ENTITY_VISIBLE(Vehicle, false, false)
        NETWORK.NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS(Vehicle, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Vehicle, 0.0, 0.0, -1000.0, false, false, false)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Vehicle, true, true)
        VEHICLE.DELETE_VEHICLE(Vehicle)
    end
end

function DeleteEntity(Entity)
    if ENTITY.DOES_ENTITY_EXIST(Entity) then
        ENTITY.DETACH_ENTITY(Entity, true, true)
        ENTITY.SET_ENTITY_VISIBLE(Entity, false, false)
        NETWORK.NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS(Entity, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Entity, 0.0, 0.0, -1000.0, false, false, false)
        ENTITY.SET_ENTITY_COLLISION(Entity, false, false)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Entity, true, true)
        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(Entity)
        ENTITY.DELETE_ENTITY(Entity)
    end
end

function ScriptHostName()
	return PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_HOST_OF_SCRIPT("freemode", -1, 0))
end

function iconNotification(icon, icon, flash, icon2, text1, text)
	HUD.BEGIN_TEXT_COMMAND_THEFEED_POST(" ");
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(icon, icon, false, icon2, text1, text);
end



local textureDictTextures = {
    mpweaponscommon = {
        "w_ex_grenadesmoke", 
        "w_ex_pe", 
        "w_lr_rpg", 
        "w_pi_combatpistol", 
        "w_pi_combatpistol_flash", 
        "w_pi_combatpistol_mag1", 
        "w_pi_combatpistol_mag2", 
        "w_pi_combatpistol_supp", 
        "w_r_grenadelauncher", 
        "w_r_grenadelauncher_grip", 
        "w_r_grenadelauncher_laser", 
        "w_r_grenadelauncher_scope",  
        "w_sb_microsmg", 
        "w_sb_microsmg_flash", 
        "w_sb_microsmg_mag1", 
        "w_sb_microsmg_mag2", 
        "w_sb_microsmg_scope", 
        "w_sb_microsmg_supp", 
        "w_sg_assaultshotgun", 
        "w_sg_assaultshotgun_flsh", 
        "w_sg_assaultshotgun_grip", 
        "w_sg_assaultshotgun_mag1", 
        "w_sg_assaultshotgun_mag2", 
        "w_sg_assaultshotgun_supp", 
        "w_sg_pumpshotgun", 
        "w_sg_pumpshotgun_flash", 
        "w_sg_pumpshotgun_supp", 
    },
    
    mpweaponscommon_small = {
        "rocket", 
        "w_ex_grenadesmoke", 
        "w_ex_pe", 
        "w_lr_rpg", 
        "w_pi_combatpistol", 
        "w_r_grenadelauncher", 
        "w_sb_assaultsmg", 
        "w_sb_microsmg", 
        "w_sg_assaultshotgun", 
        "w_sg_pumpshotgun"
    },
    
    mpweaponsgang0 = {
        "w_ar_advancedrifle", 
        "w_ar_advancedrifle_flash", 
        "w_ar_advancedrifle_mag1", 
        "w_ar_advancedrifle_mag2", 
        "w_ar_advancedrifle_scopemedium", 
        "w_ar_advancedrifle_supp", 
        "w_ar_carbinerifle", 
        "w_ar_carbinerifle_flash", 
        "w_ar_carbinerifle_grip", 
        "w_ar_carbinerifle_mag1", 
        "w_ar_carbinerifle_mag2", 
        "w_ar_carbinerifle_railcover", 
        "w_ar_carbinerifle_scope", 
        "w_ar_carbinerifle_supp", 
        "w_ex_grenadefrag", 
        "w_mg_combatmg", 
        "w_mg_combatmg_grip", 
        "w_mg_combatmg_mag1", 
        "w_mg_combatmg_mag2", 
        "w_mg_combatmg_scope", 
        "w_pi_stungun", 
        "w_sb_smg", 
        "w_sb_smg_flash", 
        "w_sb_smg_mag1", 
        "w_sb_smg_mag2", 
        "w_sb_smg_scope", 
        "w_sb_smg_supp", 
        "w_sr_heavysniper", 
        "w_sr_heavysniper_scope", 
        "w_sr_heavysniper_scope_small", 
        "w_sr_sniperrifle", 
        "w_sr_sniperrifle_scope", 
        "w_sr_sniperrifle_scope_large", 
        "w_sr_sniperrifle_supp", 
    },
    
    mpweaponsgang0_small = {
        "w_ar_advancedrifle", 
        "w_ar_carbinerifle", 
        "w_ex_grenadefrag", 
        "w_mg_combatmg", 
        "w_pi_stungun", 
        "w_sb_rubber", 
        "w_sb_mg", 
        "w_sr_heavysniper", 
        "w_sr_sniperrifle"
    },

    mpweaponsgang1 = {
        "w_ar_assaultrifle",
        "w_ar_assaultrifle_flash",
        "w_ar_assaultrifle_grip",
        "w_ar_assaultrifle_mag1",
        "w_ar_assaultrifle_mag2",
        "w_ar_assaultrifle_scope",
        "w_ar_assaultrifle_supp",
        "w_mg_mg",
        "w_mg_mg_mag1",
        "w_mg_mg_mag2",
        "w_mg_mg_scope",
        "w_mg_minigun",
        "w_pi_apppistol",
        "w_pi_apppistol_flsh",
        "w_pi_apppistol_mag1",
        "w_pi_apppistol_mag2",
        "w_pi_apppistol_supp",
        "w_pi_pistol",
        "w_pi_pistol_flash",
        "w_pi_pistol_mag1",
        "w_pi_pistol_mag2",
        "w_pi_pistol_supp",
        "w_sg_sawnoff",
    },
    
    mpweaponsgang1_small = {
        "w_ar_assaultrifle",
        "w_mgassaultmg",
        "w_mg_mg",
        "w_mg_minigun",
        "w_pi_apppistol",
        "w_pi_pistol",
        "w_sg_sawnoff"
    },
    
    mpweaponsunusedfornow = {
        "w_am_digiscanner",
        "w_am_fire_exting",
        "w_am_jerrycan",
        "w_am_loudhailer",
        "w_am_parachute",
        "w_ex_molotov",
        "w_meleelasso_01",
        "w_me_bat",
        "w_me_crowbar",
        "w_me_fireaxe",
        "w_me_fist",
        "w_me_gclub",
        "w_me_hammer",
        "w_me_knife_01",
        "w_me_nightstick",
        "w_me_shovel",
        "w_me_wrench",
    },
}

Weaponss = {
    ["WEAPON_PISTOL"] = {TextureDict = "mpweaponsgang1_small", TextureName = "w_pi_pistol", Width = 0.20, Height = 0.20},
    ["weapon_pistol_mk2"] = {TextureDict = "mpweaponsgang1_small", TextureName = "w_pi_pistol", Width = 0.20, Height = 0.20},
    ["weapon_combatpistol"] = {TextureDict = "mpweaponscommon_small", TextureName = "w_pi_combatpistol", Width = 0.20, Height = 0.17 },
    ["WEAPON_APPISTOL"] = {TextureDict = "mpweaponsgang1_small", TextureName = "w_pi_apppistol",Width = 0.20, Height = 0.17},
    ["WEAPON_STUNGUN"] = {TextureDict = "mpweaponsgang0", TextureName = "w_pi_stungun", Width = 0.10, Height = 0.10},
    ["weapon_stungun_mp"] = {TextureDict = "mpweaponsgang0", TextureName = "w_pi_stungun", Width = 0.10, Height = 0.10},
    ["WEAPON_ADVANCEDRIFLE"] = {TextureDict = "mpweaponsgang0", TextureName = "w_ar_advancedrifle", Width = 0.150, Height = 0.150},
    ["WEAPON_CARBINERIFLE"] = {TextureDict = "mpweaponsgang0", TextureName = "w_ar_carbinerifle", Width = 0.150, Height = 0.150},
    ["WEAPON_CARBINERIFLE_MK2"] = {TextureDict = "mpweaponsgang0", TextureName = "w_ar_carbinerifle", Width = 0.150, Height = 0.150},
    ["WEAPON_COMBATMG"] = {TextureDict = "mpweaponsgang0", TextureName = "w_mg_combatmg", Width = 0.150, Height = 0.150},
    ["weapon_combatmg_mk2"] = {TextureDict = "mpweaponsgang0", TextureName = "w_mg_combatmg", Width = 0.150, Height = 0.150},
    ["WEAPON_SMG"] = {TextureDict = "mpweaponsgang0", TextureName = "w_sb_smg", Width = 0.150, Height = 0.150},
    ["weapon_smg_mk2"] = {TextureDict = "mpweaponsgang0", TextureName = "w_sb_smg", Width = 0.150, Height = 0.150},
    ["WEAPON_HEAVYSNIPER"] = {TextureDict = "mpweaponsgang0", TextureName = "w_sr_heavysniper", Width = 0.150, Height = 0.150},
    ["WEAPON_HEAVYSNIPER_MK2"] = {TextureDict = "mpweaponsgang0", TextureName = "w_sr_heavysniper", Width = 0.150, Height = 0.150},
    ["WEAPON_SNIPERRIFLE"] = {TextureDict = "mpweaponsgang0", TextureName = "w_sr_sniperrifle", Width = 0.150, Height = 0.150},
    ["WEAPON_GRENADELAUNCHER"] = {TextureDict = "mpweaponscommon", TextureName = "w_r_grenadelauncher", Width = 0.150, Height = 0.150},
    ["WEAPON_RPG"] = {TextureDict = "mpweaponscommon", TextureName = "w_lr_rpg", Width = 0.150, Height = 0.150},
    ["WEAPON_MICROSMG"] = {TextureDict = "mpweaponscommon", TextureName = "w_sb_microsmg", Width = 0.150, Height = 0.150},
    ["WEAPON_ASSAULTSHOTGUN"] = {TextureDict = "mpweaponscommon", TextureName = "w_sg_assaultshotgun", Width = 0.150, Height = 0.150},
    ["WEAPON_PUMPSHOTGUN"] = {TextureDict = "mpweaponscommon", TextureName = "w_sg_pumpshotgun", Width = 0.150, Height = 0.150},
    ["WEAPON_PUMPSHOTGUN_MK2"] = {TextureDict = "mpweaponscommon", TextureName = "w_sg_pumpshotgun", Width = 0.150, Height = 0.150},
    ["weapon_combatshotgun"] = {TextureDict = "mpweaponscommon", TextureName = "w_sg_pumpshotgun", Width = 0.150, Height = 0.150},
    ["WEAPON_ASSAULTRIFLE"] = {TextureDict = "mpweaponsgang1", TextureName = "w_ar_assaultrifle", Width = 0.150, Height = 0.150},
    ["WEAPON_ASSAULTRIFLE_MK2"] = {TextureDict = "mpweaponsgang1", TextureName = "w_ar_assaultrifle", Width = 0.150, Height = 0.150},
    ["WEAPON_MG"] = {TextureDict = "mpweaponsgang1", TextureName = "w_mg_mg", Width = 0.150, Height = 0.150},
    ["WEAPON_MINIGUN"] = {TextureDict = "mpweaponsgang1", TextureName = "w_mg_minigun", Width = 0.150, Height = 0.150},
    ["WEAPON_BAT"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_me_bat", Width = 0.150, Height = 0.150},
    ["WEAPON_CROWBAR"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_me_crowbar", Width = 0.150, Height = 0.150},
    ["WEAPON_UNARMED"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_me_fist", Width = 0.150, Height = 0.150},
    ["WEAPON_GOLFCLUB"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_me_gclub", Width = 0.150, Height = 0.150},
    ["WEAPON_HAMMER"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_me_hammer", Width = 0.150, Height = 0.150},
    ["WEAPON_KNIFE"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_me_knife_01", Width = 0.150, Height = 0.150},
    ["WEAPON_NIGHTSTICK"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_me_nightstick", Width = 0.150, Height = 0.150},
    ["weapon_wrench"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_me_wrench", Width = 0.150, Height = 0.150},
    ["WEAPON_FIREEXTINGUISHER"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_am_fire_exting", Width = 0.150, Height = 0.150},
    ["WEAPON_PETROLCAN"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_am_jerrycan", Width = 0.150, Height = 0.150},
    ["weapon_hazardcan"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_am_jerrycan", Width = 0.150, Height = 0.150},
    ["WEAPON_MOLOTOV"] = {TextureDict = "mpweaponsunusedfornow", TextureName = "w_ex_molotov", Width = 0.150, Height = 0.150},

}



WeaponHashes = {
    [tostring(joaat("WEAPON_UNARMED"))] = "Unarmed",
    [tostring(joaat("weapon_flashlight"))] = "Flashlight",
    [tostring(joaat("weapon_hatchet"))] = "Hatchet",
    [tostring(joaat("weapon_knuckle"))] = "Brass Knuckles",
    [tostring(joaat("weapon_machete"))] = "Machete",
    [tostring(joaat("weapon_switchblade"))] = "Switchblade",
    [tostring(joaat("weapon_wrench"))] = "Wrench",
    [tostring(joaat("weapon_battleaxe"))] = "Battle Axe",
    [tostring(joaat("weapon_poolcue"))] = "Pool Cue",
    [tostring(joaat("weapon_stone_hatchet"))] = "Stone Hatchet",
    [tostring(joaat("weapon_candycane"))] = "Candy Cane",
    [tostring(joaat("WEAPON_KNIFE"))] = "Knife",
    [tostring(joaat("WEAPON_NIGHTSTICK"))] = "NightStick",
    [tostring(joaat("WEAPON_HAMMER"))] = "Hammer",
    [tostring(joaat("WEAPON_BAT"))] = "Bat",
    [tostring(joaat("WEAPON_GOLFCLUB"))] = "Golfclub",
    [tostring(joaat("WEAPON_CROWBAR"))] = "Crowbar",
    [tostring(joaat("WEAPON_PISTOL"))] = "Pistol",
    [tostring(joaat("WEAPON_COMBATPISTOL"))] = "Combat Pistol",
    [tostring(joaat("WEAPON_APPISTOL"))] = "AP Pistol",
    [tostring(joaat("WEAPON_PISTOL50"))] = "Pistol 50",
    [tostring(joaat("weapon_pistol_mk2"))] = "Pistol Mk2",
    [tostring(joaat("weapon_snspistol_mk2"))] = "Sns Pistol Mk2",
    [tostring(joaat("weapon_marksmanpistol"))] = "Marksman Pistol",
    [tostring(joaat("weapon_revolver"))] = "Revolver",
    [tostring(joaat("weapon_revolver_mk2"))] = "Revolver Mk2",
    [tostring(joaat("weapon_doubleaction"))] = "Double Action",
    [tostring(joaat("weapon_raypistol"))] = "Up-n-Atomizer",
    [tostring(joaat("weapon_ceramicpistol"))] = "Ceramic Pistol",
    [tostring(joaat("weapon_navyrevolver"))] = "Navy Revolver",
    [tostring(joaat("weapon_gadgetpistol"))] = "Gadget Pistol",
    [tostring(joaat("weapon_stungun_mp"))] = "Stun gun",
    [tostring(joaat("weapon_pistolxm3"))] = "WM 29 Pistol",
    [tostring(joaat("weapon_smg_mk2"))] = "SMG Mk2",
    [tostring(joaat("weapon_combatpdw"))] = "Combat PDW",
    [tostring(joaat("weapon_machinepistol"))] = "Machine Pistol",
    [tostring(joaat("weapon_minismg"))] = "Mini SMG",
    [tostring(joaat("weapon_raycarbine"))] = "Unholy Hellbringer",
    [tostring(joaat("weapon_tecpistol"))] = "Tactical SMG",
    [tostring(joaat("weapon_pumpshotgun_mk2"))] = "Pump Shotgun Mk2",
    [tostring(joaat("weapon_dbshotgun"))] = "Double Barrel Shotgun",
    [tostring(joaat("weapon_autoshotgun"))] = "Sweeper Shotgun",
    [tostring(joaat("weapon_combatshotgun"))] = "Combat Shotgun",
    [tostring(joaat("weapon_assaultrifle_mk2"))] = "Assault Rifle Mk2",
    [tostring(joaat("weapon_carbinerifle_mk2"))] = "Carbine Rifle Mk2",
    [tostring(joaat("weapon_specialcarbine_mk2"))] = "Special Carbine Mk2",
    [tostring(joaat("weapon_bullpuprifle"))] = "Bullpup Rifle",
    [tostring(joaat("weapon_bullpuprifle_mk2"))] = "Bullpup Rifle Mk2",
    [tostring(joaat("weapon_compactrifle"))] = "Compact Rifle",
    [tostring(joaat("weapon_militaryrifle"))] = "Military Rifle",
    [tostring(joaat("weapon_heavyrifle"))] = "Heavy Rifle",
    [tostring(joaat("weapon_tacticalrifle"))] = "Tactical Rifle",
    [tostring(joaat("weapon_combatmg_mk2"))] = "Combat MG Mk2",
    [tostring(joaat("weapon_marksmanrifle_mk2"))] = "Marksman Rifle Mk2",
    [tostring(joaat("weapon_precisionrifle"))] = "Precision Rifle",
    [tostring(joaat("weapon_grenadelauncher_smoke"))] = "Grenade Launcher (Smoke)",
    [tostring(joaat("weapon_railgun"))] = "Railgun",
    [tostring(joaat("weapon_hominglauncher"))] = "Homing Launcher",
    [tostring(joaat("weapon_compactlauncher"))] = "Compact Grenade Launcher",
    [tostring(joaat("weapon_rayminigun"))] = "Widowmaker",
    [tostring(joaat("weapon_emplauncher"))] = "Compact EMP Launcher",
    [tostring(joaat("weapon_railgunxm3"))] = "Railgun",
    [tostring(joaat("weapon_proxmine"))] = "Proximity Mines",
    [tostring(joaat("weapon_pipebomb"))] = "Pipebomb",
    [tostring(joaat("weapon_acidpackage"))] = "Acid Package",
    [tostring(joaat("weapon_hazardcan"))] = "Hazardous Can",
    [tostring(joaat("weapon_fertilizercan"))] = "Fertilizer Can",
    [tostring(joaat("WEAPON_MICROSMG"))] = "Micro SMG",
    [tostring(joaat("WEAPON_SMG"))] = "SMG",
    [tostring(joaat("WEAPON_ASSAULTSMG"))] = "Assault SMG",
    [tostring(joaat("WEAPON_ASSAULTRIFLE"))] = "Assault Rifle",
    [tostring(joaat("WEAPON_CARBINERIFLE"))] = "Carbine Rifle",
    [tostring(joaat("WEAPON_ADVANCEDRIFLE"))] = "Advanced Rifle",
    [tostring(joaat("WEAPON_MG"))] = "MG",
    [tostring(joaat("WEAPON_COMBATMG"))] = "Combat MG",
    [tostring(joaat("WEAPON_PUMPSHOTGUN"))] = "Pump Shotgun",
    [tostring(joaat("WEAPON_SAWNOFFSHOTGUN"))] = "Sawnoff Shotgun",
    [tostring(joaat("WEAPON_ASSAULTSHOTGUN"))] = "Assault Shotgun",
    [tostring(joaat("WEAPON_BULLPUPSHOTGUN"))] = "Bullpup Shotgun",
    [tostring(joaat("WEAPON_STUNGUN"))] = "Stun gunn",
    [tostring(joaat("WEAPON_SNIPERRIFLE"))] = "Sniper Rifle",
    [tostring(joaat("WEAPON_HEAVYSNIPER"))] = "Heavy Sniper",
    [tostring(joaat("weapon_heavysniper_mk2"))] = "Heavy Sniper Mk2",
    [tostring(joaat("WEAPON_GRENADELAUNCHER"))] = "Grenade Launcher",
    [tostring(joaat("WEAPON_RPG"))] = "RPG",
    [tostring(joaat("WEAPON_MINIGUN"))] = "Minigun",
    [tostring(joaat("WEAPON_GRENADE"))] = "Grenade",
    [tostring(joaat("WEAPON_STICKYBOMB"))] = "Sticky Bomb",
    [tostring(joaat("WEAPON_SMOKEGRENADE"))] = "Smoke Grenade",
    [tostring(joaat("WEAPON_BZGAS"))] = "BZ Gas",
    [tostring(joaat("WEAPON_MOLOTOV"))] = "Molotov",
    [tostring(joaat("WEAPON_FIREEXTINGUISHER"))] = "Extinguisher",
    [tostring(joaat("WEAPON_PETROLCAN"))] = "Jerry Can",
    [tostring(joaat("WEAPON_BALL"))] = "Ball",
    [tostring(joaat("WEAPON_FLARE"))] = "Flare",
    [tostring(joaat("WEAPON_BOTTLE"))] = "Bottle",
    [tostring(joaat("WEAPON_GUSENBERG"))] = "Gusenberg",
    [tostring(joaat("WEAPON_SNSPISTOL"))] = "SNS Pistol",
    [tostring(joaat("WEAPON_VINTAGEPISTOL"))] = "Vintage Pistol",
    [tostring(joaat("WEAPON_DAGGER"))] = "Dagger",
    [tostring(joaat("WEAPON_FLAREGUN"))] = "Flare gun",
    [tostring(joaat("WEAPON_HEAVYPISTOL"))] = "Heavy Pistol",
    [tostring(joaat("WEAPON_SPECIALCARBINE"))] = "Special carbine",
    [tostring(joaat("WEAPON_MUSKET"))] = "Musket",
    [tostring(joaat("WEAPON_FIREWORK"))] = "Firework Launcher",
    [tostring(joaat("WEAPON_MARKSMANRIFLE"))] = "Marksman Rifle",
    [tostring(joaat("WEAPON_HEAVYSHOTGUN"))] = "Heavy Shotgun",
}

function GetLabelofCurrentWeapon(hash)
    if(type(hash) ~= "string") then
        hash = tostring(hash)
    end

    local label = WeaponHashes[hash]
    if label ~= nil then
        return label
    end

    return "invalid" -- Return the invalid label
end

function GetTint(ped,hash)
    local tintIndex = WEAPON.GET_PED_WEAPON_TINT_INDEX(ped, hash)
    
    if tintIndex == 0 then
        return "Default/Black"
     elseif tintIndex == 1 then
        return "Green"
     elseif tintIndex == 2 then
        return "Gold"
     elseif tintIndex == 3 then
        return "Pink"
     elseif tintIndex == 4 then
        return "Army"
     elseif tintIndex == 5 then
        return "LSPD"
     elseif tintIndex == 6 then
        return "Orange"
     elseif tintIndex == 7 then
        return "Platinum"
     else
        return "Unkown"
    end
end
