DebugInfo = true
value = 1 -- Default Button: INT
textint = ""
textFloat = ""
textbool = ""
InfinateRoll = false
InfinateRollChanged = false
BugRoll = false
BugRollChanged = false

Stattrueorfalse = {"false","true"}
require("Required/API")

MNDYTeleports:add_separator();
MNDYTeleports:add_text("Special Teleports");
MNDYTeleports:add_separator();
MNDYTeleports:add_button("Gun Van", function()
    script.run_in_fiber(function(script)
            teleport_too_blip(844)
    end)
end);
MNDYTeleports:add_separator();
MNDYTeleports:add_text("Locations");
MNDYTeleports:add_separator();
MNDYTeleports:add_button("Hanger", function()
    script.run_in_fiber(function(script)
            teleport_too_blip(569)
    end)
end);
MNDYTeleports:add_button("NightClub", function()
    script.run_in_fiber(function(script)
            teleport_too_blip(614)
    end)
end);
StatisticsMNDY:add_separator();
StatisticsMNDY:add_text("Stats");
StatisticsMNDY:add_separator();
StatisticsMNDY:add_imgui(function()
    if value == 1 then
        ImGui.Text("Example Below: \nHash: MPPLY_KILLS_PLAYERS, \nAmount: 1000")
        end
        if value == 2 then
            ImGui.Text("Example Below: \nHash: MPPLY_KILL_DEATH_RATIO, \nAmount: 12.0")
        end
        if value == 3 then
            ImGui.Text("Example Below: \nHash: MPX_AWD_WIZHARD, \nState: true")
        end
    value, ischanged = ImGui.RadioButton("INT", value, 1)ImGui.SameLine((80) - (10));
    value, ischanged = ImGui.RadioButton("FLOAT", value, 2)
    ImGui.SameLine();
    value, ischanged = ImGui.RadioButton("BOOL", value, 3)
end)
StatisticsMNDY:add_separator();
StatisticsMNDY:add_imgui(function()
    ImGui.PushItemWidth(245);
    if value == 1 then
        textint, selected = ImGui.InputText("Hash", textint, 100)
        Statamount = ImGui.InputInt("Amount", Statamount, 1, 2147483646);
        TDBPUp = ImGui.Button("Update");
    if TDBPUp then
            STATS.STAT_SET_INT(joaat(textint), Statamount, true);
            gui.show_warning(LuaName, "Updated: ".. textint.. " \nStat Type: INT \nAmount: "..Statamount)
    end
end
    if value == 2 then
        textFloat, selected = ImGui.InputText("Hash", textFloat, 100)
        Statamountfloat = ImGui.InputFloat("Amount ", Statamountfloat, 1.0, 2147483646);
        UpdateFloats = ImGui.Button("Update");
        if UpdateFloats then
            STATS.STAT_SET_FLOAT(joaat(textFloat), Statamountfloat, true);
            gui.show_warning(LuaName, "Updated: "..textFloat.. " \nStat Type: FLOAT \nAmount: "..Statamountfloat)
        end
    end
    if value == 3 then
        textbool, selected = ImGui.InputText("Hash", textbool, 100)
        Selectedbool = ImGui.Combo("State", Selectedbool, Stattrueorfalse, 2)
        UpdateBool = ImGui.Button("Update");
        if UpdateBool then
            if Selectedbool == 0 then
            stats.set_bool(textbool, false)
            end
            if Selectedbool == 1 then
                stats.set_bool(textbool, true)
                end
            gui.show_warning(LuaName, "Updated: "..textbool.. " \nStat Type: BOOL \nState: "..Selectedbool)
        end
    end
end)

--======================================================================-
--===============================Functions==============================-
--======================================================================-
TransactionGlobal = 4537311; --1.69
function MoneyTransactions(hash, amount)
	GlobalInt(TransactionGlobal + 1, 2147483646);
	GlobalInt(TransactionGlobal + 7, 2147483647);
	GlobalInt(TransactionGlobal + 6, 0);
	GlobalInt(TransactionGlobal + 5, 0);
	GlobalInt(TransactionGlobal + 3, hash);
	GlobalInt(TransactionGlobal + 2, amount);
	GlobalInt(TransactionGlobal, 2);
end

function DeleteEntity(Entity)
        gui.show_warning(LuaName, "Deleting Entity")
        ENTITY.DETACH_ENTITY(Entity, true, true)
        ENTITY.SET_ENTITY_VISIBLE(Entity, false, false)
        NETWORK.NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS(Entity, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Entity, 0.0, 0.0, -1000.0, false, false, false)
        ENTITY.SET_ENTITY_COLLISION(Entity, false, false)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Entity, true, true)
        ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(Entity)
        ENTITY.DELETE_ENTITY(Entity)
end


function DeleteObject(Object)
    ENTITY.DETACH_ENTITY(Object, true, true)
    ENTITY.SET_ENTITY_VISIBLE(Object, false, false)
    NETWORK.NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS(Object, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object, 0.0, 0.0, -1000.0, false, false, false)
    ENTITY.SET_ENTITY_COLLISION(Object, false, false)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Object, true, true)
    ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(Object)
    OBJECT.DELETE_OBJECT(Object)
end

