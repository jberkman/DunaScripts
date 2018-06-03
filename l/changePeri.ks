@lazyglobal off.
parameter lib.
lib:add({parameter h is use("/l/readOrbit.ks")()["peri"].
    print"$ changePeri.ks".
    local t is time:seconds+eta:apoapsis.
    local dv is use("/l/calcHohmannDV.ks")(t,h).
    add Node(t,0,0,dv).
    wait 0.
}).