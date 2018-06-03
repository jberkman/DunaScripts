@lazyglobal off.
parameter lib.
local bt is use("/l/burnTime.ks").
local k is use("/l/killWarp.ks").
lib:add({parameter stk,prv,w is 0.
	print"$ execNode.ks".
	if not hasNode{
		hudText("No node available.",5,2,12,yellow,0).
		print(char(7)).
		return.
	}
	if nextNode:deltaV:mag<0.05{
		remove nextNode.
		wait 0.
		return.
	}
	local mnu is stk:addVLayout().
	local bar is mnu:addHLayout().
	local btn is bar:addButton(" < ").
	local cnl is 0.
	set btn:onClick to{set cnl to 1.}.
	set btn:style:hStretch to 0.
	bar:addSpacing(5).
	bar:addLabel("Execute Manouvre").
	mnu:addSpacing(5).
	local lbl is mnu:addLabel("").
	stk:showOnly(mnu).
	local lock t to nextNode:eta-0.5*bt().
	set lbl:text to"Waiting for N-60.".
	if w warpTo(time:seconds+t-60).
	until 0{
		wait until cnl or t<60. k().wait 1.
		if cnl break.
		lock steering to lookDirUp(nextNode:deltaV,-up:vector).
		set lbl:text to"Wating for N-0.".
		wait until cnl or t<0. k().
		if cnl break.
		local dv is nextNode:deltaV.
		set lbl:text to"Performing Burn.".
		lock throttle to max(min(1,bt()),0.2).
		wait until cnl or vDot(dv,nextNode:deltaV)<=0.
	}
	lock throttle to 0.
	set ship:control:pilotMainThrottle to 0.
	unlock steering.
	if not cnl remove nextNode.
	wait 0.
	stk:showOnly(prv).
	mnu:dispose().
}).