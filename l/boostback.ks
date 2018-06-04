@lazyglobal off.
parameter lib.
local cn is use("/l/clearNodes.ks").
local rdLnch is use("/l/readLaunch.ks").
lib:add({parameter lat is rdLnch()["lat"],lng is rdLnch()["lng"].
	function fallTime {
		parameter r is altitude,x is 0,b is body.
		local xr is (x+b:radius)/(r+b:radius).
		local xr2 is sqrt(xr).
		return (r+b:radius)^1.5*(constant:degToRad*arccos(xr2)+xr2*sqrt(1-xr))/sqrt(2*b:mu).
	}

	function presentGeoPositionToFuture{parameter y,t.
		return LatLng(y:lat,y:lng+(t-time:seconds)*360/body:rotationPeriod).    
	}

	function futureGeoPositionToPresent{parameter y,t.
		return LatLng(y:lat,y:lng-(t-time:seconds)*360/body:rotationPeriod).
	}

	function surfaceHeightAt {parameter t2.
		local pos is positionAt(ship,t2).
		local alt1 is (pos-body:position):mag-body:radius.
		local geo is futureGeoPositionToPresent(body:geoPositionOf(pos),t2).
		local alt2 is max(0,geo:terrainHeight).
		return alt1-alt2.
	}

	function impactTime {parameter y is 0.
		local t is time:seconds+eta:apoapsis+fallTime(apoapsis).
		local t0 is t-10.
		local t1 is t+10.
		until t1-t0<0.01 {
			local h is surfaceHeightAt(t).
			if abs(h-y)<1 return t.
			if h>y set t0 to t.
			else set t1 to t.
			set t to (t0+t1)/2.
		}
		return (t1+t0)/2.
	}

	function impactDistance {parameter tgt.
		local t1 is impactTime(20_000).
		local p1 is futureGeoPositionToPresent(body:geoPositionOf(positionAt(ship,t1)),t1):position.
		//set posVec:vec to p1.
		//set geoVec:vec to tgt:position.
		//print"p1: "+p1+"      tgt: "+tgt:position+"      diff: "+(tgt:position-p1).
		return (tgt:position-p1):mag.
	}

	function coordGradDescent{parameter x,dx,f,a,e.
		local prevFx is 1e278.
		local bestF is prevFx.
		local bestX is x.
		until abs(dx:x)<e and abs(dx:y)<e and abs(dx:z)<e{
			local fx is f(x).
			if fx<bestF{
				set bestF to fx.
				set bestX to x.
			}else if fx>prevFx{
				//print"a => "+(a/2).
				set a to 0.5*a.
			}
			set prevFx to fx.
			//local df is f(x+V(0,0,dx:z))-fx.
			//print"df: "+df+"      dz: "+dx:z+"      df/dz: "+(df/dx:z).
			if dx:x <> 0 set dx:x to a*(f(x+V(dx:x,0,0))-fx)/dx:x.
			if dx:y <> 0 set dx:y to a*(f(x+V(0,dx:y,0))-fx)/dx:y.
			if dx:z <> 0 set dx:z to a*(f(x+V(0,0,dx:z))-fx)/dx:z.
			set x to x-dx.
			//print"f "+fx+"    => dx "+dx+"    => x "+x.
		}
		return bestX.
	}

	local landingZone is LatLng(lat,lng).

	function testNode{
		parameter x.
		//print"got x: "+x.
		add Node(time:seconds+eta:apoapsis,x:x,x:y,x:z).
		wait 0.
		local d is impactDistance(landingZone).
		remove nextNode.
		wait 0.
		//print"d => "+d.
		return d.
	}

	wait until ship=kUniverse:activeVessel.
	cn().
	rcs on.
	lock steering to lookDirUp(-ship:velocity:surface,heading(90,-45):vector).
	//local posVec is vecDraw(V(0,0,0),V(0,0,0),red,"POS",1,true,0.2).
	//local geoVec is vecDraw(V(0,0,0),V(0,0,0),green,"SFC",1,true,0.2).

	local x is coordGradDescent(V(0,0,0),V(0,10,10),testNode@,1,0.025).
	add Node(time:seconds+eta:apoapsis,x:x,x:y,x:z).
}).