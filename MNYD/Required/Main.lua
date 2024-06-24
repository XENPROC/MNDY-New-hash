
require("Required/Functions")
require("Required/API")

PlayersTab:add_text("Money/RP Drops");

function drop_function(modelhash, pickupHash, amount, value)
    script.run_in_fiber(function(script)
        local model = modelhash
        local pickup = pickupHash
        local money_value = value
        local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player())
        local player_name = PLAYER.PLAYER_ID(PLAYER.GET_PLAYER_PED(network.get_selected_player()))
        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), false)
        STREAMING.REQUEST_MODEL(model)
        while STREAMING.HAS_MODEL_LOADED(model) == false do
            script:yield()
        end
        if STREAMING.HAS_MODEL_LOADED(model) then
            for i = 1, amount do
                local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(pickup, coords.x, coords.y, coords.z + 2.2, 0,
                    money_value, model, true, false)
                local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
                NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
            end
            iconNotification("CHAR_DEFAULT", "CHAR_DEFAULT", true, 8, LuaName,
                "Dropping For: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()))
        end
    end)
end

function SCEdrop_function(hash, EventHash, value)
    local SCEHash = hash
    local Eventnum = EventHash
    local HowManyThings = value
    local player_id = network.get_selected_player()
    network.trigger_script_event(player_id, { SCEHash, player_id, 1, Eventnum, 100, -3, 1, 1, 1 });
    iconNotification("CHAR_DEFAULT", "CHAR_DEFAULT", true, 8, LuaName,
        "Player: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .. " is Searching")
end

local SCEdropTypes = {
    ["Buried Stashes"] = { SCEHash = 968269233, Eventnum = 6 },
    ["Treasure Chests"] = { SCEHash = 968269233, Eventnum = 2 },
    ["Circo Loco"] = { SCEHash = 968269233, Eventnum = 4 },
}

--PROP_MONEY_PAPERCASE_01 -1803909274
--PROP_MONEY_PAPERBAG_01 -1666779307
--PROP_MONEY_BAG_01 0x113FD533
--PICKUP_MONEY_CASE 0x1E9A99F8

local dropTypes = {
    ["2k Drop"] = { model = joaat("prop_money_bag_01"), pickup = joaat("PICKUP_MONEY_CASE"), value = 2500 },
    ["2k Drop (2)"] = { model = 1203231469, pickup = joaat("PICKUP_MONEY_MED_BAG"), value = 10000 },
    ["Monkey Collectable"] = { model = joaat("vw_prop_vw_colle_pogo"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0 },
    ["Beasts Collectable"] = { model = joaat("vw_prop_vw_colle_beast"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0 },
    ["Impotent Rage Collectable"] = { model = joaat("vw_prop_vw_colle_imporage"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0 },
    ["Sasquatch Collectable"] = { model = joaat("vw_prop_vw_colle_sasquatch"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0 },
    ["Bubblegum Collectable"] = { model = joaat("vw_prop_vw_colle_prbubble"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0 },
    ["RSR Collectable"] = { model = joaat("vw_prop_vw_colle_rsrcomm"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0 },
    ["Drop Cards"] = { model = joaat("vw_prop_vw_lux_card_01a"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0 }
}

for name, dropInfo in pairs(dropTypes) do
    local checkbox = PlayersTab:add_checkbox(name)
    script.register_looped(name, function(script)
        script:yield()
        if checkbox:is_enabled() then
            drop_function(dropInfo.model, dropInfo.pickup, 10, dropInfo.value)
            script:sleep(RPDropTime)
        end
    end)
end

PlayersTab:add_separator();
PlayersTab:add_text("SCE Drops");
for name, SCEdropInfo in pairs(SCEdropTypes) do
    local checkbox = PlayersTab:add_checkbox(name)
    script.register_looped(name, function(script)
        script:yield()
        if checkbox:is_enabled() then
            SCEdrop_function(SCEdropInfo.SCEHash, SCEdropInfo.Eventnum, SCEdropInfo.value)
            SCEdrop_function(SCEdropInfo.SCEHash, SCEdropInfo.Eventnum, SCEdropInfo.value)
            SCEdrop_function(SCEdropInfo.SCEHash, SCEdropInfo.Eventnum, SCEdropInfo.value)
        end
    end)
end


PlayersTab:add_separator();
PlayersTab:add_text("Toxic/Griefing");
PlayersTab:add_button("Fragment Crash", function()
    script.run_in_fiber(function(script)
        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), false)
        gui.show_message(LuaName, "Attempting to Crash: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .. " ");
        hash1 = joaat("prop_fragtest_cnst_04")
        hash2 = joaat("prop_fragtest_cnst_02")
        hash3 = joaat("prop_fragtest_cnst_08")
        local object = CreateWorldObject(hash1, coords.x, coords.y, coords.z)
        DeleteEntity(object)
        local object2 = CreateWorldObject(hash2, coords.x, coords.y, coords.z)
        DeleteEntity(object2)
        local object3 = CreateWorldObject(hash2, coords.x, coords.y, coords.z)
        DeleteEntity(object3)
        local object4 = CreateWorldObject(hash1, coords.x, coords.y, coords.z)
        DeleteEntity(object4)
        local object5 = CreateWorldObject(hash2, coords.x, coords.y, coords.z)
        DeleteEntity(object5)
        local object6 = CreateWorldObject(hash2, coords.x, coords.y, coords.z)
        DeleteEntity(object6)
        log.warning("You attempted to crash: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .. " ");
    end)
end);

PlayersTab:add_button("Rage Shoot", function()
    script.run_in_fiber(function(script)
        ShootAt()
        end)
end);
PlayersTab:add_sameline();
PlayersTab:add_button("Drop Vehicle on Player", function()
    script.run_in_fiber(function(script)
        DropVehicleOnPlayer("adder")
        end)
end);

PlayersTab:add_separator();
PlayersTab:add_text("Friendly");
PlayersTab:add_separator();
PlayersTab:add_button("Fix Vehicle", function()
    script.run_in_fiber(function(script)
        local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
        if PED.IS_PED_IN_ANY_VEHICLE(player_id, true) then
            local playerVehicle = PED.GET_VEHICLE_PED_IS_USING(player_id);
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(playerVehicle);
            VEHICLE.SET_VEHICLE_FIXED(playerVehicle);
            gui.show_message(LuaName, "Fixed: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .. "'s Vehicle ");
        else
            gui.show_message(LuaName,
                "Player: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .. " isnt in a vehicle ");
        end
    end)
end);


local checkbox = AllPlayers:add_checkbox("Explode All (Anonymous)")
script.register_looped("Explode All", function(script)
    script:yield()
    if checkbox:is_enabled() then
        gui.show_message(LuaName, "Exploding All Players Repeatedly");
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true);
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, explosionType, 100000, true, false, 0, false);
                GRAPHICS.USE_PARTICLE_FX_ASSET(explosionFx);
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_AT_COORD("explosion_barrel", coords.x, coords.y, coords.z, 0, 0, 0,
                    1, false, true, false);
                script:sleep(1);
            end
        end
    end
end)
AllPlayers:add_sameline()
local checkbox = AllPlayers:add_checkbox("Ragdoll All")
script.register_looped("Ragdoll All", function(script)
    script:yield()
    if checkbox:is_enabled() then
        gui.show_message(LuaName, "Ragdolled all players");
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true);
                coords.z = coords.z - 2;
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 100, false);
                script:sleep(1);
            end
        end
    end
end)
local checkbox = AllPlayers:add_checkbox("Burn All")
script.register_looped("Burn All", function(script)
    script:yield()
    if checkbox:is_enabled() then
        gui.show_message(LuaName, "Burning Players");
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true);
                coords.z = coords.z + 0.8;
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 3, 1, true, false, 1, false);
                script:sleep(1);
            end
        end
    end
end)
AllPlayers:add_sameline()
local checkbox = AllPlayers:add_checkbox("Raygun All")
script.register_looped("Raygun All", function(script)
    script:yield()
    if checkbox:is_enabled() then
        gui.show_message(LuaName, "Rayguning Players");
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true);
                coords.z = coords.z + 0.8;
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 70, 1, true, false, 1, false);
                script:sleep(5);
            end
        end
    end
end)
AllPlayers:add_sameline()
local checkbox = AllPlayers:add_checkbox("Rattle Screen")
script.register_looped("Rattle Screen", function(script)
    script:yield()
    if checkbox:is_enabled() then
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true);
                coords.z = coords.z + 0.8;
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 74, 1, true, false, 1, false);
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 75, 1, true, false, 1, false);
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 74, 1, true, false, 1, false);
                script:sleep(0);
            end
        end
    end
