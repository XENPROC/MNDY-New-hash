LuaName = "MNDY";
gui.show_message("NewWay", LuaName .. " Loaded");
BadSportCombo = 0;
Transaction_names = {"Bank","Wallet"};
selected_TransactionMethod = 0;
TransferBank = 0;
value = 1;
textint = "";
textFloat = "";
textbool = "";
Statamount = 0;
Statamountfloat = 0;
Selectedbool = 0;
triggermode_names = {"Realistic","Unreal"};
Stattrueorfalse = {"false","true"}
selected_Triggermode = 0;
Watermark_Featnames = {"MNYD","NewWayMenu.vip","NewWay"};
Watermark_FeatnamesAmmount = 3;
Watermark_Features = 0;
AllPlayers = gui.add_tab("MNDY All Players")

---TSE NUMBERS---
CAR_INSURANCE = 1655503526
SEND_BASIC_TEXT = -1773335296
CREATE_FMC_INVITE = 606464409
INVITE_TO_APARTMENT = 996099702
SKYDIVING_ALL_JUMPS_GOLD = -1235428989
SKYDIVING_ALL_JUMPS_COMPLETED = -347033775
SKYDIVING_JUMP_COMPLETED = 1916113629
COLLECTIBLE_COLLECTED = 968269233
LEAVE_VEHICLE = -503325966
BOSS_SHOULD_LAUNCH_WVM = 259469385





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

local function MPX()
	local PI = stats.get_int("MPPLY_LAST_MP_CHAR");
	if (PI == 0) then
		return "MP0_";
	else
		return "MP1_";
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
    for i = 0, Value do
    network.trigger_script_event(1 << network.get_selected_player(), {968269233, network.get_selected_player(), 1, Eventnum, i, -3, 1, 1, 1, 1, 1, 1});
    iconNotification("CHAR_DEFAULT", "CHAR_DEFAULT", true, 8, LuaName, "Player: " .. PLAYER.GET_PLAYER_NAME(network.get_selected_player()) .. " is Receiving The Drops")
    end
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

function FlingVehicle()
    local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
    script.run_in_fiber(function(script)
        if ForceControl(PED.GET_VEHICLE_PED_IS_USING(player_id)) then
            ENTITY.SET_ENTITY_VELOCITY(PED.GET_VEHICLE_PED_IS_USING(player_id), 0, 0, -180);
			VEHICLE.SET_VEHICLE_FORWARD_SPEED(PED.GET_VEHICLE_PED_IS_USING(player_id), math.random(-10000, 10000))
			ENTITY.APPLY_FORCE_TO_ENTITY(PED.GET_VEHICLE_PED_IS_USING(player_id), 3, math.random(-4, 4), math.random(-4, 4), math.random(-80, 60), 0, 0, 0, true, true)
		end
    end)
end

function FakeVehicleDestory()
    local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
    script.run_in_fiber(function(script)
		network.trigger_script_event(1 << network.get_selected_player(), {1655503526, network.get_selected_player(), 1, 999999999});
    end)
end

function FOrceRandomMission()
    local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
    script.run_in_fiber(function(script)
		network.trigger_script_event(1 << network.get_selected_player(), {259469385, network.get_selected_player(), 1, math.random(0, 7)});
    end)
end

function helpmarker(colorFlag, text, color)
	ImGui.SameLine();
	ImGui.TextDisabled("[?]");
	if ImGui.IsItemHovered() then
		ImGui.SetNextWindowBgAlpha(0.85);
		ImGui.BeginTooltip();
		if (colorFlag == true) then
			coloredText(text, color);
		else
			ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20);
			ImGui.TextWrapped(text);
			ImGui.PopTextWrapPos();
		end
		ImGui.EndTooltip();
	end
end

function GetPlayerCount()
	return PLAYER.GET_NUMBER_OF_PLAYERS();
end

function GetHost()
	for i = 0, 32 do
		if (i ~= localPlayerId) then
			local player_id = i;
			return NETWORK.NETWORK_GET_HOST_PLAYER_INDEX(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id));
		end
	end
end

function formatMoney(value)
    return "$"..tostring(value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
  end

function GlobalInt(address, value)
	globals.set_int(address, value);
end

function SET_BIT(address, offset)
	MISC.SET_BIT(address, offset);
end

function ForceControl(entity)
	return entities.take_control_of(entity);
end

function DrawText(I, x, y, scale1, scale2)
	HUD.SET_TEXT_FONT(0);
	HUD.SET_TEXT_PROPORTIONAL(1);
	HUD.SET_TEXT_SCALE(scale1, scale2);
	HUD.SET_TEXT_DROPSHADOW(1, 0, 0, 0, 255);
	HUD.SET_TEXT_EDGE(1, 0, 0, 0, 255);
	HUD.SET_TEXT_DROP_SHADOW();
	HUD.SET_TEXT_OUTLINE();
	HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING");
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(I);
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y);
end
function DeleteVehicle(Vehicle)
	if ENTITY.DOES_ENTITY_EXIST(Vehicle) then
		ENTITY.DETACH_ENTITY(Vehicle, true, true);
		ENTITY.SET_ENTITY_VISIBLE(Vehicle, false, false);
		NETWORK.NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS(Vehicle, true);
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Vehicle, 0, 0, -1000, false, false, false);
		ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Vehicle, true, true);
		VEHICLE.DELETE_VEHICLE(Vehicle);
	end
end
function DeleteEntity(Entity)
	gui.show_warning(LuaName, "Deleting Entity");
	ENTITY.DETACH_ENTITY(Entity, true, true);
	ENTITY.SET_ENTITY_VISIBLE(Entity, false, false);
	NETWORK.NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS(Entity, true);
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Entity, 0, 0, -1000, false, false, false);
	ENTITY.SET_ENTITY_COLLISION(Entity, false, false);
	ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Entity, true, true);
	ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(Entity);
	ENTITY.DELETE_ENTITY(Entity);
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

function ScriptHostName()
	return PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_HOST_OF_SCRIPT("freemode", -1, 0));
