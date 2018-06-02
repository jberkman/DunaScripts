@lazyglobal off.
parameter lib.
local rdObt is use("/l/readOrbit.ks").
local wrObt2 is use("/l/writeOrbit2.ks").
lib:add({parameter stk,prv.
	print"$ orbitMenu.ks".
	local o is rdObt().
	local mnu is stk:addVLayout().
	local bar is mnu:addHLayout().
	local btn is bar:addButton(" < ").
	set btn:onClick to{stk:showOnly(prv).mnu:dispose().}.
	set btn:style:hStretch to 0.
	bar:addSpacing(5).
	bar:addLabel("Orbital Parameters").
	mnu:addSpacing(5).

	local box is mnu:addHLayout().
	set box:addLabel("Body: "):style:hStretch to 0.
	local par is box:addPopupMenu().
	set par:optionSuffix to "name".
	par:addOption(body).
	local bodies is 0.
	list bodies in bodies.
	for i in bodies if i:hasBody and i:body=body par:addOption(i).
	if body:hasBody{
		par:addOption(body:body).
		for i in bodies if i <> body and i:hasBody and i:body=body:body par:addOption(i).
	}
	set par:value to o["body"].

	function addField{
		parameter lbl,val.
		local box is mnu:addHLayout().
		set box:addLabel(lbl+": "):style:hStretch to 0.
		return box:addTextField(""+val).
	}

	local apo is addField("Apoapsis",round(o["apo"]-obt:body:radius)).
	local per is addField("Periapsis",round(o["peri"]-obt:body:radius)).
	local inc is addField("Inclination",round(o["inc"],1)).
	local aop is addField("Arg. of Peri.",round(o["aop"],1)).
	local lan is addField("Long. of A.N.",round(o["lan"],1)).

	function wrObt{
		wrObt2(par:value,apo:text:toScalar(0)+par:value:radius,per:text:toScalar(0)+par:value:radius,inc:text:toScalar(0),aop:text:toScalar(0),lan:text:toScalar(0)).
	}

	mnu:addSpacing(5).
	set mnu:addButton("Parking Orbit"):onClick to{
		set apo:text to ""+(par:value:atm:height+10_000).
		set per:text to apo:text.
	}.
	set mnu:addButton("Copy From Target"):onClick to{
		if not hasTarget return.
		set par:value to target:body.
		set apo:text to ""+round(target:obt:apoapsis-target:body:radius).
		set per:text to ""+round(target:obt:periapsis-target:body:radius).
		set inc:text to ""+round(target:obt:inclination,1).
		set aop:text to ""+round(target:obt:argumentOfPeriapsis,1).
		set lan:text to ""+round(target:obt:lan,1).
	}.
	set mnu:addButton("Copy to Other CPUs"):onClick to{
		for i in ship:modulesNamed("kOSProcessor"){
			if i<>core{
				switch to i:volume.
				wrObt().
			}
		}
		switch to core:volume.
	}.
	mnu:addSpacing(10).
	set mnu:addButton("Save"):onClick to wrObt@.

	stk:showOnly(mnu).
}).