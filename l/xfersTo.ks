@lazyglobal off.
parameter lib.
lib:add({parameter o,b.
	until o:body=b{
		if o:periapsis<10000 or not o:hasNextPatch return 0.
		set o to o:nextPatch.
	}
	return 1.
}).