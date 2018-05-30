@lazyglobal off.
parameter lib.
//local mainMenu is use("/l/mainMenu.ks").
local window is GUI(200).
local title is window:addLabel("").
window:addSpacing(10).
local box is window:addVLayout().
lib:add({
	set title:text to "Main Menu".
	box:clear().
	local b is box:addButton("Stage").
	set b:onClick to { stage. }.

	window:show().
	wait until 0.
}).