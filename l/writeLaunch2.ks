@lazyglobal off.
parameter lib.
lib:add({parameter pr,land,lat,lng.
	print "$ writeLaunch2.ks".
	use("/l/writeLaunch.ks")(Lexicon("pr",pr,"land",land,"lat",lat,"lng",lng)).
}).