@lazyglobal off.
parameter lib.
lib:add({parameter o,h,a is o:semiMajorAxis.
    print"$ calcOrbVel.ks".
    return sqrt(o:body:mu*(2/(h+o:body:radius)-1/a)).
}).