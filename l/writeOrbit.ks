@lazyglobal off.
parameter lib.
lib:add({parameter o.
	print "$ writeOrbit.ks".
    local tmp is o:copy.
    set tmp["body"]to tmp["body"]:name.
	writeJSON(tmp,"/orbit.json").
}).