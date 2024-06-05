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
Transaction_names = {"Bank","Wallet"}
Computer_names = {"Bank","Wallet"}
selected_TransactionMethod = 0
selected_Computer = 0
isWaterMarkChanged = false
Watermark = false
Watermark_Featnames = {"MNYD","NewWayMenu.vip","NewWay"}
Watermark_FeatnamesAmmount = 3
Watermark_Features = 0
LuaName = "MNDY"
gui.show_message("NewWay", LuaName.." Loaded")
PlayersTab = gui.get_tab("GUI_TAB_PLAYER");
StatisticsMNDY = gui.get_tab("MNDY Stats Editor")
recoveryTab2 = gui.get_tab("MNDY Recovery")
NightClubMNDY = gui.get_tab("MNDY NightClub")
MenuImGui = gui.get_tab("MNDY Misc")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function iconNotification(icon, icon, flash, icon2, text1, text)
	HUD.BEGIN_TEXT_COMMAND_THEFEED_POST(" ");
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(icon, icon, false, icon2, text1, text);
end

MPX = PI;
PI = stats.get_int("MPPLY_LAST_MP_CHAR");
if (PI == 0) then
	MPX = "MP0_";
else
	MPX = "MP1_";
end

function ScriptHostName()
	return PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_HOST_OF_SCRIPT("freemode", -1, 0))
end

function GlobalInt(address, value)
	globals.set_int(address, value);
end


---QuickCash
local MNYDMNYYDWWJ8WE8 = 4537212;
function MNYDJJDU837KLSLLMNMNKUIEU8U14(hash, amount)
	globals.set_int(262145 + 34328 + 5, -22923932);
	GlobalInt(MNYDMNYYDWWJ8WE8 + 1, 2147483646);
	GlobalInt(MNYDMNYYDWWJ8WE8 + 7, 2147483647);
	GlobalInt(MNYDMNYYDWWJ8WE8 + 6, 0);
	GlobalInt(MNYDMNYYDWWJ8WE8 + 5, 0);
	GlobalInt(MNYDMNYYDWWJ8WE8 + 3, hash);
	GlobalInt(MNYDMNYYDWWJ8WE8 + 2, amount);
	GlobalInt(MNYDMNYYDWWJ8WE8, 2);
end

FIFTYKJoaats = {
   "SERVICE_EARN_FROM_CONTRABAND",
   "SERVICE_EARN_GOON",
   "SERVICE_EARN_TAXI_JOB",
   "SERVICE_EARN_CASINO_AWARD_MISSION_FIVE_FIRST_TIME",
   "SERVICE_EARN_TUNER_CAR_CLUB_MEMBERSHIP",
   "SERVICE_EARN_AMBIENT_JOB_HOT_TARGET_KILL",
   "SERVICE_EARN_AMBIENT_JOB_SHOP_ROBBERY",
   "SERVICE_EARN_ARENA_WAR",
   "SERVICE_EARN_AMBIENT_JOB_HELI_HOT_TARGET",
   "SERVICE_EARN_CASINO_AWARD_LUCKY_LUCKY"
}

twohundredkJoaats = {
	"SERVICE_EARN_CASINO_HEIST_AWARD_PROFESSIONAL",

 }

 onemhash1 = "SERVICE_EARN_DAILY_OBJECTIVES"


