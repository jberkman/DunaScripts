@lazyglobal off.
parameter lib.
lib:add({parameter s is ship,a is s:altitude.
	local p is s:body:atm:altitudePressure(a).
	local t is V(0,0,0).
	local l is 0.
	list engines in l.
	for e in l set t to t+e:availableThrustAt(p)*e:facing:vector:normalized.
	return t.
}).