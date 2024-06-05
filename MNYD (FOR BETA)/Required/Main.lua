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

function SCEdrop_function(hash, EventHash, value)
    local SCEHash = hash
    local Eventnum = EventHash
    local HowManyThings = value
    local player_id = network.get_selected_player()
    network.trigger_script_event(player_id, {SCEHash,player_id,1,Eventnum,100,-3,1,1,1});
        iconNotification("CHAR_DEFAULT", "CHAR_DEFAULT", true, 8, LuaName, "Player: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .." is Searching")
end


local SCEdropTypes = {
    ["Buried Stashes"] = {SCEHash = 968269233, Eventnum = 6},
    ["Treasure Chests"] = {SCEHash = 968269233, Eventnum = 2},
    ["Circo Loco"] = {SCEHash = 968269233, Eventnum = 4},
}


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
MenuImGui:add_imgui(function()
    ImGui.PushItemWidth(190);
    Watermark_Features = ImGui.Combo("Watermark Names", Watermark_Features, Watermark_Featnames, Watermark_FeatnamesAmmount, 15)
    Watermark, isWaterMarkChanged = ImGui.Checkbox("Watermark", Watermark);
    script.run_in_fiber(function(script)
        if isWaterMarkChanged then
            while Watermark do
                local localply = PLAYER.PLAYER_ID();
                local function GetPlayerCount()
                    return PLAYER.GET_NUMBER_OF_PLAYERS();
                end
                for i = 0, 32 do
                    if (i ~= localPlayerId) then
                        local player_id = i;
                        local ply_name = NETWORK.NETWORK_GET_HOST_PLAYER_INDEX(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id));
                        offset = {x=0.6,y=0.001}; 
                        HUD.SET_TEXT_FONT(0);
                        HUD.SET_TEXT_SCALE(0.25, 0.25);
                        HUD.SET_TEXT_CENTRE(false);
                        HUD.SET_TEXT_DROPSHADOW(2, 2, 0, 0, 0);
                        HUD.SET_TEXT_EDGE(1, 0, 0, 0, 205);
                        HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING");
                        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("~ws~"..Watermark_Featnames[Watermark_Features + 1].. " | Welcome: " .. PLAYER.GET_PLAYER_NAME(localply) .. " | Players: " .. GetPlayerCount() .. " | Host: " .. PLAYER.GET_PLAYER_NAME(ply_name) .. " | ScriptHost: " .. ScriptHostName() .. " ");
                        GRAPHICS.DRAW_RECT(offset.x + 0.187, offset.y, 0.39, 0.049, 0, 0, 0, 125, 0);
                        HUD.END_TEXT_COMMAND_DISPLAY_TEXT(offset.x, offset.y);
                        script:sleep(0);

                    end
                end
            end
        end
        end)
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
    gui.show_warning(LuaName, "Transfering $" ..TransferBank.. " To your bank")
    script:sleep(1000)
    NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(stats.get_character_index(), TransferBank)
    log.debug(TransferBank)
        end
        if selected_TransactionMethod == 1 then
            gui.show_warning(LuaName, "Transfering $" ..TransferBank.. " To your wallet")
            script:sleep(1000)
            NETSHOPPING.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(stats.get_character_index(), TransferBank)
            log.debug(TransferBank)
         end
    end)
end);
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


recoveryTab2:add_text("                                                 MNYD Quick Cash (ONLY YOU ARE RESPONSABLE FOR USING THESE OPTIONS!)");
local MNYDMoney = {
	["5k Chips"] = { globalnum = 1963515, Num2 = 1, ConsoleDisplay = "Given 5K Chips"},
    ["5Ok"] = {hash = joaat(FIFTYKJoaats[math.random(#FIFTYKJoaats)]), value = 50000, ConsoleDisplay = FIFTYKJoaats[math.random(#FIFTYKJoaats)]},
    ["250k"] = {hash = joaat(twohundredkJoaats[math.random(#twohundredkJoaats)]), value = 250000, ConsoleDisplay = twohundredkJoaats[math.random(#twohundredkJoaats)]},
    ["1m (Hash)"] = {hash = joaat(onemhash1), value = 1000000, ConsoleDisplay = onemhash1},
    ["1m (Global)"] = {hash = 1633116913, value = 1000000, ConsoleDisplay = 1633116913},
}
for name, MNYDmonInfo in pairs(MNYDMoney) do
    local checkbox = recoveryTab2:add_checkbox(name)
    script.register_looped(name, function(script)
        script:yield()
        if checkbox:is_enabled() then
            MNYDJJDU837KLSLLMNMNKUIEU8U14(MNYDmonInfo.hash, MNYDmonInfo.value)
            GlobalInt(MNYDmonInfo.globalnum, MNYDmonInfo.Num2)
            log.debug("Current Joaat: " ..name.." " ..MNYDmonInfo.ConsoleDisplay.. " ")
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