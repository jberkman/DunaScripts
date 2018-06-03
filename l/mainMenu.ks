@lazyglobal off.
parameter lib.
lib:add({
	print"$ mainMenu.ks".
	local choice is 0.
	local win is GUI(320).

	local stk is win:addStack().
	win:addSpacing(5).
	local lbl is win:addLabel(ship:name+" - "+core:part:name).
	if core:part:tag:length>0 set lbl:text to lbl:text+" ("+core:part:tag+")".

	local mnu is stk:addVLayout().
	local bar is mnu:addHLayout().
	local btn is bar:addButton(" X ").
	set btn:onClick to{set choice to -1.}.
	set btn:style:hStretch to 0.
	bar:addSpacing(10).
	bar:addLabel("Main Menu").
	mnu:addSpacing(10).

	set mnu:addButton("Plan Manouvre"):onClick to{set choice to 1.}.
	mnu:addSpacing(10).

	local wrp is 0.
	set mnu:addButton("Execute Manouvre"):onClick to{set wrp to 0. set choice to 2.}.
	set mnu:addButton("Execute Manouvre (Warp)"):onClick to{set wrp to 1. set choice to 2.}.
	mnu:addSpacing(10).

	set mnu:addButton("Stage"):onClick to{set choice to 3.}.
	mnu:addSpacing(10).

	set mnu:addButton("Reboot"):onClick to{set choice to 4.}.
	set mnu:addButton("Exit to Terminal"):onClick to{set choice to 5.}.

	win:show().
	until 0{
		wait until choice.
		if choice=-1 break.
		else if choice=1 use("/l/planNode.ks")(stk,mnu).
		else if choice=2 use("/l/execNode.ks")(stk,mnu,wrp).
		else if choice=3 stage.
		else if choice=4{win:hide().reboot.}
		else if choice=5{win:hide().core:doEvent("Open Terminal"). break.}
		set choice to 0.
	}
	win:dispose().
}).