end)
local checkbox = AllPlayers:add_checkbox("Speedy Vehicle")
script.register_looped("Speedy Vehicle", function(script)
    script:yield()
    if checkbox:is_enabled() then
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                local model = joaat("stt_prop_track_speedup_t1");
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(player_id), false);
                pos.z = pos.z - 2.6;
                STREAMING.REQUEST_MODEL(model);
                while not STREAMING.HAS_MODEL_LOADED(model) do
                    script:yield();
                end
                local obj = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, false, false);
                ENTITY.SET_ENTITY_HEADING(obj, ENTITY.GET_ENTITY_HEADING(player_id) - 90);
                script:sleep(1);
                if ENTITY.DOES_ENTITY_EXIST(obj) then
                    OBJECT.DELETE_OBJECT(obj);
                end
            end
        end
    end
end)
AllPlayers:add_sameline()
local checkbox = AllPlayers:add_checkbox("Slow Vehicle")
script.register_looped("Slow Vehicle", function(script)
    script:yield()
    if checkbox:is_enabled() then
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                local model = joaat("stt_prop_track_slowdown");
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(player_id), false);
                pos.z = pos.z - 2.0;
                STREAMING.REQUEST_MODEL(model);
                while not STREAMING.HAS_MODEL_LOADED(model) do
                    script:yield();
                end
                local obj = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, false, false);
                ENTITY.SET_ENTITY_HEADING(obj, ENTITY.GET_ENTITY_HEADING(player_id) - 90);
                script:sleep(1);
                if ENTITY.DOES_ENTITY_EXIST(obj) then
                    OBJECT.DELETE_OBJECT(obj);
                end
            end
        end
    end
