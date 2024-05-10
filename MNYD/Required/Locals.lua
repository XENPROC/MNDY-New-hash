Yourself = PLAYER.PLAYER_ID();
Yourselfpedid = PLAYER.PLAYER_PED_ID()
YourselfPED = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID());
RPDropTime = 400;
MoneyDropTime = 800;
SCEWait = 800;


LuaName = "MNDY"
gui.show_message("NewWay", LuaName.." Loaded")
PlayersTab = gui.get_tab("ICON_FA_PLAYER");

function iconNotification(icon, icon, flash, icon2, text1, text)
	HUD.BEGIN_TEXT_COMMAND_THEFEED_POST(" ");
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(icon, icon, false, icon2, text1, text);
end