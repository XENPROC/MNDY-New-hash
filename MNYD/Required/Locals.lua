Yourself = PLAYER.PLAYER_ID();
Yourselfpedid = PLAYER.PLAYER_PED_ID()
YourselfPED = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID());
RPDropTime = 400;
MoneyDropTime = 800;
SCEWait = 800;
TransferBank2 = false
TransferBank = 0
Transaction_names = {"Bank","Wallet"}
selected_TransactionMethod = 0
isWaterMarkChanged = false
Watermark = false
Watermark_Featnames = {"MNYD","NewWayMenu.vip","NewWay"}
Watermark_Features = 0


LuaName = "MNDY"
gui.show_message("NewWay", LuaName.." Loaded")
PlayersTab = gui.get_tab("ICON_FA_PLAYER");
MenuImGui = gui.get_tab("GUI_TAB_LUA_SCRIPTS")

function iconNotification(icon, icon, flash, icon2, text1, text)
	HUD.BEGIN_TEXT_COMMAND_THEFEED_POST(" ");
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(icon, icon, false, icon2, text1, text);
end

function ScriptHostName()
	return PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_HOST_OF_SCRIPT("freemode", -1, 0))
end