end)



AllPlayers:add_separator();
AllPlayers:add_text("Teleports");
AllPlayers:add_button("Comedy Room", function()
    network.set_all_player_coords(380.585, -1000.17566, -99.000015, true);
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 380.585, -1000.17566, -99.000015, false, false,
        true, true);
end);
AllPlayers:add_sameline();
AllPlayers:add_button("Mugshot Room", function()
    network.set_all_player_coords(399.26633, -1004.46765, -99.00412, true);
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 399.26633, -1004.46765, -99.00412, false, false,
        true, true);
end);
AllPlayers:add_sameline();
AllPlayers:add_button("Jail Cell", function()
    network.set_all_player_coords(459.72223, -994.1862, 24.914667, true);
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 459.72223, -994.1862, 24.914667, false, false,
        true, true);
end);
AllPlayers:add_button("Mount Chiliad", function()
    network.set_all_player_coords(501.403, 5598.647, 796.137, true);
    ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 501.403, 5598.647, 796.137, false, false, true,
        true);
end);

MenuImGui:add_imgui(function()
    ImGui.PushItemWidth(190);
    Watermark_Features = ImGui.Combo("Watermark Names", Watermark_Features, Watermark_Featnames,
        Watermark_FeatnamesAmmount, 15)
    Watermark, isWaterMarkChanged = ImGui.Checkbox("Watermark", Watermark);
    script.run_in_fiber(function(script)
        if isWaterMarkChanged then
            while Watermark do
                local localply = PLAYER.PLAYER_ID();
                for i = 0, 32 do
                    if (i ~= localPlayerId) then
                        local player_id = i;
                        local ply_name = NETWORK.NETWORK_GET_HOST_PLAYER_INDEX(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(
                            player_id));
                        offset = { x = 0.6, y = 0.001 };
                        HUD.SET_TEXT_FONT(0);
                        HUD.SET_TEXT_SCALE(0.25, 0.25);
                        HUD.SET_TEXT_CENTRE(false);
                        HUD.SET_TEXT_DROPSHADOW(2, 2, 0, 0, 0);
                        HUD.SET_TEXT_EDGE(1, 0, 0, 0, 205);
                        HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING");
                        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("~ws~" ..
                            Watermark_Featnames[Watermark_Features + 1] ..
                            " | Welcome: " ..
                            PLAYER.GET_PLAYER_NAME(localply) ..
                            " | Players: " ..
                            GetPlayerCount() ..
                            " | Host: " ..
                            PLAYER.GET_PLAYER_NAME(ply_name) .. " | ScriptHost: " .. ScriptHostName() .. " ");
                        GRAPHICS.DRAW_RECT(offset.x + 0.187, offset.y, 0.39, 0.049, 0, 0, 0, 125, 0);
                        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(offset.x, offset.y);
                        script:sleep(0);
                    end
                end
            end
        end
    end)
end)
function LoadTextureDict(dictName)
    if not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dictName) then
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dictName, false)
        while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dictName) do
            script:yield()
        end
    end
