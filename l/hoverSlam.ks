@lazyglobal off.
parameter lib.
local rdLnch is use("/l/readLaunch.ks").
local thrustVec is use("/l/thrustVec.ks").
lib:add({parameter lat is rdLnch()["lat"],lng is rdLnch()["lng"].
	local landingZone is LatLng(lat,lng).

	function accelG{parameter y is altitude.
		return body:mu/(body:radius+y)^2.
	}

	function fuelFlow{
		local m is 0.
		local el is 0.
		list engines in el.
		for eng in el set m to m+eng:availableThrustAt(0)/eng:ispAt(0).
		return m/9.80665.
	}

	function thrustVec{parameter y is altitude.
		local p is body:atm:altitudePressure(y).
		local t is V(0,0,0).
		local el is 0.
		list engines in el.
		for eng in el set t to t+(eng:availableThrustAt(p)*eng:facing:vector).
		return t.
	}

	function productLog{parameter z,w is 2.5,e is 1e-15.
		function f{parameter w.
			local ew is constant:e^w.
			local dw is(w*ew-z)/(w+1)/ew.
			local wn is w-dw.
			//print wn.
			if abs(dw)<e return wn.
			return f(wn).
		}
		return f(w).
	}

	function stoppingTime{parameter v,Ft,m,m_,g is accelG(0).
		local a is-(g*m+v*m_)/Ft.
		local z is-g*m/Ft*constant:e^a.
		return(Ft/g*productLog(z)+m)/m_.
	}

	function stoppingDistance{parameter v,Ft,m,m_,t,g is accelG(0).
		local a is ln(1-t*m_/m).
		local b is a*(t-m/m_).
		local c is Ft/m_*(b-t).
		return c+t*(v+g*t/2).
	}

	function stoppingDistance2{parameter Ft,m_,g is accelG(0).
		local t is stoppingTime(-verticalSpeed,Ft,mass,m_,g).
		return stoppingDistance(-verticalSpeed,Ft,mass,m_,t,g).
	}

	function test{
		local v is 250.
		local m is 10.8.
		local Ft is 167.97.
		local Isp is 250.
		local m_ is Ft/accelG(0)/Isp.

		print stoppingTime(v,Ft,m,m_).
		print stoppingDistance(v,Ft,m,m_,stoppingTime(v,Ft,m,m_)).
	}

	function partOffset{parameter p.
		return vDot(ship:facing:vector,p:position).
	}

	function rearwardPart{
		local x is 0.
		local p is 0.
		for part in ship:parts{
			local t is partOffset(part).
			if t<x{
				set x to t.
				set p to part.
			}
		}
		return p.
	}

	local offsetPart is rearwardPart().
	function heightOffset{return partOffset(offsetPart).}

	local posVec is vecDraw(V(0,0,0),V(0,0,0),red,"WYPT",1,true,0.2).
	local velVec is vecDraw(V(0,0,0),V(0,0,0),blue,"VEL",1,true,0.2).
	local dscVec is vecDraw(V(0,0,0),V(0,0,0),yellow,"VCRS",1,true,0.2).
	local strVec is vecDraw(V(0,0,0),V(0,0,0),green,"STEER",1,true,0.2).

	function waypointPosition{
		//return landingZone:position+(altitude+landingZone:terrainHeight)/4*(landingZone:position-body:position):normalized.
		return landingZone:altitudePosition((altitude+landingZone:terrainHeight)/4).
	}

	function steerTo {
		parameter vec,mult.
		local vel is ship:velocity:surface.
		return angleAxis(max(-45,min(45,mult*vAng(vel,vec))),vCrs(vel,vec))*-vel.
	}

	//function descentDir {
	//    parameter tgt.
	//    local vel is ship:velocity:surface.
	//    return angleAxis(2*vAng(vel,tgt),vCrs(tgt,vel))*-vel.
	//}

	function constrainSteering {
		parameter vec, maxGamma is 20.

		local vHat is ship:up:vector.
		local vAccV is vHat*vDot(vHat,vec).

		local hHat is vCrs(vCrs(vHat,vec),vHat):normalized.
		local hDot is vDot(hHat,vec).
		local hSign is hDot/abs(hDot).
		local hAccV is hSign*hHat*min(abs(hDot),vAccV:mag*tan(maxGamma)).
		//print "hDot: "+round(hDot,2)+"    hAcc: "+round(hAccv:mag,2).
		//set hVec:vec to hAccV.
		return vAccV+hAccV.
	}

	function idle{
		parameter t is 0.
		print landingZone+"    "+body:geoPositionOf(waypointPosition).
		set posVec:vec to waypointPosition.
		set velVec:vec to ship:velocity:surface.
		set dscVec:vec to 10*vCrs(ship:velocity:surface,posVec:vec):normalized.
		//set dscVec:vec to -descentDir(posVec:vec).
		set strVec:vec to -steerTo(waypointPosition,5).
		wait(t).
	}

	local Ft is thrustVec(0):mag.
	local m_ is fuelFlow().
	local g is accelG(0).

	local lock terrainHeight to ship:geoPosition:terrainHeight.
	local lock targetHeight to max(terrainHeight,landingZone:terrainHeight).
	local lock altRadar to altitude-targetHeight+heightOffset.

	rcs on.
	lock steering to lookDirUp(-ship:velocity:surface,heading(90,-45):vector).

	wait until altitude<30_000.
	lock steering to lookDirUp(steerTo(waypointPosition,5),heading(90,-45):vector).

	//until stoppingDistance2(Ft, m_, g) > (altRadar + verticalSpeed) print "d: "+stoppingDistance2(Ft,m_,g)+"    y: "+(altRadar+verticalSpeed).
	until stoppingDistance2(Ft, m_, g) > altRadar print "d: "+stoppingDistance2(Ft,m_,g)+"    y: "+altRadar.
	lock steering to lookDirUp(steerTo(waypointPosition,-2),heading(90,-45):vector).

	//until 0{
	//    local t is stoppingTime(-verticalSpeed, Ft, mass, m_, g).
	//    if round(t) < 3 break.
	//    print "Stopping time: "+round(t,1)+"      t: "+throttle.
	//    local h is stoppingDistance(-verticalSpeed, Ft, mass, m_, t, g).
	//    if h > altRadar lock throttle to 1.
	//    else if h < altRadar / 2 {
	//        lock throttle to mass * g / Ft / 2.
	//        gear on.
	//    }
	//    idle(0.2).
	//}
	lock throttle to 1.
	wait until airSpeed/(Ft/mass-g)<1.
	gear on.
	//lock landingZone to ship:geoPosition:position.
	lock steering to lookDirUp(-ship:velocity:surface,heading(90,-45):vector).
	//lock steering to lookDirUp(descentDir(ship:geoPosition:position),heading(90,-45):vector).
	lock throttle to 0.5.
	wait until verticalSpeed>-5.

	//lock steering to lookDirUp(-ship:velocity:surface,heading(90,-45):vector).
	//lock steering to lookDirUp(ship:up:vector,heading(90,-45):vector).
	until status="LANDED"{
		local tgtPos is ship:geoPosition.
		local tgtVel is -5*ship:up:vector.

		local tgtAcc is tgtVel - ship:velocity:surface + g*ship:up:vector.

		local accV is constrainSteering(tgtAcc).
		lock steering to lookDirUp(accV,heading(90,-45):vector).

	//    local tgtAccHor is vxcl(ship:up:vector,tgtAcc).
	//    local tgtAccVer is tgtAcc-tgtAccHor.
		//print (ship:up:vector*tgtVel)+"        "+(ship:up:vector*ship:velocity:surface)+"        "+(-g)+"        "+tgtAccVer:mag.

	//    local tAcc is thrustVec()/mass.
	//    local tAccHor is vxcl(ship:up:vector,tAcc).
	//    local tAccVer is tAcc-tAccHor.

		// lock throttle to tgtAccVer:mag / tAccVer:mag.
		//lock throttle to (ship:up:vector * tgtAccVer) / (ship:up:vector * tAcc).
	//    print (g-5-verticalSpeed)+"        "+(ship:up:vector*thrustVec()/mass).
		lock throttle to (g-5-verticalSpeed)/(ship:up:vector*thrustVec()/mass).
		//print "accVer: "+(ship:up:vector * tgtAccVer)+"        tAccVer: "+(ship:up:vector * tAcc)+"        "+throttle.
		wait 0.
	}

	lock throttle to 0.
	lock steering to lookDirUp(ship:up:vector,heading(90,-45):vector).
	wait 30.
	unlock steering.
	rcs off.
}).