@lazyglobal off.
parameter lib.
lib:add({parameter stk,prv.
	print"$ recoverStage.ks".
	local l is use("l/readLaunch.ks")().
	local boostback is use("/l/boostback.ks").
	local execNode is use("/l/execNode.ks").
	local hoverSlam is use("/l/hoverSlam.ks").
	wait until ship:modulesNamed("kOSProcessor"):length=1.
	boostback(l["lat"],l["lng"]).
	execNode(stk,prv).
	hoverSlam(l["lat"],l["lng"]).
}).
