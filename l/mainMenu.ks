@lazyglobal off.
parameter lib.
lib:add({
	local done is false.
	local win is GUI(320).

	local stk is win:addStack().
	win:addSpacing(5).
	local lbl is win:addLabel(ship:name+" - "+core:part:name).
	if core:part:tag:length>0 set lbl:text to lbl:text+" ("+core:part:tag+")".

	local mnu is stk:addVLayout().
	local bar is mnu:addHLayout().
	local btn is bar:addButton("X").
	set btn:onClick to{set done to true.}.
	set btn:style:hStretch to false.
	bar:addLabel("Main Menu").
	mnu:addSpacing(5).

	set mnu:addButton("Orbital Parameters"):onClick to{use("/l/orbitMenu.ks")(stk,mnu).}.
	set mnu:addButton("Stage"):onClick to{stage.}.
	set mnu:addButton("Reboot"):onClick to{win:dispose().reboot.}.

	win:show().
	wait until done.
	win:dispose().
}).