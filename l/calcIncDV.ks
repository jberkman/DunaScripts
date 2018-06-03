@lazyglobal off.
parameter lib.
lib:add({parameter t,v1 is obt:velocity:orbit:mag,v2 is v1.
    print"$ calcIncDV.ks".
    return List(v2*sin(t),v2*cos(t)-v1).
}).