end
function iconNotification(icon, icon, flash, icon2, text1, text)
	HUD.BEGIN_TEXT_COMMAND_THEFEED_POST(" ");
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(icon, icon, false, icon2, text1, text);
end
local function ShootPlayer(Ply, height)
	script.run_in_fiber(function(script)
		script:yield();
		local head = PED.GET_PED_BONE_COORDS(Ply, ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(Ply, 31086), 0, 0, 0);
		PED.SET_PED_SHOOTS_AT_COORD(PLAYER.PLAYER_PED_ID(), head.x, head.y, head.z + height, 1);
		gui.show_warning(LuaName, "Shooting");
	end);
end
local function BadSport(State, Overall, Bool)
	script.run_in_fiber(function(script)
		gui.show_message("Bad Sport!", "Awaiting Session Change");
		script:sleep(1000);
		stats.set_int("MPPLY_BADSPORT_MESSAGE", State);
		stats.set_int("MPPLY_BADSPORT_MESSAGE", State);
		stats.set_float("MPPLY_OVERALL_BADSPORT", Overall);
		stats.set_bool("MPPLY_CHAR_IS_BADSPORT", Bool);
		globals.set_int(1575035, 11);
		globals.set_int(1574589, 1);
		script:sleep(300);
		globals.set_int(1574589, 0);
	end);
end
function DrawText(I, x, y, scale1, scale2)
	HUD.SET_TEXT_FONT(0);
	HUD.SET_TEXT_PROPORTIONAL(1);
	HUD.SET_TEXT_SCALE(scale1, scale2);
	HUD.SET_TEXT_DROPSHADOW(1, 0, 0, 0, 255);
	HUD.SET_TEXT_EDGE(1, 0, 0, 0, 255);
	HUD.SET_TEXT_DROP_SHADOW();
	HUD.SET_TEXT_OUTLINE();
	HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING");
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(I);
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y);
end