function formatMoney(value)
    return "$"..tostring(value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
  end


function ShootAt()
    local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
    local weapHash = -619010992
    local pedcoords = ENTITY.GET_ENTITY_COORDS(player_id, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y, pedcoords.z + 5.5, pedcoords.x, pedcoords.y, pedcoords.z+0.1, 1000, true, weapHash, YourselfPED, true, true, -1, player_id, true)
end

function DropVehicleOnPlayer(name)
    script.run_in_fiber(function(script)
    local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
    local pedcoords = ENTITY.GET_ENTITY_COORDS(player_id, false)
    local hash = joaat(name)
    STREAMING.REQUEST_MODEL(hash);
    while not STREAMING.HAS_MODEL_LOADED(hash) do script:yield(); end
    local vehicleCreate = VEHICLE.CREATE_VEHICLE(hash, pedcoords.x, pedcoords.y, pedcoords.z + 4, 0, true, true, false)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleCreate)
    script:sleep(1700);
    DeleteVehicle(vehicleCreate)
    end)
end

function is_player_in_interior(player_id, interior_id)
    local player_ped = PLAYER.GET_PLAYER_PED(player_id)
    local player_interior_id = INTERIOR.GET_INTERIOR_FROM_ENTITY(player_ped)
    return player_interior_id == interior_id
end

function teleport_too_blip(blipNum)
	local Pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(blipNum));
	if HUD.DOES_BLIP_EXIST(HUD.GET_FIRST_BLIP_INFO_ID(blipNum)) then
		PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), Pos.x, Pos.y, Pos.z + 4);
	end
end

function helpmarker(colorFlag, text, color) --Credits Xesdoog
    ImGui.SameLine()
    ImGui.TextDisabled("[?]")
    if ImGui.IsItemHovered() then
        ImGui.SetNextWindowBgAlpha(0.85)
        ImGui.BeginTooltip()
        if colorFlag == true then
            coloredText(text, color)
        else
            ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
            ImGui.TextWrapped(text)
            ImGui.PopTextWrapPos()
        end
        ImGui.EndTooltip()
end
end

function Load_interior(interior_id)
    STREAMING.REQUEST_IPL(interior_id)
    local is_loaded = STREAMING.IS_IPL_ACTIVE(interior_id)
    if is_loaded then
        gui.show_warning(LuaName, "Interior: " .. interior_id .. " Loaded successfully!")
    else
        gui.show_warning(LuaName, "Interior: " .. interior_id .. " Failed to Load!")
    end
end

function unload_interior(interior_id)
    STREAMING.REMOVE_IPL(interior_id)
    local is_UNloaded = not STREAMING.IS_IPL_ACTIVE(interior_id)
    if is_UNloaded then
        gui.show_warning(LuaName, "Interior: " .. interior_id .. " unloaded successfully!")
    else
        gui.show_warning(LuaName, "Interior: " .. interior_id .. " Failed to Load!")
    end
end

local function MPX() ---Credits L7NEG
	local PI = stats.get_int("MPPLY_LAST_MP_CHAR")
	if PI == 0 then
		return "MP0_"
	else
		return "MP1_"
	end
end

function run_script(name, Bit)
	script.run_in_fiber(function(runscript)
		SCRIPT.REQUEST_SCRIPT(name);
		repeat
			runscript:yield();
		until SCRIPT.HAS_SCRIPT_LOADED(name) 
		SYSTEM.START_NEW_SCRIPT(name, Bit);
		SCRIPT.SET_SCRIPT_AS_NO_LONGER_NEEDED(name);
	end);
end
------=========================================================================------
------=========================================================================------
------=========================================================================------

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
                local objectIdSpawned = OBJECT.CREATE_AMBIENT_PICKUP(pickup, coords.x, coords.y, coords.z + 2.2, 0, money_value, model, true, false)
                local net_id = NETWORK.OBJ_TO_NET(objectIdSpawned)
                NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(objectIdSpawned, true)
            end
            iconNotification("CHAR_DEFAULT", "CHAR_DEFAULT", true, 8, LuaName,
                "Dropping For: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()))
        end
    end)
end