end


MenuImGui:add_sameline();
local checkbox = MenuImGui:add_checkbox("In-Game Hud")

local function draw_weapon_info()
    if not checkbox:is_enabled() then
        return
    end
    
    

    local playerhealth = math.floor(ENTITY.GET_ENTITY_HEALTH(YourselfPED) - 100)
    local playerarmour = math.floor(PED.GET_PED_ARMOUR(YourselfPED))
    local menuY = 0.30
    local menuX = 0.09
    DrawText("~h~ Health: ", menuX - 0.061, menuY + 0.672, 0.0, 0.2650)
    DrawText("~h~ Armour: ", menuX + 0.011, menuY + 0.672, 0.0, 0.2650)
    DrawText("~HUD_COLOUR_BLUE~~h~ "..playerarmour, menuX + 0.046, menuY + 0.671, 0.0, 0.2800)
    if playerhealth >= 80 then
        DrawText("~HUD_COLOUR_GREEN~~h~ "..playerhealth, menuX - 0.029, menuY + 0.671, 0.0, 0.2800)
    end
    if playerhealth > 40 and playerhealth < 80 then
        DrawText("~HUD_COLOUR_YELLOW~~h~ "..playerhealth, menuX - 0.029, menuY + 0.671, 0.0, 0.2800)
    end
    if playerhealth <= 40 then
        DrawText("~HUD_COLOUR_RED~~h~ "..playerhealth, menuX - 0.029, menuY + 0.671, 0.0, 0.2800)
     end
    GRAPHICS.DRAW_RECT(menuX- 0.040, menuY + 0.684, 0.071, 0.025, 0, 0, 0, 255, 0)
    GRAPHICS.DRAW_RECT(menuX+ 0.031, menuY + 0.684, 0.070, 0.025, 0, 0, 0, 255, 0)
    if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("commonmenu") then
        GRAPHICS.DRAW_SPRITE("commonmenu", "shop_health_icon_a", menuX - 0.068, menuY + 0.683, 0.015, 0.025, 0.0, 255, 255, 255, 255, 0, 0)
        GRAPHICS.DRAW_SPRITE("commonmenu", "shop_armour_icon_a", menuX + 0.005, menuY + 0.683, 0.015, 0.025, 0.0, 255, 255, 255, 255, 0, 0)
    else
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT("commonmenu")
end


    local weapHash = WEAPON.GET_SELECTED_PED_WEAPON(Yourselfpedid)
    local bool, ammo = WEAPON.GET_AMMO_IN_CLIP(YourselfPED, weapHash)
    local MaxAmmo = WEAPON.GET_MAX_AMMO_IN_CLIP(YourselfPED, weapHash)
    local Totalammo = WEAPON.GET_AMMO_IN_PED_WEAPON(YourselfPED, weapHash)
    local AmmoLeft = math.floor(Totalammo - ammo)
    local labelName = GetLabelofCurrentWeapon(weapHash)
    local attachments = weapons.get_all_weapon_components(weapHash)
    
    local menuY = 0.90
    local menuX = 0.25
    DrawText("~h~" .. labelName .. " ", menuX - 0.08, menuY - 0.06, 0.0, 0.2500)
    GRAPHICS.DRAW_RECT(0.25, menuY, 0.170, 0.155, 0, 0, 0, 150, 0)
    if MaxAmmo > 0 then
        DrawText("~g~" .. ammo .. "/" .. MaxAmmo .. " ~h~(" .. AmmoLeft .. ") ", menuX + 0.029, menuY - 0.06, 0.0, 0.2500)
        
        if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("commonmenu") then
            GRAPHICS.DRAW_SPRITE("commonmenu", "shop_ammo_icon_a", menuX + 0.024, menuY - 0.050, 0.015, 0.025, 0.0, 255, 255, 255, 255, 0, 0)
        else
            GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT("commonmenu")
        end
    end
    DrawText("Tint Index: " .. GetTint(YourselfPED, weapHash) .. " ", menuX - 0.08, menuY - 0.04, 0.0, 0.2500)
    DrawText("Weapon Group: " .. WEAPON.GET_WEAPONTYPE_GROUP(weapHash) .. " ", menuX - 0.08, menuY - 0.02, 0.0, 0.2500)
    
    local SecondX = menuX + 0.18
    
    if #attachments > 0 then
        GRAPHICS.DRAW_RECT(SecondX, menuY, 0.170, 0.155, 0, 0, 0, 150, 0)
        DrawText("~HUD_COLOUR_MENU_YELLOW~~h~Attachments", SecondX - 0.08, menuY - 0.06, 0.0, 0.2500)
        
        local yOffset = menuY - 0.06 + 0.02
        for i = 1, #attachments do
            if WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(YourselfPED, weapHash, joaat(attachments[i])) then
                DrawText("" .. attachments[i] .. " ", SecondX - 0.08, yOffset, 0.0, 0.2500)
                yOffset = yOffset + 0.02
            end
        end
    end

    for name, WeapInfo in pairs(Weaponss) do 
    if weapHash == joaat(name) then
    if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(WeapInfo.TextureDict) then
        GRAPHICS.DRAW_SPRITE(WeapInfo.TextureDict, WeapInfo.TextureName, menuX + 0.36, 0.90, WeapInfo.Width, WeapInfo.Height, 0.0, 255, 255, 255, 255, 0, 0)
    else
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(WeapInfo.TextureDict)
    end
