@lazyglobal off.
parameter lib.
lib:add({parameter stk,prv.
	print"$ launchMenu.ks".
	local l is use("/l/readLaunch.ks")().
	local mnu is stk:addVLayout().
	local bar is mnu:addHLayout().
	local btn is bar:addButton(" < ").
	set btn:onClick to{stk:showOnly(prv).mnu:dispose().}.
	set btn:style:hStretch to 0.
	bar:addSpacing(10).
	bar:addLabel("Launch Parameters").
	mnu:addSpacing(10).

	local box is mnu:addHLayout().
	function addField{
		parameter lbl,val.
		local box is mnu:addHLayout().
		set box:addLabel(lbl+": "):style:hStretch to 0.
		return box:addTextField(""+val).
	}

	local pr is addField("Pitch Rate",l["pr"]).
	local land is mnu:addCheckBox("Recover Stage",l["land"]).
	local lat is addField("Landing Latitude",l["lat"]).
	local lng is addField("Landing Longitide",l["lng"]).

	function wrLnch{
		use("/l/writeLaunch2.ks")(pr:text:toScalar(0),land:pressed,lat:text:toScalar(0),lng:text:toScalar(0)).
	}

	set mnu:addButton("Save"):onClick to wrLnch@.

	mnu:addSpacing(20).
	set mnu:addButton("Land at Current Location"):onClick to{
		set lat:text to""+latitude.
		set lng:text to""+longitude.
	}.
	set mnu:addButton("Land at KSC Launch Pad"):onClick to{
		set lat:text to"-0.097207933678136".
		set lng:text to"-74.557757572037".
	}.
	set mnu:addButton("Land at Woomerang Launch Pad"):onClick to{
		set lat:text to"45.2899547826553".
		set lng:text to"136.110007435618".
	}.
	set mnu:addButton("Land at VAB 1"):onClick to{
		set lat:text to"-0.0967218940930756".
		set lng:text to"-74.6173570891441".
	}.

	mnu:addSpacing(20).
	set mnu:addButton("Copy to Other CPUs"):onClick to{
		for i in ship:modulesNamed("kOSProcessor"){
			if i<>core{
				switch to i:volume.
				wrLnch().
			}
		}
		switch to core:volume.
	}.

	stk:showOnly(mnu).
}).