function SCEdrop_function(EventHash, hash)
    local Value = hash
    local Eventnum = EventHash
    local HowManyThings = Value
    local player_id = network.get_selected_player()
    for i = 0, Value do
    network.trigger_script_event(1 << network.get_selected_player(), {968269233, network.get_selected_player(), 1, Eventnum, i, -3, 1, 1, 1, 1, 1, 1});
    iconNotification("CHAR_DEFAULT", "CHAR_DEFAULT", true, 8, LuaName, "Player: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .. " is Receiving The Drops")
    end
end


local SCEdropTypes = {
    ["Buried Stashes ($25,000 Per 1)"] = {Eventnum = 6, Value = 2}, -- Daily Collectable
    ["Treasure Chests ($25,000 Per 1)"] = {Eventnum = 2, Value = 2}, -- Daily Collectable
    ["Fast RP (Uses Circo Loco to give 1000 RP)"] = {Eventnum = 4, Value = 24},
    ["Shipwreck ($25,000)"] = {Eventnum = 5, Value = 1},-- Daily Collectable
    ["Junk Energy Skydives"] = {Eventnum = 10, Value = 10}, -- Collectable
    ["Jack O' Lanterns ($5,000 Per 1)"] = {Eventnum = 8, Value = 10}, -- Daily Collectable
    ["Radio Stations ($Random per 1)"] = {Eventnum = 3, Value = 10}, -- Daily Collectable
    ["Hidden Cache's ($10,000 Per 1)"] = {Eventnum = 1, Value = 10}, -- Daily Collectable
    ["LS Tags ($15,000 Per 1)"] = {Eventnum = 19, Value = 5}, -- Collectable
    ["Snowmen ($5,000 Per 1)"] = {Eventnum = 16, Value = 25}, -- Collectable
    ["Collect G's Cache"] = {Eventnum = 17, Value = 1}, -- Collectable
}


local dropTypes = {
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
            drop_function(dropInfo.model, dropInfo.pickup, 4, dropInfo.value)
            script:sleep(RPDropTime)
        end
    end)
end

PlayersTab:add_separator();
PlayersTab:add_text("TSE Drops");
for name, SCEdropInfo in pairs(SCEdropTypes) do
    local checkbox = PlayersTab:add_checkbox(name)
    script.register_looped(name, function(script)
        script:yield()
        if checkbox:is_enabled() then
            SCEdrop_function(SCEdropInfo.Eventnum, SCEdropInfo.Value)
        end
    end)
end

PlayersTab:add_separator();
PlayersTab:add_text("Toxic/Griefing");
PlayersTab:add_button("Fragment Crash", function()
    script.run_in_fiber(function(script)
        gui.show_message(LuaName, "Attempting to Crash: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .. "\nMethod: Fragment crash ");
        hash1 = joaat("prop_fragtest_cnst_04")
        hash2 = joaat("prop_fragtest_cnst_02")
        hash3 = joaat("prop_fragtest_cnst_08")
        for i = 0, 5 do 
            local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(network.get_selected_player()), false)
        local object = OBJECT.CREATE_OBJECT(hash1, coords.x, coords.y, coords.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        local object2 = OBJECT.CREATE_OBJECT(hash2, coords.x, coords.y, coords.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object2, 1, false)
        local object3 = OBJECT.CREATE_OBJECT(hash3, coords.x, coords.y, coords.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object3, 1, false)
        local object4 = OBJECT.CREATE_OBJECT(hash1, coords.x, coords.y, coords.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object4, 1, false)
        local object5 = OBJECT.CREATE_OBJECT(hash2, coords.x, coords.y, coords.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object5, 1, false)
        local object6 = OBJECT.CREATE_OBJECT(hash3, coords.x, coords.y, coords.z, true, false, false)
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object6, 1, false)
        script:sleep(200);
        DeleteObject(object)
        DeleteObject(object2)
        DeleteObject(object3)
        DeleteObject(object4)
        DeleteObject(object5)
        DeleteObject(object6)
        end
        log.warning("You attempted to crash: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .. " Crash Method: Fragment Crash");
    end)
end);

PlayersTab:add_button("Rage Shoot", function()
    script.run_in_fiber(function(script)
        ShootAt()
        end)
end);
PlayersTab:add_sameline();
local checkbox = PlayersTab:add_checkbox("Rage Shoot Loop")
script.register_looped("RageShoot", function(script)
    script:yield()
    if checkbox:is_enabled() then
        ShootAt()
        script:sleep(1);
    end
end)

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

AllPlayers:add_separator();
AllPlayers:add_text("Settings");
IncludeSelfALL = AllPlayers:add_checkbox("Include Self")
AllPlayers:add_separator();
local checkbox = AllPlayers:add_checkbox("Explode All (Anonymous)")
script.register_looped("Explode All", function(script)
    script:yield()
    if checkbox:is_enabled() then
        gui.show_message(LuaName, "Exploding All Players Repeatedly");
        for i = 0, 32 do
            Target = PLAYER.GET_PLAYER_PED(i)
            if IncludeSelfALL:is_enabled() then
                if (Target ~= PLAYER.PLAYER_PED_ID()) then
                local player_id = i;
                local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true);
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, explosionType, 100000, true, false, 0, false);
                GRAPHICS.USE_PARTICLE_FX_ASSET(explosionFx);
                GRAPHICS.START_PARTICLE_FX_NON_LOOPED_AT_COORD("explosion_barrel", coords.x, coords.y, coords.z, 0, 0, 0,
                    1, false, true, false);
                script:sleep(1);
                else
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
    end
end)
AllPlayers:add_sameline()
local checkbox = AllPlayers:add_checkbox("Ragdoll All")
script.register_looped("Ragdoll All", function(script)
    script:yield()
    if checkbox:is_enabled() then
        gui.show_message(LuaName, "Ragdolled all players");
        for i = 0, 32 do
            Target = PLAYER.GET_PLAYER_PED(i)
            if IncludeSelfALL:is_enabled() then
                if (Target ~= PLAYER.PLAYER_PED_ID()) then
                local player_id = i;
                local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true);
                coords.z = coords.z - 2;
                FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 100, false);
                script:sleep(1);
                else
                    local player_id = i;
                    local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true);
                    coords.z = coords.z - 2;
                    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 11, 1, false, true, 100, false);
                    script:sleep(1);
            end
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
            Target = PLAYER.GET_PLAYER_PED(i)
            if (Target ~= PLAYER.PLAYER_PED_ID()) then
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
            Target = PLAYER.GET_PLAYER_PED(i)
            if (Target ~= PLAYER.PLAYER_PED_ID()) then
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
            Target = PLAYER.GET_PLAYER_PED(i)
            if (Target ~= PLAYER.PLAYER_PED_ID()) then
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
            Target = PLAYER.GET_PLAYER_PED(i)
            if (Target ~= PLAYER.PLAYER_PED_ID()) then
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
            Target = PLAYER.GET_PLAYER_PED(i)
            if (Target ~= PLAYER.PLAYER_PED_ID()) then
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

MNDYPvP:add_separator();
MNDYPvP:add_text("Aim Assistance");
MNDYPvP:add_separator();
MNDYPvP:add_imgui(function()
    ImGui.PushItemWidth(100);
    selected_Triggermode = ImGui.Combo("Triggerbot Mode", selected_Triggermode, triggermode_names, 2, 15)
end)

Triggerbot = MNDYPvP:add_checkbox("Triggerbot")