end
end
end
script.register_looped("IngameHud", function(script)
    draw_weapon_info()
end)
MenuImGui:add_separator();
MenuImGui:add_imgui(function()
    ImGui.PushItemWidth(190);
    selected_TransactionMethod = ImGui.Combo("Select Transfer", selected_TransactionMethod, Transaction_names, 2, 15)
    TransferBank, TransferBankused = ImGui.InputInt("Amount", TransferBank, 1, 2147483646);
end)

MenuImGui:add_button("Transfer Money", function()
    script.run_in_fiber(function(script)
        if selected_TransactionMethod == 0 then
            gui.show_warning(LuaName, "Transfering $" .. TransferBank .. " To your bank")
            script:sleep(1000)
            NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(stats.get_character_index(), TransferBank)
            log.debug(TransferBank)
        end
        if selected_TransactionMethod == 1 then
            gui.show_warning(LuaName, "Transfering $" .. TransferBank .. " To your wallet")
            script:sleep(1000)
            NETSHOPPING.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(stats.get_character_index(), TransferBank)
            log.debug(TransferBank)
        end
    end)
end);
MenuImGui:add_separator();
MenuImGui:add_text("Helpers");
MenuImGui:add_separator();
local checkbox = MenuImGui:add_checkbox("Force World Populate")
script.register_looped("Force World Populate", function(script)
    if checkbox:is_enabled() then
        MISC.POPULATE_NOW()
        script:sleep(900)
    end
end)
MenuImGui:add_sameline();
MenuImGui:add_button("Unlock All Achivements", function()
    script.run_in_fiber(function(script)
        for i = 0, 77 do
            PLAYER.GIVE_ACHIEVEMENT_TO_PLAYER(i);
            gui.show_warning(LuaName, "Unlocking All Achivements")
        end
    end)
end);
MenuImGui:add_button("Fill Snacks", function()
    gui.show_message(LuaName, "Snacks Filled");
    STATS.STAT_SET_INT(joaat(MPX .. "NO_BOUGHT_YUM_SNACKS"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX .. "NO_BOUGHT_HEALTH_SNACKS"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX .. "NO_BOUGHT_EPIC_SNACKS"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX .. "NUMBER_OF_CHAMP_BOUGHT"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX .. "NUMBER_OF_ORANGE_BOUGHT"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX .. "NUMBER_OF_BOURGE_BOUGHT"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX .. "NUMBER_OF_SPRUNK_BOUGHT"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX .. "CIGARETTES_BOUGHT"), 25, true);
end);
MenuImGui:add_sameline();
MenuImGui:add_button("Unlimited Chip Purchase", function()
    STATS.STAT_SET_INT(joaat("MPPLY_CASINO_CHIPS_PUR_GD"), -100000000000000, true);
    gui.show_message(LuaName, "Purchase as many chips as you would like");
end);

