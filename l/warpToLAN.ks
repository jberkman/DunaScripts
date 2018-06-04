@lazyglobal off.
parameter lib.
lib:add({
	print"$ warpToLAN.ks".
	local l is use("/l/readLaunchOrbit.ks")()["lan"].
	if l>=0 warpTo(time:seconds+use("/l/etaToLAN.ks")(l)-60).
	use("/l/killWarp.ks")().
}).