----------------------------MENU BEGIN------------------------------------
gui.add_imgui(function()
	if ImGui.Begin(LuaName .. " ", ImGuiWindowFlags.NoTitleBar) then
		ImGui.SetWindowFontScale(1.025);
		ImGui.SetWindowSize(565, 400);
		ImGui.Indent(5);
		ImGui.Text("Welcome: " .. PLAYER.GET_PLAYER_NAME(PLAYER.PLAYER_ID()) .. " To MNDY Lua\nBuild: 01/09/2024 \nVersion: 1.69 (3274) ");
		ImGui.SameLine(400);
		ImGui.Text("  Session Details: \n   Players: " .. GetPlayerCount() .. "/32 \n   Host: " .. PLAYER.GET_PLAYER_NAME(GetHost()));
		ImGui.Unindent(5);
		ImGui.Indent(5);
		ImGui.SetWindowFontScale(0.925);
		ImGui.Separator();
		if ImGui.BeginTabBar("Self") then
			ImGui.Separator();
			if ImGui.BeginTabItem("Self") then
				ImGui.Spacing();
				ImGui.Indent(10);
				if ImGui.BeginChild("BadSport", 200, 50) then
					ImGui.Indent(70);
					ImGui.Text("Bad Sport!");
					ImGui.Unindent(70);
					ImGui.Separator();
					ImGui.PushItemWidth(130);
					ImGui.Indent(4);
					BadSportCombo = ImGui.Combo("##BadSport", BadSportCombo, {"Remove","Add"}, 2);
					ImGui.SameLine();
					if ImGui.Button("Execute") then
						if (BadSportCombo == 0) then
							BadSport(0, 0, false);
						else
							BadSport(1, 3000, true);
						end
					end
					ImGui.EndChild();
				end
				ImGui.SameLine();
				if ImGui.BeginChild("Mental State", 220, 50) then
					ImGui.Indent(70);
					ImGui.Text("Mental State!");
					ImGui.Unindent(70);
					ImGui.Separator();
					ImGui.PushItemWidth(130);
					ImGui.Indent(4);
					if ImGui.Button("0% Mental State") then
						script.run_in_fiber(function(script)
							gui.show_message(LuaName, "Changing Mental State");
							script:sleep(500);
							STATS.STAT_SET_FLOAT(joaat("MP0_PLAYER_MENTAL_STATE"), 0, true);
						end);
					end
					ImGui.SameLine();
					if ImGui.Button("100% Mental State") then
						script.run_in_fiber(function(script)
							gui.show_message(LuaName, "Changing Mental State");
							script:sleep(500);
							STATS.STAT_SET_FLOAT(joaat("MP0_PLAYER_MENTAL_STATE"), 100, true);
						end);
					end
					ImGui.EndChild();
				end
				if ImGui.BeginChild("MoneyTransfer", 230, 120) then
					ImGui.Indent(70);
					ImGui.Text("Money Transfer!");
					ImGui.Unindent(70);
					ImGui.Separator();
					ImGui.PushItemWidth(130);
					ImGui.Indent(4);
					selected_TransactionMethod = ImGui.Combo("Select Transfer", selected_TransactionMethod, Transaction_names, 2, 15);
					TransferBank, TransferBankused = ImGui.InputInt("Amount", TransferBank, 1, 2147483646);
					if ImGui.Button("Transfer") then
						script.run_in_fiber(function(script)
							if (selected_TransactionMethod == 0) then
								gui.show_warning(LuaName, "Transfering $" .. TransferBank .. " To your bank");
								script:sleep(1000);
								NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(stats.get_character_index(), TransferBank);
								log.debug(TransferBank);
							end
							if (selected_TransactionMethod == 1) then
								gui.show_warning(LuaName, "Transfering $" .. TransferBank .. " To your wallet");
								script:sleep(1000);
								NETSHOPPING.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(stats.get_character_index(), TransferBank);
								log.debug(TransferBank);
							end
						end);
					end
					ImGui.EndChild();
				end
				ImGui.SameLine();
				if ImGui.BeginChild("Misc", 290, 130) then
					ImGui.Indent(125);
					ImGui.Text("Misc!");
					ImGui.Unindent(125);
					ImGui.Separator();
					ImGui.Indent(5);
					ImGui.Spacing(30);
					if ImGui.Button("Unlock Fast Run") then
						STATS.STAT_SET_INT(joaat(MPX() .. "CHAR_ABILITY_1_UNLCK"), -1, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "CHAR_ABILITY_2_UNLCK"), -1, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "CHAR_ABILITY_3_UNLCK"), -1, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "CHAR_FM_ABILITY_1_UNLCK"), -1, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "CHAR_FM_ABILITY_2_UNLCK"), -1, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "CHAR_FM_ABILITY_3_UNLCK"), -1, true);
						gui.show_message(LuaName, "Unlocked Fast Run");
					end
					ImGui.SameLine();
					if ImGui.Button("Unlock 77 Achievements") then
						script.run_in_fiber(function(script)
							for i = 0, 77 do
								script:sleep(200);
								PLAYER.GIVE_ACHIEVEMENT_TO_PLAYER(i);
								gui.show_message("Achivements", "Unlocking");
								if (i == 77) then
									gui.show_message("Achivements", "Unlocked 77 Achivements");
								end
							end
						end);
					end
					if ImGui.Button("Refill Snacks X300") then
						STATS.STAT_SET_INT(joaat(MPX() .. "NO_BOUGHT_YUM_SNACKS"), 300, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "NO_BOUGHT_HEALTH_SNACKS"), 300, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "NO_BOUGHT_EPIC_SNACKS"), 300, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_CHAMP_BOUGHT"), 300, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_ORANGE_BOUGHT"), 300, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_BOURGE_BOUGHT"), 300, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "NUMBER_OF_SPRUNK_BOUGHT"), 300, true);
						STATS.STAT_SET_INT(joaat(MPX() .. "CIGARETTES_BOUGHT"), 300, true);
						iconNotification("CHAR_FILMNOIR", "CHAR_FILMNOIR", true, 1, "Supremacy", "Snacks Given");
					end
					ImGui.SameLine();
					if ImGui.Button("Remove Orbital Cooldown") then
						STATS.STAT_SET_INT(joaat(MPX() .. "ORBITAL_CANNON_COOLDOWN"), 0, true);
						iconNotification("CHAR_LESTER", "CHAR_LESTER", true, 1, LuaName, "Cooldown Removed");
					end
					helpmarker(false, "Removes Cooldown to instantly Fire again");
					ForcePopulate, used = ImGui.Checkbox("Force Population", ForcePopulate);
					ImGui.PushItemWidth(120);
					Watermark_Features = ImGui.Combo("##Watermark Names", Watermark_Features, Watermark_Featnames, 3, 15);
					ImGui.SameLine();
					Watermark, isWaterMarkChanged = ImGui.Checkbox("Watermark", Watermark);
					script.run_in_fiber(function(script)
						if used then
							while ForcePopulate do
								MISC.POPULATE_NOW();
								script:sleep(300);
							end
						end
					end);
					script.run_in_fiber(function(script)
						if isWaterMarkChanged then
							while Watermark do
								local localply = PLAYER.PLAYER_ID();
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
										HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("~ws~" .. Watermark_Featnames[Watermark_Features + 1] .. " | Welcome: " .. PLAYER.GET_PLAYER_NAME(localply) .. " | Players: " .. GetPlayerCount() .. " | Host: " .. PLAYER.GET_PLAYER_NAME(ply_name) .. " | ScriptHost: " .. ScriptHostName() .. " ");
										GRAPHICS.DRAW_RECT(offset.x + 0.187, offset.y, 0.39, 0.049, 0, 0, 0, 125, 0);
										HUD.END_TEXT_COMMAND_DISPLAY_TEXT(offset.x, offset.y);
										script:sleep(0);
									end
								end
							end
						end
					end);
					ImGui.EndChild();
				end
				if ImGui.BeginChild("DebugMNDY", 430, 100) then
					ImGui.Indent(90);
					ImGui.Text("Debug!");
					ImGui.Unindent(90);
					ImGui.Separator();
					ImGui.PushItemWidth(130);
					ImGui.Indent(4);
					WeaponController, WeaponControllerused = ImGui.Checkbox("Weapon Controller", WeaponController);
					playerlocation = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID());
					ImGui.Text("Location: " .. playerlocation.x .. " " .. playerlocation.y .. " " .. playerlocation.z);
					script.run_in_fiber(function(script)
						if WeaponControllerused then
							while WeaponController do
								script:sleep(0);
								local IsFound, Object = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID());
								entityCoord = ENTITY.GET_ENTITY_COORDS(Object, false);
								if IsFound then
									GRAPHICS.DRAW_MARKER_SPHERE(entityCoord.x, entityCoord.y, entityCoord.z, 1, 0, 255, 0, 0.3);
									DrawText("Aiming At: " .. ENTITY.GET_ENTITY_MODEL(Object), 0.4738, 0.505, 0.2, 0.2);
									DrawText("Press E to delete", 0.4798, 0.517, 0.2, 0.2);
									DrawText("Press Q to Fling", 0.4798, 0.529, 0.2, 0.2);
									DrawText("X:  " .. entityCoord.x .. " Y:  " .. entityCoord.y .. "Z:  " .. entityCoord.z .. " ", 0.42, 0.539, 0.2, 0.2);
									if PAD.IS_CONTROL_JUST_PRESSED(0, 38) then
										DeleteEntity(Object);
									end
									if PAD.IS_CONTROL_JUST_PRESSED(0, 52) then
										ForceControl(Object);
										ENTITY.SET_ENTITY_VELOCITY(Object, math.random(-180, 180), math.random(-180, 180), math.random(-180, 180));
									end
								end
							end
						end
					end);
					ImGui.EndChild();
				end
				ImGui.EndTabItem();
			end
			if ImGui.BeginTabItem("Events") then
				ImGui.Spacing();
				ImGui.Text("Coming Soon!");
				ImGui.EndTabItem();
			end
			if ImGui.BeginTabItem("PvP") then
				ImGui.Spacing();
				ImGui.Indent(10);
				if ImGui.BeginChild("Aimbot(s)", 210, 90) then
					ImGui.Indent(80);
					ImGui.Text("Aimbot(s)");
					ImGui.Unindent(80);
					ImGui.Separator();
					ImGui.Indent(5);
					ImGui.Spacing(30);
					ImGui.PushItemWidth(100);
					selected_Triggermode = ImGui.Combo("Triggerbot Mode", selected_Triggermode, triggermode_names, 2, 15);
					TriggerBotAimb, used = ImGui.Checkbox("Triggerbot", TriggerBotAimb);
					script.run_in_fiber(function(script)
						if used then
							while TriggerBotAimb do
								script:sleep(1);
								if (selected_Triggermode == 0) then
									local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
									local dp, Entity = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID(), Entity);
									if dp then
										if (ENTITY.IS_ENTITY_A_PED(Entity) and not PED.IS_PED_DEAD_OR_DYING(Entity, 0) and PED.IS_PED_A_PLAYER(Entity)) then
											ShootPlayer(Entity, math.random(0, 1));
										end
									end
								end
								if (selected_Triggermode == 1) then
									local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
									local dp, Entity = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(PLAYER.PLAYER_ID(), Entity);
									if dp then
										if ((ENTITY.IS_ENTITY_A_PED(Entity) and not PED.IS_PED_DEAD_OR_DYING(Entity, 0) and PED.IS_PED_A_PLAYER(Entity) and not PED.IS_PED_RAGDOLL(Entity)) or PED.IS_PED_FALLING(Entity)) then
											ShootPlayer(Entity, 0.63);
										end
										if ((ENTITY.IS_ENTITY_A_PED(Entity) and not PED.IS_PED_DEAD_OR_DYING(Entity, 0) and PED.IS_PED_A_PLAYER(Entity) and PED.IS_PED_RAGDOLL(Entity)) or PED.IS_PED_FALLING(Entity)) then
											ShootPlayer(Entity, 0);
										end
										if (ENTITY.IS_ENTITY_A_PED(Entity) and not PED.IS_PED_DEAD_OR_DYING(Entity, 0) and PED.IS_PED_A_PLAYER(Entity) and PED.IS_PED_IN_ANY_VEHICLE(Entity)) then
											ShootPlayer(Entity, 0);
										end
									end
								end
							end
						end
					end);
					ImGui.SameLine();
					AimbotMain, used = ImGui.Checkbox("Aimbot", AimbotMain);
					script.run_in_fiber(function(script)
						if used then
							while AimbotMain do
								script:sleep(1);
								for i = 0, 32 do
									Target = PLAYER.GET_PLAYER_PED(i);
									if (Target ~= PLAYER.PLAYER_PED_ID()) then
										local player_id = i;
										if PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) then
											local TargetPed = PLAYER.GET_PLAYER_PED(player_id);
											local TargetPos = ENTITY.GET_ENTITY_COORDS(TargetPed);
											local Exist = ENTITY.DOES_ENTITY_EXIST(TargetPed);
											local Dead = PLAYER.IS_PLAYER_DEAD(TargetPed);
											if (Exist and not Dead) then
												local OnScreen, ScreenX, ScreenY = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(TargetPos.x, TargetPos.y, TargetPos.z, 0);
												if (ENTITY.IS_ENTITY_VISIBLE(TargetPed) and OnScreen) then
													if ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), TargetPed, 17) then
														local TargetCoords = PED.GET_PED_BONE_COORDS(TargetPed, 31086, 0, 0, 0);
														PED.SET_PED_SHOOTS_AT_COORD(PLAYER.PLAYER_PED_ID(), TargetCoords.x, TargetCoords.y, TargetCoords.z, 1);
													end
												end
											end
										end
									end
								end
							end
						end
					end);
					ImGui.EndChild();
				end
				ImGui.SameLine();
				if ImGui.BeginChild("Visuals", 280, 100) then
					ImGui.Indent(120);
					ImGui.Text("Visuals");
					ImGui.Unindent(120);
					ImGui.Separator();
					ImGui.PushItemWidth(130);
					ImGui.Indent(4);
					ESPBox, used = ImGui.Checkbox("ESP", ESPBox);
					ImGui.SameLine();
					DrawLinesPlayers, DrawLinesPlayersused = ImGui.Checkbox("Draw Lines", DrawLinesPlayers);
					Healthbox = ImGui.Checkbox("Health", Healthbox);
					Armourbox = ImGui.Checkbox("Armour", Armourbox);
					script.run_in_fiber(function(script)
						if DrawLinesPlayersused then
							while DrawLinesPlayers do
								script:sleep(0.1);
								for i = 0, 32 do
									if (i ~= localPlayerId) then
										local player_id = i;
										local target = PLAYER.GET_PLAYER_PED(player_id);
										local target1 = PLAYER.GET_PLAYER_PED(-1);
										if (target ~= PLAYER.PLAYER_PED_ID()) then
											local pos = ENTITY.GET_ENTITY_COORDS(target);
											local pos1 = ENTITY.GET_ENTITY_COORDS(target1);
											if PED.IS_PED_IN_ANY_VEHICLE(target1) then
												GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, pos1.x, pos1.y, pos1.z + 6.7, 0, 255, 50, 255);
											else
												GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, pos1.x, pos1.y, pos1.z + 2.7, 0, 255, 50, 255);
											end
										end
									end
								end
							end
						end
					end);
					script.run_in_fiber(function(script)
						if used then
							while ESPBox do
								script:sleep(0.1);
								if (NETWORK.NETWORK_IS_IN_SESSION() == true) then
									Camcoords = CAM.GET_GAMEPLAY_CAM_COORD();
									CAM.RENDER_SCRIPT_CAMS(false, false, 0, true);
									for i = 0, 32 do
										local Target = PLAYER.GET_PLAYER_PED(i);
										local target1 = PLAYER.GET_PLAYER_PED(-1);
										bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(Target, 31086);
										pos = PED.GET_PED_BONE_COORDS(Target, bone, 0, 0, 0.9);
										pos2 = ENTITY.GET_ENTITY_COORDS(target1);
										if (MISC.GET_DISTANCE_BETWEEN_COORDS(pos.x, pos.y, pos.z, Camcoords.x, Camcoords.y, Camcoords.z, true) < 1000) then
											if ((Target ~= PLAYER.PLAYER_PED_ID()) and ENTITY.IS_ENTITY_ON_SCREEN(Target) and not PED.IS_PED_DEAD_OR_DYING(Target)) then
												local Distance = (MISC.GET_DISTANCE_BETWEEN_COORDS(pos.x, pos.y, pos.z, Camcoords.x, Camcoords.y, Camcoords.z, true) * 0.002) / 2;
												retval, _x, _y = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x, pos.y, pos.z);
												width = 0.00045;
												height = 0.0023;
												GRAPHICS.DRAW_RECT(_x, _y, width / Distance, 0.0015, 0, 0, 255, 200);
												GRAPHICS.DRAW_RECT(_x, _y + (height / Distance), width / Distance, 0.0015, 0, 0, 255, 200);
												GRAPHICS.DRAW_RECT(_x + ((width / 2) / Distance), _y + ((height / 2) / Distance), 0.001, height / Distance, 0, 0, 255, 200);
												GRAPHICS.DRAW_RECT(_x - ((width / 2) / Distance), _y + ((height / 2) / Distance), 0.001, height / Distance, 0, 0, 255, 200);
												DrawText(PLAYER.GET_PLAYER_NAME(i), _x + 0.007, _y, 0.2, 0.2);
												if Healthbox then
													DrawText("Health: " .. ENTITY.GET_ENTITY_HEALTH(Target), _x + 0.007, _y + 0.01, 0.2, 0.2);
												end
												if Armourbox then
													DrawText("Armour: " .. PED.GET_PED_ARMOUR(Target), _x + 0.007, _y + 0.02, 0.2, 0.2);
												end
											end
										end
									end
								end
							end
						end
					end);
					ImGui.EndChild();
				end
				if ImGui.BeginChild("Movement", 210, 100) then
					ImGui.Indent(70);
					ImGui.Text("Movement");
					ImGui.Unindent(70);
					ImGui.Separator();
					ImGui.Indent(7);
					InfinateRoll, InfinateRollChanged = ImGui.Checkbox("Infinate Roll", InfinateRoll);
					helpmarker(false, "Removes Roll wait and allows to be triggerd instantly");
					BugRoll, BugRollChanged = ImGui.Checkbox("Bug Roll", BugRoll);
					helpmarker(false, "Telports you Randomly at a short distance and cancel's your roll");
					script.run_in_fiber(function(script)
						if InfinateRollChanged then
							while InfinateRoll do
								script:sleep(0);
								for i = 0, 32 do
									STATS.STAT_SET_INT(joaat("mp" .. i .. "_shooting_ability"), 190, true);
								end
							end
						end
					end);
					script.run_in_fiber(function(script)
						if BugRollChanged then
							while BugRoll do
								script:sleep(0);
								if (PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) and PAD.IS_CONTROL_PRESSED(0, 22)) then
									gui.show_warning(LuaName, "Executed Bug Roll");
									script:sleep(500);
									CurrentCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false);
									ENTITY.SET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), CurrentCoords.x + math.random(-4, 4), CurrentCoords.y + math.random(-2, 2), CurrentCoords.z - 1, false, false, true, true);
								end
							end
						end
					end);
					ImGui.EndChild();
				end
				ImGui.SameLine();
				if ImGui.BeginChild("Crosshairs", 280, 100) then
					ImGui.Indent(120);
					ImGui.Text("Crosshairs!");
					ImGui.Unindent(120);
					ImGui.Separator();
					ImGui.PushItemWidth(130);
					ImGui.Indent(4);
					HideDot, HideDotused = ImGui.Checkbox("Hide Dot", HideDot);
					ImGui.SameLine();
					Showatalltimes = ImGui.Checkbox("Show at all times", Showatalltimes);
					ImGui.Separator();
					ImGui.Unindent(4);
					ImGui.Indent(4);
					CrosshairPlus, CrosshairPlusused = ImGui.Checkbox("Crosshair (+)", CrosshairPlus);
					ImGui.SameLine();
					CrosshairSquare, SquareCrossUsed = ImGui.Checkbox("Crosshair (Square)", CrosshairSquare);
					CrosshairBracket, BracketCrosshair = ImGui.Checkbox("Crosshair ({ })", CrosshairBracket);
					script.run_in_fiber(function(script)
						if HideDotused then
							while HideDot do
								script:sleep(0);
								HUD.HIDE_HUD_COMPONENT_THIS_FRAME(14);
							end
						end
					end);
					script.run_in_fiber(function(script)
						if CrosshairPlusused then
							while CrosshairPlus do
								script:sleep(0);
								if (PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) and not Showatalltimes) then
									DrawText("+", 0.496, 0.481, 0, 0.4);
								elseif Showatalltimes then
									DrawText("+", 0.496, 0.481, 0, 0.4);
								end
							end
						end
					end);
					script.run_in_fiber(function(script)
						if SquareCrossUsed then
							while CrosshairSquare do
								script:sleep(0);
								if (PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) and not Showatalltimes) then
									DrawText("☐", 0.4972, 0.491, 0.2, 0.2);
								elseif Showatalltimes then
									DrawText("☐", 0.4972, 0.491, 0.2, 0.2);
								end
							end
						end
					end);
					script.run_in_fiber(function(script)
						if BracketCrosshair then
							while CrosshairBracket do
								script:sleep(0);
								if (PLAYER.IS_PLAYER_FREE_AIMING(PLAYER.PLAYER_ID()) and not Showatalltimes) then
									DrawText("{ }", 0.496, 0.481, 0, 0.4);
								elseif Showatalltimes then
									DrawText("{ }", 0.496, 0.481, 0, 0.4);
								end
							end
						end
					end);
					script.run_in_fiber(function(script)
						if DrawLinesPlayersused then
							while DrawLinesPlayers do
								script:sleep(0.1);
								for i = 0, 32 do
									if (i ~= localPlayerId) then
										local player_id = i;
										local target = PLAYER.GET_PLAYER_PED(player_id);
										local target1 = PLAYER.GET_PLAYER_PED(-1);
										if (target ~= PLAYER.PLAYER_PED_ID()) then
											local pos = ENTITY.GET_ENTITY_COORDS(target);
											local pos1 = ENTITY.GET_ENTITY_COORDS(target1);
											if PED.IS_PED_IN_ANY_VEHICLE(target1) then
												GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, pos1.x, pos1.y, pos1.z + 6.7, 0, 255, 50, 255);
											else
												GRAPHICS.DRAW_LINE(pos.x, pos.y, pos.z, pos1.x, pos1.y, pos1.z + 2.7, 0, 255, 50, 255);
											end
										end
									end
								end
							end
						end
					end);
					script.run_in_fiber(function(script)
						if used then
							while ESPBox do
								script:sleep(0.1);
								if (NETWORK.NETWORK_IS_IN_SESSION() == true) then
									Camcoords = CAM.GET_GAMEPLAY_CAM_COORD();
									CAM.RENDER_SCRIPT_CAMS(false, false, 0, true);
									for i = 0, 32 do
										local Target = PLAYER.GET_PLAYER_PED(i);
										local target1 = PLAYER.GET_PLAYER_PED(-1);
										bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(Target, 31086);
										pos = PED.GET_PED_BONE_COORDS(Target, bone, 0, 0, 0.9);
										pos2 = ENTITY.GET_ENTITY_COORDS(target1);
										if (MISC.GET_DISTANCE_BETWEEN_COORDS(pos.x, pos.y, pos.z, Camcoords.x, Camcoords.y, Camcoords.z, true) < 1000) then
											if ((Target ~= PLAYER.PLAYER_PED_ID()) and ENTITY.IS_ENTITY_ON_SCREEN(Target) and not PED.IS_PED_DEAD_OR_DYING(Target)) then
												local Distance = (MISC.GET_DISTANCE_BETWEEN_COORDS(pos.x, pos.y, pos.z, Camcoords.x, Camcoords.y, Camcoords.z, true) * 0.002) / 2;
												retval, _x, _y = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x, pos.y, pos.z);
												width = 0.00045;
												height = 0.0023;
												GRAPHICS.DRAW_RECT(_x, _y, width / Distance, 0.0015, 0, 0, 255, 200);
												GRAPHICS.DRAW_RECT(_x, _y + (height / Distance), width / Distance, 0.0015, 0, 0, 255, 200);
												GRAPHICS.DRAW_RECT(_x + ((width / 2) / Distance), _y + ((height / 2) / Distance), 0.001, height / Distance, 0, 0, 255, 200);
												GRAPHICS.DRAW_RECT(_x - ((width / 2) / Distance), _y + ((height / 2) / Distance), 0.001, height / Distance, 0, 0, 255, 200);
												DrawText(PLAYER.GET_PLAYER_NAME(i), _x + 0.007, _y, 0.2, 0.2);
												if Healthbox then
													DrawText("Health: " .. ENTITY.GET_ENTITY_HEALTH(Target), _x + 0.007, _y + 0.01, 0.2, 0.2);
												end
												if Armourbox then
													DrawText("Armour: " .. PED.GET_PED_ARMOUR(Target), _x + 0.007, _y + 0.02, 0.2, 0.2);
												end
											end
										end
									end
								end
							end
						end
					end);
					ImGui.EndChild();
				end
				ImGui.EndTabItem();
			end
			if ImGui.BeginTabItem("Recovery") then
				ImGui.Spacing()
				if ImGui.BeginChild("MoneyLoops", 300, 50) then
					ImGui.Indent(125);
					ImGui.Text("Loops");
					ImGui.Unindent(125);
					ImGui.Separator();
					ImGui.PushItemWidth(130);
					ImGui.Indent(4);

					GiveCasinoChips, GiveCasinoChipsUsed = ImGui.Checkbox("5K Chips", GiveCasinoChips);
					ImGui.SameLine()
					FiftyK, FiftyKUsed = ImGui.Checkbox("50K Loop", FiftyK);
					ImGui.SameLine()
					oneeightK, oneeightKUsed = ImGui.Checkbox("180K Loop", oneeightK);

					script.run_in_fiber(function(script)
						if GiveCasinoChipsUsed then
							while GiveCasinoChips do
								script:sleep(500);
								GlobalInt(1964419, 1)
							end
						end
					end);

					script.run_in_fiber(function(script)
						if FiftyKUsed then
							while FiftyK do
								script:sleep(500);
								MoneyTransactions(1628412596, 50000)
							end
						end
					end);

					script.run_in_fiber(function(script)
						if oneeightKUsed then
							while oneeightK do
								script:sleep(500);
								MoneyTransactions(0x615762F1, 180000)
							end
						end
					end);

					ImGui.EndChild();
				end
				ImGui.EndTabItem();
			end
			if ImGui.BeginTabItem("Business") then
				ImGui.Spacing();
				if ImGui.BeginChild("NightClub", 200, 200) then
					ImGui.Indent(70);
					ImGui.Text("NightClub!");
					ImGui.Unindent(70);
					ImGui.Separator();
					ImGui.PushItemWidth(130);
					ImGui.Indent(4);
					local cashSupply   = stats.get_int(MPX().."CLUB_SAFE_CASH_VALUE")
					local NightClubEarnings   = stats.get_int(MPX().."NIGHTCLUB_EARNINGS")
					local PopularitySupply   = stats.get_int(MPX().."CLUB_POPULARITY")
					local CLUBTimeLeft   = stats.get_int(MPX().."CLUB_PAY_TIME_LEFT")
					ImGui.Text("Current Popularity: "..(PopularitySupply/10).."/100%")
					ImGui.Text("Current Safe Amount: "..formatMoney(cashSupply))
					ImGui.Text("Earnings: "..formatMoney(NightClubEarnings))
					ImGui.Text("Time Till Next Pay: "..CLUBTimeLeft)
					ImGui.Unindent(4);
					ImGui.Separator();
					ImGui.Indent(4);

					SafeClubLoop, SafeClubLoopUsed = ImGui.Checkbox("Auto Fill Safe", SafeClubLoop);

					script.run_in_fiber(function(script)
						if SafeClubLoopUsed then
							while SafeClubLoop do
								script:sleep(1)
								STATS.STAT_SET_INT(joaat(MPX() .. "CLUB_POPULARITY"), 1000, true);
								script:sleep(200)
								STATS.STAT_SET_INT(joaat(MPX() .. "CLUB_PAY_TIME_LEFT"), -1, true)
								script:sleep(1900)
							end
						end
					end);

					
					if ImGui.Button("Computer") then
						run_script("appBusinessHub", 1424)
					end
					ImGui.EndChild();
				end
				ImGui.EndTabItem();
			end
			if ImGui.BeginTabItem("Player Options") then
				ImGui.Spacing();
				ImGui.Text("Selected Player: "..PLAYER.GET_PLAYER_NAME(network.get_selected_player()).. "\n(Select Player in NewWay Player Options) ");
				ImGui.SameLine(400);
				ImGui.Text("Rank: " ..network.get_player_rank(network.get_selected_player()) .. " ("..network.get_player_rp(network.get_selected_player())..") ");
				ImGui.Separator();
				if ImGui.BeginChild("RP", 180, 100) then
					ImGui.Indent(60);
					ImGui.Text("RP Options");
					ImGui.Unindent(60);
					ImGui.Separator();
					ImGui.Indent(7);
					RpDrops, RpDropsUsed = ImGui.Checkbox("Drop RP", RpDrops);
					ImGui.SameLine();
					FastRp, FastRpUsed = ImGui.Checkbox("Fast RP", FastRp);
					script.run_in_fiber(function(script)
						if RpDropsUsed then
							while RpDrops do
								script:sleep(200);
								drop_function(joaat("vw_prop_vw_colle_pogo"), joaat("PICKUP_CUSTOM_SCRIPT"), 4, 0)
								drop_function(joaat("vw_prop_vw_colle_beast"), joaat("PICKUP_CUSTOM_SCRIPT"), 4, 0)
								drop_function(joaat("vw_prop_vw_colle_sasquatch"), joaat("PICKUP_CUSTOM_SCRIPT"), 4, 0)
								drop_function(joaat("vw_prop_vw_colle_prbubble"), joaat("PICKUP_CUSTOM_SCRIPT"), 4, 0)
								drop_function(joaat("vw_prop_vw_colle_imporage"), joaat("PICKUP_CUSTOM_SCRIPT"), 4, 0)
								drop_function(joaat("vw_prop_vw_colle_rsrcomm"), joaat("PICKUP_CUSTOM_SCRIPT"), 4, 0)
								drop_function(joaat("vw_prop_vw_lux_card_01a"), joaat("PICKUP_CUSTOM_SCRIPT"), 4, 0)
							end
						end
					end);
					script.run_in_fiber(function(script)
						if FastRpUsed then
							while FastRp do
								script:sleep(0);
								for i = 1,50 do
								SCEdrop_function(4, 24)
								SCEdrop_function(4, 24)
								SCEdrop_function(4, 24)
								SCEdrop_function(4, 24)
							end
							end
						end
					end);
					ImGui.Indent(40);
					ImGui.Text("Money Options");
					ImGui.Unindent(60);
					ImGui.Separator();
					ImGui.Indent(50);
					if ImGui.Button("Big Money Unlock") then
						script.run_in_fiber(function(script)
							for i = 1,30 do
							network.trigger_script_event(1 << network.get_selected_player(), {SKYDIVING_JUMP_COMPLETED, network.get_selected_player(), 1, 1, 2000, 1});
							network.trigger_script_event(1 << network.get_selected_player(), {SKYDIVING_ALL_JUMPS_COMPLETED, network.get_selected_player(), 1, 4});
							network.trigger_script_event(1 << network.get_selected_player(), {SKYDIVING_ALL_JUMPS_GOLD, network.get_selected_player(), 1, 1});
							script:sleep(100);
							if i == 10 then
								SCEdrop_function(6, 2)
								SCEdrop_function(2, 2)
								SCEdrop_function(4, 4)
								SCEdrop_function(5, 1)
								SCEdrop_function(10, 10)
								SCEdrop_function(8, 10)
								SCEdrop_function(3, 10)
								SCEdrop_function(1, 10)
								SCEdrop_function(19, 5)
								SCEdrop_function(16, 25)
								SCEdrop_function(17, 1)
								script:sleep(1000);
							end
						end
						end)
					end
					ImGui.EndChild();
				end

				ImGui.SameLine()

				if ImGui.BeginChild("TSE Drop's", 350, 100) then
					ImGui.Indent(130);
					ImGui.Text("TSE Drop's");
					ImGui.Unindent(130);
					ImGui.Separator();
					ImGui.Indent(7);
					BuriedStash, BuriedStashUsed = ImGui.Checkbox("Buried Stashes ($25,000)", BuriedStash);
					ImGui.SameLine();
					TreasureC, TreasureCUsed = ImGui.Checkbox("Treasure Chests ($25,000)", TreasureC);
					Shipwreck, ShipwreckUsed = ImGui.Checkbox("Shipwreck ($25,000)", Shipwreck);
					ImGui.SameLine();
					LSTags, LSTagsUsed = ImGui.Checkbox("LS Tags ($15,000)", LSTags);
					Snowmen, SnowmenUsed = ImGui.Checkbox("Snowmen ($5,000)", Snowmen);
					script.run_in_fiber(function(script)
						if BuriedStashUsed then
							while BuriedStash do
								script:sleep(0);
								SCEdrop_function(6, 2) --- Buried Statsh
							end
						end
					end);
					script.run_in_fiber(function(script)
						if SnowmenUsed then
							while Snowmen do
								script:sleep(0);
								SCEdrop_function(16, 25) --- Snowmen
							end
						end
					end);
					script.run_in_fiber(function(script)
						if ShipwreckUsed then
							while Shipwreck do
								script:sleep(0);
								SCEdrop_function(5, 1) --- Shipwreck
							end
						end
					end);
					script.run_in_fiber(function(script)
						if LSTagsUsed then
							while LSTags do
								script:sleep(0);
								SCEdrop_function(19, 5) --- LSTags
							end
						end
					end);
					script.run_in_fiber(function(script)
						if TreasureCUsed then
							while TreasureC do
								script:sleep(0);
								SCEdrop_function(2, 2) --- Treasure Chest
							end
						end
					end);
					ImGui.EndChild();
				end

				if ImGui.BeginChild("Toxic", 550, 100) then
					ImGui.Indent(220);
					ImGui.Text("Toxic/Griefing");
					ImGui.Unindent(220);
					ImGui.Separator();
					ImGui.Indent(7);
					if ImGui.Button("Fragment Crash") then
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
					end
					ImGui.SameLine();
					if ImGui.Button("Rage Shoot") then
						ShootAt()
					end
					ImGui.SameLine();
					if ImGui.Button("Drop Bus on Player") then
						DropVehicleOnPlayer("bus")
					end
					ImGui.SameLine();
					if ImGui.Button("Fling Vehicle") then
						FlingVehicle()
					end
					ImGui.SameLine();
					if ImGui.Button("Fake Destroy Vehicle") then
						FakeVehicleDestory()	
					end
					if ImGui.Button("Force Random Mission") then
						FOrceRandomMission()
					end

					AppartmentSpam, AppartmentSpamUsed = ImGui.Checkbox("Appartment Spam", AppartmentSpam);
					ImGui.SameLine()
					SMSSpam, SMSSpamUsed = ImGui.Checkbox("SMS Spam", SMSSpam);
					ImGui.SameLine()
					ErrorSpam, ErrorSpamUsed = ImGui.Checkbox("Error Spam", ErrorSpam);

					script.run_in_fiber(function(script)
					if SMSSpamUsed then
						while SMSSpam do	
							script:sleep(0);
							network.trigger_script_event(1 << network.get_selected_player(), {SEND_BASIC_TEXT, network.get_selected_player(), 1, 2});
						end	
					end
				end);

				script.run_in_fiber(function(script)
					if ErrorSpamUsed then
						while ErrorSpam do	
							script:sleep(0);
							network.trigger_script_event(1 << network.get_selected_player(), {CREATE_FMC_INVITE, network.get_selected_player(), 1, 4});
						end	
					end
				end);

				script.run_in_fiber(function(script)
					if AppartmentSpamUsed then
						while AppartmentSpam do	
							script:sleep(0);
							network.trigger_script_event(1 << network.get_selected_player(), {INVITE_TO_APARTMENT, network.get_selected_player(), 0, 0});
						end
						
					end
				end);
					ImGui.EndChild();
				end

				ImGui.EndTabItem();
			end
			if ImGui.BeginTabItem("Stats") then
				ImGui.Spacing();
				ImGui.Indent(10);
				if ImGui.BeginChild("Select Stat type!", 340, 180) then
					ImGui.Indent(120);
					ImGui.Text("Select Stat type!");
					ImGui.Unindent(120);
					ImGui.Separator();
					ImGui.Indent(5);
					ImGui.Spacing(30);
					if (value == 1) then
						ImGui.Text("Example Below: \nHash: MPPLY_KILLS_PLAYERS, \nAmount: 1000");
					end
					if (value == 2) then
						ImGui.Text("Example Below: \nHash: MPPLY_KILL_DEATH_RATIO, \nAmount: 12.0");
					end
					if (value == 3) then
						ImGui.Text("Example Below: \nHash: MPX_AWD_WIZHARD, \nState: true");
					end
					value, ischanged = ImGui.RadioButton("INT", value, 1);
					ImGui.SameLine(80 - 10);
					value, ischanged = ImGui.RadioButton("FLOAT", value, 2);
					ImGui.SameLine();
					value, ischanged = ImGui.RadioButton("BOOL", value, 3);
					ImGui.PushItemWidth(245);
					if (value == 1) then
						textint, selected = ImGui.InputText("Hash", textint, 100);
						Statamount = ImGui.InputInt("Amount", Statamount, 1, 2147483646);
						TDBPUp = ImGui.Button("Update");
						if TDBPUp then
							STATS.STAT_SET_INT(joaat(textint), Statamount, true);
							gui.show_warning(LuaName, "Updated: " .. textint .. " \nStat Type: INT \nAmount: " .. Statamount);
						end
					end
					if (value == 2) then
						textFloat, selected = ImGui.InputText("Hash", textFloat, 100);
						Statamountfloat = ImGui.InputFloat("Amount ", Statamountfloat, 1, 2147483646);
						UpdateFloats = ImGui.Button("Update");
						if UpdateFloats then
							STATS.STAT_SET_FLOAT(joaat(textFloat), Statamountfloat, true);
							gui.show_warning(LuaName, "Updated: " .. textFloat .. " \nStat Type: FLOAT \nAmount: " .. Statamountfloat);
						end
					end
					if (value == 3) then
						textbool, selected = ImGui.InputText("Hash", textbool, 100);
						Selectedbool = ImGui.Combo("State", Selectedbool, Stattrueorfalse, 2);
						UpdateBool = ImGui.Button("Update");
						if UpdateBool then
							if (Selectedbool == 0) then
								stats.set_bool(textbool, false);
							end
							if (Selectedbool == 1) then
								stats.set_bool(textbool, true);
							end
							gui.show_warning(LuaName, "Updated: " .. textbool .. " \nStat Type: BOOL \nState: " .. Selectedbool);
						end
					end
					ImGui.EndTabItem();
				end
				ImGui.EndTabBar();
			end
			ImGui.End();
		end
	end