MenuImGui:add_button("0% Mental State", function()
    script.run_in_fiber(function(script)
        gui.show_message(LuaName, "Changing Mental State");
        script:sleep(1000);
        STATS.STAT_SET_FLOAT(joaat("MP0_PLAYER_MENTAL_STATE"), 0, true)
end)
end);
MenuImGui:add_sameline();
MenuImGui:add_button("Add Bad Sport", function()
    script.run_in_fiber(function(script)
        gui.show_message(LuaName, "BadSport Added, Changing Session");
        script:sleep(1000);
        stats.set_int("MPPLY_BADSPORT_MESSAGE", 1)
        stats.set_int("MPPLY_BADSPORT_MESSAGE", 1)
        stats.set_float("MPPLY_OVERALL_BADSPORT", 60000)
        stats.set_bool("MPPLY_CHAR_IS_BADSPORT", true)
        globals.set_int(1574589, 1)
        script:sleep(300);
        globals.set_int(1574589, 0)
end)
end);
MenuImGui:add_sameline();
MenuImGui:add_button("Remove Bad Sport", function()
    script.run_in_fiber(function(script)
        gui.show_message(LuaName, "BadSport Removed, Changing Session");
        script:sleep(1000);
        stats.set_int("MPPLY_BADSPORT_MESSAGE", 0)
        stats.set_int("MPPLY_BADSPORT_MESSAGE", 0)
        stats.set_float("MPPLY_OVERALL_BADSPORT", 0)
        stats.set_bool("MPPLY_CHAR_IS_BADSPORT", false)
        globals.set_int(1574589, 1)
        script:sleep(300);
        globals.set_int(1574589, 0) 
end)
end);


MenuImGui:add_separator();
MenuImGui:add_text("Crosshair");
MenuImGui:add_sameline();
Showatall = MenuImGui:add_checkbox("Show at all times")
MenuImGui:add_sameline();
local checkbox = MenuImGui:add_checkbox("Hide Dot")
script.register_looped("Hide Dot", function(script)
    if checkbox:is_enabled() then
        HUD.HIDE_HUD_COMPONENT_THIS_FRAME(14)
    end
end)
MenuImGui:add_separator();



