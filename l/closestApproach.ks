@lazyglobal off.
parameter lib.
lib:add({parameter b is use("/l/readOrbit.ks")()["body"],e is 500.
	local s is use("/l/goldenSectionSearch.ks").
	local x is use("/l/xfersTo.ks").
	local o is use("/l/xferOrbit.ks").
	return{parameter n.
		if n:eta<0 return 2^64.
		if x(n:obt,b)return b:radius+o(n:obt,b):periapsis.
		if n:obt:eccentricity>=1 return 2^64.
		function d{parameter t.return round((positionAt(ship,t)-positionAt(b,t)):mag/e)*e.}
		local t is time:seconds+n:eta+n:obt:period/6.
		return d(s(t,t+n:obt:period*2/3,100,d@)).
	}.
}).