script.register_looped("Triggerbot", function(script)
    script:yield()
    if Triggerbot:is_enabled() then
        if selected_Triggermode == 0 then
            local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
            local dp, Entity = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(Yourself, Entity)
            if dp then
                if ENTITY.IS_ENTITY_A_PED(Entity) and not PED.IS_PED_DEAD_OR_DYING(Entity, 0) and PED.IS_PED_A_PLAYER(Entity) then
                    ShootPlayer(Entity, math.random(0.0, 1))
            end
            end
        end
        if selected_Triggermode == 1 then
        local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
        local dp, Entity = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(Yourself, Entity)
        if dp then
            if ENTITY.IS_ENTITY_A_PED(Entity) and not PED.IS_PED_DEAD_OR_DYING(Entity, 0) and PED.IS_PED_A_PLAYER(Entity) and not PED.IS_PED_RAGDOLL(Entity) or PED.IS_PED_FALLING(Entity) then
                ShootPlayer(Entity, 0.63)
            end
            if ENTITY.IS_ENTITY_A_PED(Entity) and not PED.IS_PED_DEAD_OR_DYING(Entity, 0) and PED.IS_PED_A_PLAYER(Entity) and PED.IS_PED_RAGDOLL(Entity) or PED.IS_PED_FALLING(Entity) then
                ShootPlayer(Entity, 0)
            end
            if ENTITY.IS_ENTITY_A_PED(Entity) and not PED.IS_PED_DEAD_OR_DYING(Entity, 0) and PED.IS_PED_A_PLAYER(Entity) and PED.IS_PED_IN_ANY_VEHICLE(Entity) then
                ShootPlayer(Entity, 0)
            end
        end
        end
    end
end);
function ShootPlayer(PLAYER, height)
    script.run_in_fiber(function(script)
        script:yield()
    local head = PED.GET_PED_BONE_COORDS(PLAYER, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(PLAYER, 31086), 0, 0, 0)
    PED.SET_PED_SHOOTS_AT_COORD(Yourselfpedid, head.x, head.y, head.z+height, 1)
    gui.show_warning(LuaName, "Shooting")
end)
end

local checkbox = MNDYPvP:add_checkbox("Aimbot")
script.register_looped("Draw Lines", function(script)
    if checkbox:is_enabled() then
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                        if PLAYER.IS_PLAYER_FREE_AIMING(Yourself) then
                            local TargetPed = PLAYER.GET_PLAYER_PED(i);
                            local TargetPos = ENTITY.GET_ENTITY_COORDS(TargetPed)
                            local Exist = ENTITY.DOES_ENTITY_EXIST(TargetPed)
                            local Dead = PLAYER.IS_PLAYER_DEAD(TargetPed)
                
                            if Exist and not Dead then
                                local OnScreen, ScreenX, ScreenY = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(TargetPos.x, TargetPos.y, TargetPos.z, 0)
                                if ENTITY.IS_ENTITY_VISIBLE(TargetPed) then
                                    if OnScreen then
                                        local TargetCoords = PED.GET_PED_BONE_COORDS(TargetPed, 0, 0, 0, 0)
                                        PED.SET_PED_SHOOTS_AT_COORD(PLAYER.PLAYER_PED_ID(), TargetCoords.x, TargetCoords.y, TargetCoords.z, 1)
                            end
                        end
                    end
                end
            end
        end
    end
end);


MNDYPvP:add_separator();
MNDYPvP:add_text("Visual Assistance");
MNDYPvP:add_separator();
local checkbox = MNDYPvP:add_checkbox("Draw Lines")
script.register_looped("Draw Lines", function(script)
    if checkbox:is_enabled() then
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                local target = PLAYER.GET_PLAYER_PED(player_id)
                local target1 = PLAYER.GET_PLAYER_PED(-1)
                if target ~= PLAYER.PLAYER_PED_ID() then
                local pos = ENTITY.GET_ENTITY_COORDS(target)
                local pos1 = ENTITY.GET_ENTITY_COORDS(target1)
                if PED.IS_PED_IN_ANY_VEHICLE(target1) then 
                    GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, pos1.x, pos1.y, pos1.z+6.7, 0, 255, 50, 255)
                else
                    GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, pos1.x, pos1.y, pos1.z+2.7, 0, 255, 50, 255)
                    end
                end
            end
        end
    end
