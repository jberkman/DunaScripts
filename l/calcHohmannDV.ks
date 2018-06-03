@lazyglobal off.
parameter lib.
local ov is use("/l/calcOrbVel.ks").
lib:add({parameter t,h1,o is ship.
    print"$ calcHohmannDV.ks".
    local h0 is (positionAt(o,t)-o:obt:body:position):mag-o:obt:body:radius.
    return ov(o:obt,h0,0.5*(h0+h1)+o:obt:body:radius)-ov(o:obt,h0).
}).