local checkbox = MenuImGui:add_checkbox("Crosshair (+)")
script.register_looped("Crosshair", function(script)
    if checkbox:is_enabled() then
        if PLAYER.IS_PLAYER_FREE_AIMING(Yourself) and not Showatall:is_enabled() then
            DrawText('+', 0.4960, 0.481, 0.0, 0.4)
        elseif Showatall:is_enabled() then
            DrawText('+', 0.4960, 0.481, 0.0, 0.4)
        end
    end
end)
MenuImGui:add_sameline();
local checkbox = MenuImGui:add_checkbox("Crosshair (Square)")
script.register_looped("Crosshair2", function(script)
    if checkbox:is_enabled() then
        if PLAYER.IS_PLAYER_FREE_AIMING(Yourself) and not Showatall:is_enabled() then
            DrawText('☐', 0.4972, 0.491, 0.2, 0.2)
        elseif Showatall:is_enabled() then
            DrawText('☐', 0.4972, 0.491, 0.2, 0.2)
        end
    end
end)
local checkbox = MenuImGui:add_checkbox("Crosshair ({ })")
script.register_looped("Crosshair3", function(script)
    if checkbox:is_enabled() then
        if PLAYER.IS_PLAYER_FREE_AIMING(Yourself) and not Showatall:is_enabled() then
            DrawText("{ }", 0.4964, 0.491, 0.2, 0.2)
        elseif Showatall:is_enabled() then
            DrawText('{ }', 0.4964, 0.491, 0.2, 0.2)
        end
    end
end)
MenuImGui:add_sameline();
local checkbox = MenuImGui:add_checkbox("Crosshair (O)")
script.register_looped("CrosshairO", function(script)
    if checkbox:is_enabled() then
        if PLAYER.IS_PLAYER_FREE_AIMING(Yourself) and not Showatall:is_enabled() then
            DrawText("O", 0.4964, 0.491, 0.2, 0.2)
        elseif Showatall:is_enabled() then
            DrawText('O', 0.4964, 0.491, 0.2, 0.2)
        end
    end
end)




local checkbox = MenuImGui:add_checkbox("Weapon Controller (AIM AT ENTITY!)")
script.register_looped("WeaponController", function(script)
    if checkbox:is_enabled() then
        local IsFound, Object = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID())
        entityCoord = ENTITY.GET_ENTITY_COORDS(Object, false)
        if IsFound then
            GRAPHICS.DRAW_MARKER_SPHERE(entityCoord.x, entityCoord.y, entityCoord.z, 1, 0, 255, 0, 0.3)
            DrawText("Aiming At: " .. ENTITY.GET_ENTITY_MODEL(Object), 0.4738, 0.505, 0.2, 0.2)
            DrawText("Press E to delete", 0.4798, 0.517, 0.2, 0.2)
            DrawText("Press Q to Fling", 0.4798, 0.529, 0.2, 0.2)
            DrawText("X:  " .. entityCoord.x .. " Y:  " .. entityCoord.y .. "Z:  " .. entityCoord.z .. " ", 0.4200, 0.539,
                0.2, 0.2)
            if PAD.IS_CONTROL_JUST_PRESSED(0, 38) then
                DeleteEntity(Object)
            end
            if PAD.IS_CONTROL_JUST_PRESSED(0, 52) then
                ForceControl(Object);
                ENTITY.SET_ENTITY_VELOCITY(Object, math.random(-180, 180), math.random(-180, 180), math.random(-180, 180));
            end
        end
    end
end)

NightClubMNDY:add_button("Refill Nightclub Popularity", function()
    script.run_in_fiber(function(script)
        STATS.STAT_SET_INT(joaat(MPX .. "CLUB_POPULARITY"), 1000, true);
        gui.show_warning(LuaName, "Popularity set too 100%")
    end)
end);
NightClubMNDY:add_sameline()
local Checkbox = NightClubMNDY:add_checkbox("Auto Refill Safe & Popularity (5s)")
script.register_looped("Auto Refill Safe (5s)", function(script)
    script:yield()
    if Checkbox:is_enabled() then
        STATS.STAT_SET_INT(joaat(MPX .. "CLUB_POPULARITY"), 1000, true);
        STATS.STAT_SET_INT(joaat(MPX .. "CLUB_PAY_TIME_LEFT"), -1, true)
        script:sleep(5000)
    end
end)