end);
local checkbox = MNDYPvP:add_checkbox("Draw Box")
MNDYPvP:add_sameline();
local Healthbox = MNDYPvP:add_checkbox("Health")
MNDYPvP:add_sameline();
local Armourbox = MNDYPvP:add_checkbox("Armour")
script.register_looped("Draw Box", function(script)
    if NETWORK.NETWORK_IS_IN_SESSION() == true then
        if checkbox:is_enabled() then
            Camcoords = CAM.GET_GAMEPLAY_CAM_COORD()
            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true)
            for i = 0, 32 do
                    local Target = PLAYER.GET_PLAYER_PED(i)
                    local target1 = PLAYER.GET_PLAYER_PED(-1)
                    bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(Target, 31086)
                    pos = PED.GET_PED_BONE_COORDS(Target, bone, 0.0, 0.0, 0.9)
                    pos2 = ENTITY.GET_ENTITY_COORDS(target1)
				if MISC.GET_DISTANCE_BETWEEN_COORDS(pos.x, pos.y, pos.z, Camcoords.x,Camcoords.y,Camcoords.z, true) < 1000 then
					if Target ~= PLAYER.PLAYER_PED_ID() and  ENTITY.IS_ENTITY_ON_SCREEN(Target) and not PED.IS_PED_DEAD_OR_DYING(Target) then
                    
						local Distance = MISC.GET_DISTANCE_BETWEEN_COORDS(pos.x,pos.y,pos.z, Camcoords.x,Camcoords.y,Camcoords.z, true) * 0.002 / 2
	
						retval, _x, _y = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x,pos.y,pos.z)
	
                        width = 0.00045
						height = 0.0023
	
                        GRAPHICS.DRAW_RECT(_x, _y, width / Distance, 0.0015, 0, 0, 255, 200)
						GRAPHICS.DRAW_RECT(_x, _y + height / Distance, width / Distance, 0.0015, 0, 0, 255, 200)
						GRAPHICS.DRAW_RECT(_x + width / 2 / Distance, _y + height / 2 / Distance , 0.001, height / Distance, 0, 0, 255, 200)
						GRAPHICS.DRAW_RECT(_x - width / 2 / Distance, _y + height / 2 / Distance , 0.001, height / Distance, 0, 0, 255, 200)
                        DrawText(PLAYER.GET_PLAYER_NAME(i), _x+0.007, _y, 0.2, 0.2)
                        if Healthbox:is_enabled() then
                        DrawText("Health: "..ENTITY.GET_ENTITY_HEALTH(Target), _x+0.007, _y + 0.01, 0.2, 0.2)
                        end
                        if Armourbox:is_enabled() then
                        DrawText("Armour: "..PED.GET_PED_ARMOUR(Target), _x+0.007, _y + 0.02, 0.2, 0.2)
                        end
                    end
                end
            end 
        end
    end
end);

