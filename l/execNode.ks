@lazyglobal off.
parameter lib.
local bt is use("/l/burnTime.ks").
local k is use("/l/killWarp.ks").
lib:add({parameter w is 0.
	print"$ execNode.ks".
	if not hasNode{
		hudText("No node available.",5,2,12,yellow,0).
		print(char(7)).
		return.
	}
	if nextNode:deltaV:mag>0.05{
		local lock t to nextNode:eta-0.5*bt().
		if w warpTo(time:seconds+t-60).
		wait until t<60. k().
		print"1".
		wait 1.
		lock steering to lookDirUp(nextNode:deltaV,-up:vector).
		print"2".
		wait until t<0. k().
		print"3".
		local dv is nextNode:deltaV.
		print"bt: "+bt().
		lock throttle to max(min(1,bt()),0.2).
		print"4".
		wait until vDot(dv,nextNode:deltaV)<=0.
		print"5".
		lock throttle to 0.
		set ship:control:pilotMainThrottle to 0.
		unlock steering.
	}
	remove nextNode.
	wait 1.
}).