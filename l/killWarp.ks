@lazyglobal off.
parameter lib.
lib:add({
	print "$ killWarp.ks".
	set warp to 0.wait until kUniverse:timeWarp:isSettled.
}).