local SkeletonBox = MNDYPvP:add_checkbox("Skeleton")
script.register_looped("SkeletonBox", function(script)
    if NETWORK.NETWORK_IS_IN_SESSION() == true then
    if SkeletonBox:is_enabled() then
        Camcoords = CAM.GET_GAMEPLAY_CAM_COORD()
        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true)
        for i = 0, 32 do
                    ped = PLAYER.GET_PLAYER_PED(i)
                    target1 = PLAYER.GET_PLAYER_PED(-1)
                    pos = ENTITY.GET_ENTITY_COORDS(ped)
                    pos2 = ENTITY.GET_ENTITY_COORDS(target1)
                    if ENTITY.DOES_ENTITY_EXIST(ped) and ped ~= PLAYER.PLAYER_PED_ID() then
                        ENTITY.SET_ENTITY_ALPHA(ped, 210, false)
                    
                        if MISC.GET_DISTANCE_BETWEEN_COORDS(pos2.x, pos2.y, pos2.z, pos.x,pos.y,pos.z, true) < 1000 then
                            local LineOneBegin = PED.GET_PED_BONE_COORDS(ped, 0, 0.0, 0.0, 0.0)
                            local LineOneEnd = PED.GET_PED_BONE_COORDS(ped, 39317, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_LINE(LineOneBegin.x, LineOneBegin.y, LineOneBegin.z, LineOneEnd.x, LineOneEnd.y, LineOneEnd.z, 0, 255, 0, 255)
                            local LineTwoStart = PED.GET_PED_BONE_COORDS(ped, 39317, 0.0, 0.0, 0.0)
                            local LineTwoEnd = PED.GET_PED_BONE_COORDS(ped, 31086, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_MARKER(28, LineTwoEnd, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0, 0, 255, 255)
                            GRAPHICS.DRAW_LINE(LineTwoStart.x, LineTwoStart.y, LineTwoStart.z, LineTwoEnd.x, LineTwoEnd.y, LineTwoEnd.z,0, 255, 0, 255)
                            local LineThreeStart = PED.GET_PED_BONE_COORDS(ped, 22711, 0.0, 0.0, 0.0)
                            local LineThreeEnd = PED.GET_PED_BONE_COORDS(ped, 39317, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_LINE(LineThreeStart.x, LineThreeStart.y, LineThreeStart.z, LineThreeEnd.x, LineThreeEnd.y, LineThreeEnd.z,0, 255, 0, 255)
                            local LineFourStart = PED.GET_PED_BONE_COORDS(ped, 22711, 0.0, 0.0, 0.0)
                            local LineFourEnd = PED.GET_PED_BONE_COORDS(ped, 18905, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_LINE(LineFourStart.x, LineFourStart.y, LineFourStart.z, LineFourEnd.x, LineFourEnd.y, LineFourEnd.z,0, 255, 0, 255)
                            local LineFiveStart = PED.GET_PED_BONE_COORDS(ped, 2992, 0.0, 0.0, 0.0)
                            local LineFiveEnd = PED.GET_PED_BONE_COORDS(ped, 39317, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_LINE(LineFiveStart.x, LineFiveStart.y, LineFiveStart.z, LineFiveEnd.x, LineFiveEnd.y, LineFiveEnd.z,0, 255, 0, 255)
                            local LineSixStart = PED.GET_PED_BONE_COORDS(ped, 2992, 0.0, 0.0, 0.0)
                            local LineSixEnd = PED.GET_PED_BONE_COORDS(ped, 57005, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_LINE(LineSixStart.x, LineSixStart.y, LineSixStart.z, LineSixEnd.x, LineSixEnd.y, LineSixEnd.z,0, 255, 0, 255)
                            local LineSevenStart = PED.GET_PED_BONE_COORDS(ped, 0, 0.0, 0.0, 0.0)
                            local LineSevenEnd = PED.GET_PED_BONE_COORDS(ped, 16335, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_LINE(LineSevenStart.x, LineSevenStart.y, LineSevenStart.z, LineSevenEnd.x, LineSevenEnd.y, LineSevenEnd.z,0, 255, 0, 255)
                            local LineEightStart = PED.GET_PED_BONE_COORDS(ped, 0, 0.0, 0.0, 0.0)
                            local LineEightEnd = PED.GET_PED_BONE_COORDS(ped, 46078, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_LINE(LineEightStart.x, LineEightStart.y, LineEightStart.z, LineEightEnd.x, LineEightEnd.y, LineEightEnd.z,0, 255, 0, 255)
                            local LineNineStart = PED.GET_PED_BONE_COORDS(ped, 52301, 0.0, 0.0, 0.0)
                            local LineNineEnd = PED.GET_PED_BONE_COORDS(ped, 16335, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_LINE(LineNineStart.x, LineNineStart.y, LineNineStart.z, LineNineEnd.x, LineNineEnd.y, LineNineEnd.z,0, 255, 0, 255)
                            local LineTenStart = PED.GET_PED_BONE_COORDS(ped, 14201, 0.0, 0.0, 0.0)
                            local LineTenEnd = PED.GET_PED_BONE_COORDS(ped, 46078, 0.0, 0.0, 0.0)
                            GRAPHICS.DRAW_LINE(LineTenStart.x, LineTenStart.y, LineTenStart.z, LineTenEnd.x, LineTenEnd.y, LineTenEnd.z,0, 255, 0, 255)
            end 
        end
    end
end
end
end);

MNDYPvP:add_separator();
MNDYPvP:add_text("Movement Assistance");
MNDYPvP:add_separator();
MNDYPvP:add_imgui(function()
    InfinateRoll, InfinateRollChanged = ImGui.Checkbox("Infinate Roll", InfinateRoll);
    helpmarker(false, "Removes Roll wait and allows to be triggerd instantly")
    script.run_in_fiber(function(script)
    if InfinateRollChanged then
        while InfinateRoll do 
            script:sleep(0);
            for i = 0, 32 do
                STATS.STAT_SET_INT(joaat("mp".. i .. "_shooting_ability"), 190, true);
    end
end
end
end)
end)
MNDYPvP:add_imgui(function()
    BugRoll, BugRollChanged = ImGui.Checkbox("Bug Roll", BugRoll);
    helpmarker(false, "Telports you Randomly at a short distance and cancel's your roll")
    script.run_in_fiber(function(script)
    if BugRollChanged then
        while BugRoll do 
            script:sleep(0);
            if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) and PAD.IS_CONTROL_PRESSED(0, 22) then
                gui.show_warning(LuaName, "Executed Bug Roll")
                script:sleep(500);
                CurrentCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
                ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()),CurrentCoords.x+math.random(-4, 4), CurrentCoords.y+math.random(-2, 2), CurrentCoords.z- 1.0, false, false, true, true);
    end
end
end
end)
end)



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
MenuImGui:add_sameline();
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
                    script:sleep(200)
                    PLAYER.GIVE_ACHIEVEMENT_TO_PLAYER(i);
                if i == 77 then
                    gui.show_message("Achivements", "Unlocked 77 Achivements")
                end
            end
        end)
    end)
MenuImGui:add_button("Fill Snacks", function()
    gui.show_message(LuaName, "Snacks Filled");
    STATS.STAT_SET_INT(joaat(MPX() .. "NO_BOUGHT_YUM_SNACKS"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX() .. "NO_BOUGHT_HEALTH_SNACKS"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX() .. "NO_BOUGHT_EPIC_SNACKS"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_CHAMP_BOUGHT"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_ORANGE_BOUGHT"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_BOURGE_BOUGHT"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_SPRUNK_BOUGHT"), 25, true);
    STATS.STAT_SET_INT(joaat(MPX() .. "CIGARETTES_BOUGHT"), 25, true);
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
MenuImGui:add_button("Give 9999x Snacks", function()
    script.run_in_fiber(function(script)
        gui.show_message(LuaName, "Snacks given");
        STATS.STAT_SET_INT(joaat(MPX() .. "NO_BOUGHT_YUM_SNACKS"), 9999, true);
        STATS.STAT_SET_INT(joaat(MPX() .. "NO_BOUGHT_HEALTH_SNACKS"), 9999, true);
        STATS.STAT_SET_INT(joaat(MPX() .. "NO_BOUGHT_EPIC_SNACKS"), 9999, true);
        STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_CHAMP_BOUGHT"), 9999, true);
        STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_ORANGE_BOUGHT"), 9999, true);
        STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_BOURGE_BOUGHT"), 9999, true);
        STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_SPRUNK_BOUGHT"), 9999, true);
        STATS.STAT_SET_INT(joaat(MPX() .. "CIGARETTES_BOUGHT"), 9999, true);
end)
end);
MenuImGui:add_imgui(function()
    --ImGui.PushItemWidth(110);
    if ImGui.Button("Remove Orbital Cooldown") then
        STATS.STAT_SET_INT(joaat(MPX() .. "ORBITAL_CANNON_COOLDOWN"), 0, true);
        iconNotification("CHAR_LESTER", "CHAR_LESTER", true, 1, LuaName, "Cooldown Removed");
    end
    helpmarker(false, "Removes Cooldown to instantly Fire again")
end)
MenuImGui:add_separator();
MenuImGui:add_text("Computers");
MenuImGui:add_separator();
MenuImGui:add_button("Nightclub", function()
    script.run_in_fiber(function (script)
        run_script("appBusinessHub", 1424)
    end)
end)
MenuImGui:add_sameline();
MenuImGui:add_button("Bail Office", function()
    script.run_in_fiber(function (script)
        script:sleep(600)
        run_script("appBailOffice", 4592)
    end)
end)

MenuImGui:add_sameline();
MenuImGui:add_button("Master Control Terminal", function()
    script.run_in_fiber(function (script)
        run_script("appArcadeBusinessHub", 1424)
    end)
end)

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


SafeRefill = NightClubMNDY:add_checkbox("Auto Refil Safe")
script.register_looped("Auto Refill Safe", function(script)
    script:yield()
    if SafeRefill:is_enabled() == true then
        STATS.STAT_SET_INT(joaat(MPX() .. "CLUB_POPULARITY"), 1000, true);
        script:sleep(300)
        STATS.STAT_SET_INT(joaat(MPX() .. "CLUB_PAY_TIME_LEFT"), -1, true)
        script:sleep(2200)
    end
end)
NightClubMNDY:add_button("Refill Nightclub Popularity", function()
    script.run_in_fiber(function(script)
        STATS.STAT_SET_INT(joaat(MPX() .. "CLUB_POPULARITY"), 1000, true);
        gui.show_warning(LuaName, "Popularity set too 100%")
    end)
end);
NightClubMNDY:add_sameline();
NightClubMNDY:add_button("Teleport to Safe", function()
    script.run_in_fiber(function(script)
        if is_player_in_interior(PLAYER.PLAYER_ID(), 271617) then
        ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()),-1616.16, -3015.138, -74.205, false, false, true, true);
        else
            gui.show_warning(LuaName, "Not inside Nightclub")
        end
    end)
end);



NightClubMNDY:add_separator();
NightClubMNDY:add_text("Stats");
NightClubMNDY:add_separator();
DisplayNClubStats = NightClubMNDY:add_checkbox("Display Stats")
script.register_looped("Display Stats", function(script)
    script:yield()
    if DisplayNClubStats:is_enabled() == true then
        ShowStats = true
    else 
        ShowStats = false
    end
end)

NightClubMNDY:add_imgui(function()
    if ShowStats == true then
    local cashSupply   = stats.get_int(MPX().."CLUB_SAFE_CASH_VALUE")
    local NightClubEarnings   = stats.get_int(MPX().."NIGHTCLUB_EARNINGS")
    local PopularitySupply   = stats.get_int(MPX().."CLUB_POPULARITY")
    local CLUBTimeLeft   = stats.get_int(MPX().."CLUB_PAY_TIME_LEFT")
    ImGui.Text("Current Popularity: "..(PopularitySupply/10).."/100%")
    ImGui.Text("Current Safe Amount: "..formatMoney(cashSupply))
    ImGui.Text("Earnings: "..formatMoney(NightClubEarnings))
    ImGui.Text("Time Till Next Pay: "..CLUBTimeLeft) 
    end
end)


recoveryTab2:add_text("ONLY YOU ARE RESPONSABLE FOR USING THESE OPTIONS!");
local MNYDMoney = {
    ["5k Chips"] = { globalnum = 1964419, Num2 = 1, ConsoleDisplay = "Given 5K Chips" },
    ["50k"] = { hash = 1628412596, value = 50000, ConsoleDisplay = "SERVICE_EARN_YOHAN_SOURCE_GOODS" },
    ["180k"] = { hash = 0x615762F1, value = 180000, ConsoleDisplay = "0x615762F1" },
}
for name, MNYDmonInfo in pairs(MNYDMoney) do
    local checkbox = recoveryTab2:add_checkbox(name)
    script.register_looped(name, function(script)
        script:yield()
        if checkbox:is_enabled() then
            MoneyTransactions(MNYDmonInfo.hash, MNYDmonInfo.value)
            GlobalInt(MNYDmonInfo.globalnum, MNYDmonInfo.Num2)
            log.debug("Current Joaat: " .. name .. " " .. MNYDmonInfo.ConsoleDisplay .. " ")
            script:sleep(MNYDQuckCashTime)
        end
    end)
end
recoveryTab2:add_imgui(function()
    if ImGui.BeginChildFrame(80, 650, 80, ImGuiWindowFlags.NoBackground) then
        ImGui.TextColored(1, 0, 0, 1, "Riskier Options");
        if ImGui.Button("15 Million") then
            MoneyTransactions(joaat("SERVICE_EARN_JOB_BONUS"), 15000000)
        end
        ImGui.EndChildFrame();
    end
end)

MNDYDebug:add_imgui(function()
    playerlocation = ENTITY.GET_ENTITY_COORDS(Yourselfpedid)
    ImGui.Text("Location: "..playerlocation.x.. " ".. playerlocation.y.." "..playerlocation.z)
end)

MNDYDebug:add_button("Get Interior ID", function()
    script.run_in_fiber(function(script)
        local player_interior_id = INTERIOR.GET_INTERIOR_FROM_ENTITY(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()))
        gui.show_warning(LuaName, "ID:"..player_interior_id)
    end)
end);

MNDYDebug:add_button("Reset Collectables", function()
    script.run_in_fiber(function(script)
        set_daily_collectibles_state(false)
        gui.show_warning(LuaName, "Switching Sessions")
        script:sleep(800);
        globals.set_int(1574589, 1)
        script:sleep(300);
        globals.set_int(1574589, 0)
    end)
end);

function set_daily_collectibles_state(state) -- Credit ShinyWasabi
        stats.set_packed_stat_bool(36628, state) -- G's Cache
        stats.set_packed_stat_bool(36657, state) -- Stash House
        stats.set_packed_stat_bool(31734, state) -- Shipwreck
        stats.set_packed_stat_bool(30297, state) -- Hidden Cache 1
        stats.set_packed_stat_bool(30298, state) -- Hidden Cache 2
        stats.set_packed_stat_bool(30299, state) -- Hidden Cache 3
        stats.set_packed_stat_bool(30300, state) -- Hidden Cache 4
        stats.set_packed_stat_bool(30301, state) -- Hidden Cache 5
        stats.set_packed_stat_bool(30302, state) -- Hidden Cache 6
        stats.set_packed_stat_bool(30303, state) -- Hidden Cache 7
        stats.set_packed_stat_bool(30304, state) -- Hidden Cache 8
        stats.set_packed_stat_bool(30305, state) -- Hidden Cache 9
        stats.set_packed_stat_bool(30306, state) -- Hidden Cache 10
        stats.set_packed_stat_bool(30307, state) -- Treasure Chest 1
        stats.set_packed_stat_bool(30308, state) -- Treasure Chest 2
        stats.set_packed_stat_bool(25522, state) -- Buried Stash 1
        stats.set_packed_stat_bool(25523, state) -- Buried Stash 2
        stats.set_packed_stat_bool(42252, state) -- LS Tag 1
        stats.set_packed_stat_bool(42253, state) -- LS Tag 2
        stats.set_packed_stat_bool(42254, state) -- LS Tag 3
        stats.set_packed_stat_bool(42255, state) -- LS Tag 4
        stats.set_packed_stat_bool(42256, state) -- LS Tag 5
        stats.set_packed_stat_bool(42269, state) -- Madrazo Hit
        stats.set_packed_stat_bool(42059, state) -- Shoot Animals Photography 1
        stats.set_packed_stat_bool(42060, state) -- Shoot Animals Photography 2
        stats.set_packed_stat_bool(42061, state) -- Shoot Animals Photography 3

-- Movie Props:
        stats.set_packed_stat_bool(30230, state)
        stats.set_packed_stat_bool(30231, state)
        stats.set_packed_stat_bool(30232, state)
        stats.set_packed_stat_bool(30233, state)
        stats.set_packed_stat_bool(30234, state) 
        stats.set_packed_stat_bool(30235, state)
        stats.set_packed_stat_bool(30236, state) 
        stats.set_packed_stat_bool(30237, state) 
        stats.set_packed_stat_bool(30238, state) 
        stats.set_packed_stat_bool(30239, state)


-- Signal Jammers
        stats.set_packed_stat_bool(28099, state)
        stats.set_packed_stat_bool(28100, state)
        stats.set_packed_stat_bool(28101, state)
        stats.set_packed_stat_bool(28102, state)
        stats.set_packed_stat_bool(28103, state) 
        stats.set_packed_stat_bool(28104, state)
        stats.set_packed_stat_bool(28105, state) 
        stats.set_packed_stat_bool(28106, state) 
        stats.set_packed_stat_bool(28107, state) 
        stats.set_packed_stat_bool(28108, state)
        stats.set_packed_stat_bool(28109, state)
        stats.set_packed_stat_bool(28110, state)
        stats.set_packed_stat_bool(28111, state)
        stats.set_packed_stat_bool(28112, state)
        stats.set_packed_stat_bool(28113, state) 
        stats.set_packed_stat_bool(28114, state)
        stats.set_packed_stat_bool(28115, state) 
        stats.set_packed_stat_bool(28116, state) 
        stats.set_packed_stat_bool(28117, state) 
        stats.set_packed_stat_bool(28118, state)
        stats.set_packed_stat_bool(28019, state)
        stats.set_packed_stat_bool(28120, state)
        stats.set_packed_stat_bool(28121, state)
        stats.set_packed_stat_bool(28122, state)
        stats.set_packed_stat_bool(28123, state) 
        stats.set_packed_stat_bool(28124, state)
        stats.set_packed_stat_bool(28125, state) 
        stats.set_packed_stat_bool(28126, state) 
        stats.set_packed_stat_bool(28127, state) 
        stats.set_packed_stat_bool(28128, state)
        stats.set_packed_stat_bool(28129, state) 
        stats.set_packed_stat_bool(28130, state)
        stats.set_packed_stat_bool(28131, state)
        stats.set_packed_stat_bool(28132, state)
        stats.set_packed_stat_bool(28133, state) 
        stats.set_packed_stat_bool(28134, state)
        stats.set_packed_stat_bool(28135, state) 
        stats.set_packed_stat_bool(28136, state) 
        stats.set_packed_stat_bool(28137, state) 
        stats.set_packed_stat_bool(28138, state)
        stats.set_packed_stat_bool(28039, state)
        stats.set_packed_stat_bool(28140, state)
        stats.set_packed_stat_bool(28141, state)
        stats.set_packed_stat_bool(28142, state)
        stats.set_packed_stat_bool(28143, state) 
        stats.set_packed_stat_bool(28144, state)
        stats.set_packed_stat_bool(28145, state) 
        stats.set_packed_stat_bool(28146, state) 
        stats.set_packed_stat_bool(28147, state) 
        stats.set_packed_stat_bool(28148, state)
    end

script.register_looped("tick", function(script)
if DebugInfo then
    DrawText("~HUD_COLOUR_DEGEN_GREEN~~h~ MNDY Version: 1.69", 0.28, 0.00, 0.0, 0.2000)
    DrawText("~HUD_COLOUR_DEGEN_GREEN~~h~ Build: 22/07/24 ", 0.28, 0.012, 0.0, 0.2000)
end
    end)
------=========================================================================------
------===============================Credits===================================------
------=========================================================================------

-- GSTX (gustavin)
-- Recoil
-- Gir489returns ( For bit sizes on computers)