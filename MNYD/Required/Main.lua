require("Required/Locals")



PlayersTab:add_text("                                                                                                           MNDY Player Options");
PlayersTab:add_text("                                                                                                                Money/RP Drops");

function drop_function(modelhash, pickupHash, amount,value)
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
        iconNotification("CHAR_DEFAULT", "CHAR_DEFAULT", true, 8, LuaName, "Dropping For: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()))
    end
end

 --PROP_MONEY_PAPERCASE_01 -1803909274
 --PROP_MONEY_PAPERBAG_01 -1666779307
 --PROP_MONEY_BAG_01 0x113FD533
 --PICKUP_MONEY_CASE 0x1E9A99F8 

 local dropTypes = {
    ["2k Drop"] = {model = joaat("prop_money_bag_01"), pickup = joaat("PICKUP_MONEY_CASE"), value = 2500},
    ["2k Drop (2)"] = {model = 1203231469, pickup = joaat("PICKUP_MONEY_MED_BAG"), value = 10000},
    ["Monkey Collectable"] = {model = joaat("vw_prop_vw_colle_pogo"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0},
    ["Beasts Collectable"] = {model = joaat("vw_prop_vw_colle_beast"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0},
    ["Impotent Rage Collectable"] = {model = joaat("vw_prop_vw_colle_imporage"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0},
    ["Sasquatch Collectable"] = {model = joaat("vw_prop_vw_colle_sasquatch"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0},
    ["Bubblegum Collectable"] = {model = joaat("vw_prop_vw_colle_prbubble"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0},
    ["RSR Collectable"] = {model = joaat("vw_prop_vw_colle_rsrcomm"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0},
    ["Drop Cards"] = {model = joaat("vw_prop_vw_lux_card_01a"), pickup = joaat("PICKUP_CUSTOM_SCRIPT"), value = 0}
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
PlayersTab:add_text("                                                                                                                     SCE Drops");

BuriedStashes = PlayersTab:add_checkbox("Buried Stashes"); --WIP
script.register_looped("BuriedStashes", function(script)
	script:yield();
	if (BuriedStashes:is_enabled() == true) then
		local player_id = network.get_selected_player()
		local targetPlayerId = 1 << player_id;
		network.trigger_script_event(player_id, {968269233,player_id,1,6,1,-5,1,1,1});
		script:sleep(wait);
		network.trigger_script_event(player_id, {968269233,player_id,1,6,2,-5,1,1,1});
		script:sleep(wait);
		gui.show_message(LuaName, "Player: " .. PLAYER.GET_PLAYER_NAME(player_id) .. " Found Buried Stashes");
	end
end);