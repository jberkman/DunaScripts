@lazyglobal off.
parameter lib.
lib:add({
	print"$ terminalCount.ks".
	local az is use("/l/launchAzimuth.ks").
	local changePeri is use("/l/changePeri.ks").
	local execNode is use("/l/execNode.ks").

	local l is use("/l/readLaunch.ks")().
	local r is l["pr"].

	local o is use("/l/readLaunchOrbit.ks")().
	local i is o["inc"].

	local t0 is time:seconds+10.

	if o["lan"]>=0 set t0 to time:seconds+use("/l/etaToLAN.ks")(o["lan"]).
	until time:seconds>t0{
		hudText("T - "+round(t0-time:seconds),0.8,2,-1,yellow,1).
		wait 1.
	}
	use("/l/killWarp.ks")().

	// Ignition
	sas on.
	local a is alt:radar+60.
	lock throttle to 1.
	stage.
	wait until alt:radar>a.

	// Pitch & Roll Manouvres
	local t1 is time:seconds.
	function hd{
		local z is az(i).
		return lookDirUp(heading(z,90-r*(time:seconds-t1)):vector,heading(z,-45):vector).
	}
	sas off.
	lock steering to hd().

	local q is ship:q.
	until q>ship:q or ship:q>0.2 set q to ship:q.

	// Track prograde
	lock steering to lookDirUp(ship:velocity:surface,-up:vector).
	if l["land"]{
		wait until AG1.
		lock throttle to 0.
		wait 5.
		lock throttle to 1.
	}
	set a to o["peri"].
	wait until ship:q<0.02 or apoapsis>=a.

	function hd2{return lookDirUp(heading(az(i),0):vector,-up:vector).}
	lock steering to hd2().
	wait until apoapsis>=a or(ship:maxThrust<0.1 and altitude>body:atm:height).
	lock throttle to 0.
	wait 5.

	// Coast
	local el is 0.
	list engines in el.
	local m is{for e in el if e:thrust>0 return 0. return 1.}.
	until m().
	lock steering to lookDirUp(ship:velocity:orbit,-up:vector).
	wait until altitude>body:atm:height.

	changePeri(a).
	execNode().
}).