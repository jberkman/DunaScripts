@lazyglobal off.
parameter lib.
lib:add({parameter b is use("/l/readOrbit.ks")()["body"].
	print"$ xferCorrection.ks".
	local hal is use("/l/mooSolver.ks").
	local find is use("/l/findNode.ks").
	local xfer is use("/l/xfersTo.ks").
	local approach is use("/l/closestApproach.ks").
	if xfer(obt,b)return.
	set target to b.
	local h is hal().
	h["add"](b:SOIRadius/4,approach(b)).
	until hasNode and nextNode:eta>30 and xfer(nextNode:obt,b){
		add find(h["solve"]@,Node(time:seconds+180,0,0,0),List(0,10,10,10)).
		wait 0.
	}
}).