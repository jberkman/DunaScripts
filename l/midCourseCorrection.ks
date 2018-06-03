@lazyglobal off.
parameter lib.
local rdObt is use("/l/readOrbit.ks").
lib:add({parameter b is rdObt()["body"],a is rdObt()["apo"],i is rdObt()["inc"].
	print"$ midCourseCorrection.ks".
	local hal is use("/l/mooSolver.ks").
	local cn is use("/l/clearNodes.ks").
	local find is use("/l/findNode.ks").
	local gss is use("/l/goldenSectionSearch.ks").
	local x2 is use("/l/xfersTo.ks").
	local xferObt is use("/l/xferOrbit.ks").
	local altAt is use("/l/altAt.ks").
	local xferETA is use("/l/xferETA.ks").
	local xferMap is use("/l/xferMap.ks").
	cn().
	if not x2(obt,b) return.
	//if altitude>b:altitude/2{s().return.}
	set target to b.
	{
		local t is xferETA(obt,b).
		local h is obt:periapsis/2.
		if altitude>b:altitude set h to obt:apoapsis/2.
		set h to h+b:altitude/2.
		add Node(gss(time:seconds,time:seconds+t,60,{parameter t.return abs(altAt(t)-h).}),0,0,0).
	}
	local h is hal().
	if(i<90)<>(xferObt(nextNode:obt,b):inclination<90){
		h["add"](b:radius,xferMap(b,{parameter o.
			//print "peri: "+o:periapsis+" ("+(o:periapsis+b:radius)+")".
			return o:periapsis+b:radius.
		})).
		add find(h["solve"]@,nextNode,List(0,0.5,0.5,0.5)).
		set h to hal().
	}
	if i<90 set i to 0.else set i to 180.
	h["add"](30,xferMap(b,{parameter o.return o:inclination-i.})).
	add find(h["solve"]@,nextNode,List(0,1,1,1)).
	print"AAA: "+(0.05*abs(a)).
	local gl is max(10000,0.05*abs(a)).
	h["add"](max(10000,0.2*abs(a)),xferMap(b,{parameter o.
		print "gl: "+gl+" dlt: "+abs(o:periapsis-a).
		return o:periapsis-a.
	})).
	add find(h["solve"]@,nextNode,List(0,1,1,1)).
}).