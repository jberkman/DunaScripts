@lazyglobal off.
parameter lib.
print"$ main.ks".
local mainMenu is use("/l/mainMenu.ks").
lib:add({parameter f is 0.
	if f or status="PRELAUNCH"or ship:modulesNamed("kOSProcessor"):length=1 mainMenu().
	print"Type 'runPath(''boot/init'', true).' to load main menu.".
}).