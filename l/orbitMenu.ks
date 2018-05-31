@lazyglobal off.
parameter lib.
lib:add({
	parameter stk,prv.

	local mnu is stk:addVLayout().
	local bar is mnu:addHLayout().
	local btn is bar:addButton("<").
	set btn:onClick to{stk:showOnly(prv).mnu:dispose().}.
	set btn:style:hStretch to false.
	bar:addLabel("Orbital Parameters").
	mnu:addSpacing(5).

	mnu:addButton("From Target").
//	set mnu:addButton("Stage"):onClick to{stage.}.
//	set mnu:addButton("Reboot"):onClick to{reboot.}.

	stk:showOnly(mnu).
}).