end);


AllPlayers:add_separator();
AllPlayers:add_text("TSE's All Players");
AllPlayers:add_separator();
local checkbox = AllPlayers:add_checkbox("Spam SMS!")
script.register_looped("Spam SMS! ALL", function(script)
    script:yield()
    if checkbox:is_enabled() then
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                network.trigger_script_event(1 << network.get_selected_player(), {SEND_BASIC_TEXT, network.get_selected_player(), 1, 2});
                script:sleep(100);
            end
    end
end
end)
AllPlayers:add_sameline()
local checkbox = AllPlayers:add_checkbox("Fake Vehicle Destroy")
script.register_looped("Fake Vehicle Destroy ALL", function(script)
    script:yield()
    if checkbox:is_enabled() then
        for i = 0, 32 do
            if (i ~= localPlayerId) then
                local player_id = i;
                network.trigger_script_event(1 << player_id, {CAR_INSURANCE, player_id, 1, math.random(-999999999, 999999999)});
                script:sleep(100);
            end
    end
end
end)

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
                local object = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, false, false)
                ENTITY.SET_ENTITY_HEADING(object, ENTITY.GET_ENTITY_HEADING(player_id) - 90);
                script:sleep(1);
                if ENTITY.DOES_ENTITY_EXIST(object) then
                    OBJECT.DELETE_OBJECT(object);
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
                local object = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, false, false)
                ENTITY.SET_ENTITY_HEADING(object, ENTITY.GET_ENTITY_HEADING(player_id) - 90);
                script:sleep(1);
                if ENTITY.DOES_ENTITY_EXIST(object) then
                    OBJECT.DELETE_OBJECT(object);
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
