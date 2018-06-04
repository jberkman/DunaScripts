@lazyglobal off.
parameter lib.
lib:add({
	print"$ mainMenu.ks".
	local choice is 0.
	local wrp is 0.
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

    set mnu:addButton("Orbit Parameters"):onClick to{set choice to 10.}.
	set mnu:addButton("Plan Manouvre"):onClick to{set choice to 20.}.
	set mnu:addButton("Execute Manouvre"):onClick to{set wrp to 0. set choice to 30.}.
	set mnu:addButton("Execute Manouvre (Warp)"):onClick to{set wrp to 1. set choice to 30.}.

	mnu:addSpacing(20).
	set mnu:addButton("Launch Parameters"):onClick to{set choice to 40.}.
	set mnu:addButton("Warp to T-60"):onClick to{set choice to 50.}.
	set mnu:addButton("Begin Terminal Count"):onClick to{set choice to 60.}.
	set mnu:addButton("Recover Stage"):onClick to{set choice to 70.}.

	mnu:addSpacing(20).
	set mnu:addButton("Science"):onClick to{set choice to 80.}.

	mnu:addSpacing(20).
	set mnu:addButton("Reboot"):onClick to{set choice to 90.}.
	set mnu:addButton("Exit to Terminal"):onClick to{set choice to 100.}.

	win:show().
	until choice<0{
		set choice to 0.
		wait until choice.
        if choice=10 use("/l/orbitMenu.ks")(stk,mnu).
		else if choice=20 use("/l/planNode.ks")(stk,mnu).
		else if choice=30 use("/l/execNode.ks")(stk,mnu,wrp).
		else if choice=40 use("/l/launchMenu.ks")(stk,mnu).
		else if choice=50 use("/l/warpToLAN.ks")().
		else if choice=60 use("/l/terminalCount.ks")().
		else if choice=70 use("/l/recoverStage.ks")(stk,mnu).
		else if choice=80 use("/l/scienceMenu.ks")(stk.mnu).
		else if choice=90{win:hide().reboot.}
		else if choice=100{win:hide().core:doEvent("Open Terminal"). break.}
	}
	win:dispose().
}).