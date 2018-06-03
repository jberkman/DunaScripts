@lazyglobal off.
parameter lib.
lib:add({parameter i is use("/l/readOrbit.ks")()["inc"],l is use("/l/readOrbit.ks")()["lan"].
	print"$ changeInc.ks".
	local hal is use("/l/mooSolver.ks").
	local inc is use("/l/calcIncDV.ks").
	local find is use("/l/findNode.ks").
	local h is hal().
	local dv is inc(abs(obt:inclination-i)).
	add Node(time:seconds+obt:period/2,0,dv[0],dv[1]).
	if l>=0{
		h["add"](0.1,{parameter n.return n:obt:longitudeOfAscendingNode-l.}).
		add find(h["solve"]@,nextNode,List(obt:period/36,0,0,0)).
	}
	h["add"](0.25,{parameter n.return n:obt:inclination-i.}).
	h["add"](0.01,{parameter n.return n:obt:eccentricity.}).
	local d is nextNode:deltaV:mag*0.1.
	add find(h["solve"]@,nextNode,List(60,d,d,d)).
	until nextNode:eta>30 set nextNode:eta to nextNode:eta+obt:period.
}).