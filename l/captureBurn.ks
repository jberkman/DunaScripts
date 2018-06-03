@lazyglobal off.
parameter lib.
lib:add({
	print"$ captureBurn.ks".
	local cn is use("/l/clearNodes.ks").
	local ov is use("/l/calcOrbVel.ks").
	local incDV is use("/l/calcIncDV.ks").
	cn().wait 0.
	local i is 0. if obt:inclination>90 set i to 180.
	local t is time:seconds+eta:periapsis.
	local dv is incDV(abs(obt:inclination-i),velocityAt(ship,t):orbit:mag,ov(obt,periapsis,periapsis+body:radius)).
	if(i>90 and obt:argumentOfPeriapsis>90 and obt:argumentOfPeriapsis<270)or(i<90 and(obt:argumentOfPeriapsis<90 or obt:argumentOfPeriapsis>270))set dv[0]to-dv[0].
	add Node(t,0,dv[0],dv[1]).
}).