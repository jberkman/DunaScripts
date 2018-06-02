@lazyglobal off.
parameter lib.
lib:add({
	print"$ mainMenu.ks".
	local done is 0.
	local exec is 0.
	local win is GUI(320).

	local stk is win:addStack().
	win:addSpacing(5).
	local lbl is win:addLabel(ship:name+" - "+core:part:name).
	if core:part:tag:length>0 set lbl:text to lbl:text+" ("+core:part:tag+")".

	local mnu is stk:addVLayout().
	local bar is mnu:addHLayout().
	local btn is bar:addButton(" X ").
	set btn:onClick to{set done to 1.}.
	set btn:style:hStretch to 0.
	bar:addSpacing(5).
	bar:addLabel("Main Menu").
	mnu:addSpacing(5).

	set mnu:addButton("Orbital Parameters"):onClick to{use("/l/orbitMenu.ks")(stk,mnu).}.
	set mnu:addButton("Execute Manouvre"):onClick to{set exec to 1.}.
	set mnu:addButton("Stage"):onClick to{stage.}.
	set mnu:addButton("Reboot"):onClick to{win:hide().reboot.}.

	win:show().
	until done{
		wait until exec or done.
		if exec{
			set exec to 0.
			use("/l/execNode.ks")().
		}
	}
	win:dispose().
}).