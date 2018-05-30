@lazyglobal off.
parameter lib.
local mainMenu is use("/l/mainMenu.ks").
lib:add({
	if status = "PRELAUNCH" or ship:modulesNamed("kOSProcessor"):length = 1 mainMenu().
	else print "Type 'run l/mainMenu' to load main menu.".
}).