recoveryTab2:add_text("MNYD Quick Cash (ONLY YOU ARE RESPONSABLE FOR USING THESE OPTIONS!)");
local MNYDMoney = {
    ["5k Chips"] = { globalnum = 1963515, Num2 = 1, ConsoleDisplay = "Given 5K Chips" },
    ["5Ok"] = { hash = joaat(FIFTYKJoaats[math.random(#FIFTYKJoaats)]), value = 50000, ConsoleDisplay = FIFTYKJoaats[math.random(#FIFTYKJoaats)] },
    ["250k"] = { hash = joaat(twohundredkJoaats[math.random(#twohundredkJoaats)]), value = 250000, ConsoleDisplay = twohundredkJoaats[math.random(#twohundredkJoaats)] },
    ["1m (Hash)"] = { hash = joaat(onemhash1), value = 1000000, ConsoleDisplay = onemhash1 },
    ["1m (Global)"] = { hash = 1633116913, value = 1000000, ConsoleDisplay = 1633116913 },
}
for name, MNYDmonInfo in pairs(MNYDMoney) do
    local checkbox = recoveryTab2:add_checkbox(name)
    script.register_looped(name, function(script)
        script:yield()
        if checkbox:is_enabled() then
            MNYDJJDU837KLSLLMNMNKUIEU8U14(MNYDmonInfo.hash, MNYDmonInfo.value)
            GlobalInt(MNYDmonInfo.globalnum, MNYDmonInfo.Num2)
            log.debug("Current Joaat: " .. name .. " " .. MNYDmonInfo.ConsoleDisplay .. " ")
            script:sleep(MNYDQuckCashTime)
        end
    end)
end

recoveryTab2:add_imgui(function()
    if ImGui.BeginChildFrame(80, 250, 80, ImGuiWindowFlags.NoBackground) then
        ImGui.SameLine((80) - (10));
        ImGui.TextColored(1, 0, 0, 1, "Riskier Options");
        if ImGui.Button("15 Million") then
            MNYDJJDU837KLSLLMNMNKUIEU8U14(joaat("SERVICE_EARN_JOB_BONUS"), 15000000)
        end
        ImGui.SameLine();
        if ImGui.Button("25 Million") then
            MNYDJJDU837KLSLLMNMNKUIEU8U14(joaat("SERVICE_EARN_GANGOPS_AWARD_MASTERMIND_4"), 15000000)
            MNYDJJDU837KLSLLMNMNKUIEU8U14(joaat("SERVICE_EARN_JUGGALO_STORY_MISSION"), 10000000)
        end
        ImGui.SameLine();
        if ImGui.Button("40 Million") then
            MNYDJJDU837KLSLLMNMNKUIEU8U14(joaat("SERVICE_EARN_BEND_JOB"), 15000000)
            MNYDJJDU837KLSLLMNMNKUIEU8U14(joaat("SERVICE_EARN_GANGOPS_AWARD_MASTERMIND_3"), 7000000)
            MNYDJJDU837KLSLLMNMNKUIEU8U14(joaat("SERVICE_EARN_GANGOPS_AWARD_MASTERMIND_4"), 15000000)
            MNYDJJDU837KLSLLMNMNKUIEU8U14(joaat("SERVICE_EARN_FROM_BUSINESS_HUB_SELL"), 2000000)
            MNYDJJDU837KLSLLMNMNKUIEU8U14(joaat("SERVICE_EARN_DAILY_OBJECTIVE_EVENT"), 1000000)
        end
        ImGui.EndChildFrame();
    end
end)


StatisticsMNDY:add_text("Coming Soon");
