@lazyglobal off.
parameter lib.
lib:add({parameter o.
	print "$ writeOrbit.ks".
	writeJSON(o,"/orbit.json").
}).