@lazyglobal off.
parameter lib.
local mainMenu is use("/l/mainMenu.ks").
lib:add({
	parameter force is false.
	if force or status = "PRELAUNCH" or ship:modulesNamed("kOSProcessor"):length = 1 mainMenu().
	print "Type 'runPath(''boot/init'', true).' to load main menu.".
}).