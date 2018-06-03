@lazyglobal off.
parameter lib.
lib:add({
    print"$ changeApo.ks".
    local h is use("/l/readOrbit.ks")()["apo"].
    local t is time:seconds+eta:apoapsis.
    local dv is use("/l/calcHohmannDV.ks")(t,h).
    add Node(t,0,0,dv).
    wait 0.
}).