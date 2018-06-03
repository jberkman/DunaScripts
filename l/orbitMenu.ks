@lazyglobal off.
parameter lib.
lib:add({parameter stk,prv.
	print"$ orbitMenu.ks".
	local o is use("/l/readOrbit.ks")().
	local mnu is stk:addVLayout().
	local bar is mnu:addHLayout().
	local btn is bar:addButton(" < ").
	set btn:onClick to{stk:showOnly(prv).mnu:dispose().}.
	set btn:style:hStretch to 0.
	bar:addSpacing(10).
	bar:addLabel("Orbital Parameters").
	mnu:addSpacing(10).

	local box is mnu:addHLayout().
	set box:addLabel("Body: "):style:hStretch to 0.
	local par is box:addPopupMenu().
	set par:optionSuffix to"name".
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

	local apo is addField("Apoapsis",o["apo"]).
	local per is addField("Periapsis",o["peri"]).
	local inc is addField("Inclination",o["inc"]).
	local aop is addField("Arg. of Peri.",o["aop"]).
	local lan is addField("Long. of A.N.",o["lan"]).

	function wrObt{
		use("/l/writeOrbit2.ks")(par:value,apo:text:toScalar(0),per:text:toScalar(0),inc:text:toScalar(0),aop:text:toScalar(0),lan:text:toScalar(0)).
	}

	mnu:addSpacing(10).
	set mnu:addButton("Save"):onClick to wrObt@.

	mnu:addSpacing(10).
	set mnu:addButton("Reset to Current"):onClick to{
		set par:value to body.
		set apo:text to""+obt:apoapsis.
		set per:text to""+obt:periapsis.
		set inc:text to""+obt:inclination.
		set aop:text to""+obt:argumentOfPeriapsis.
		set lan:text to""+obt:lan.		
	}.
	set mnu:addButton("Parking Orbit"):onClick to{
		set apo:text to""+(par:value:atm:height+10_000).
		set per:text to apo:text.
	}.
    set mnu:addButton("Circularize (Apo)"):onClick to{set per:text to apo:text.}.
    set mnu:addButton("Circularize (Peri)"):onClick to{set apo:text to per:text.}.
	mnu:addSpacing(10).
	set mnu:addButton("Copy From Target"):onClick to{
		if not hasTarget return.
		set par:value to target:body.
		set apo:text to""+target:obt:apoapsis.
		set per:text to""+target:obt:periapsis.
		set inc:text to""+target:obt:inclination.
		set aop:text to""+target:obt:argumentOfPeriapsis.
		set lan:text to""+target:obt:lan.
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

	stk:showOnly(mnu).
}).