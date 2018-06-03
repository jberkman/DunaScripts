@lazyglobal off.
parameter lib.
local rdObt is use("/l/readOrbit.ks").
lib:add({parameter alt is-1,aop is rdObt()["aop"].
    print"$ changeAOP.ks".
    if alt<0{
        local o is rdObt().
        local apo is o["apo"].
        local peri is o["peri"].
        if abs(apo-altitude)>abs(peri-altitude) set h to apo.
        else set alt to peri.
    }
    local hal is use("/l/mooSolver.ks").
    local hohmann is use("/l/calcHohmannDV.ks").
    local find is use("/l/findNode.ks").
    local t is time:seconds+obt:period/2.
    local nd is Node(t,0,0,hohmann(t,alt)).
    if aop>=0{
        local h is hal().
        h["add"](0.1,{parameter n.return n:obt:argumentOfPeriapsis-aop.}).
        add find(h["solve"]@,nd,List(obt:period/36,0,0,0)).
    }else add nd.
    if nextNode:eta<30 set nextNode:eta to nextNode:eta+obt:period.
    set nextNode:prograde to hohmann(time:seconds+nextNode:eta,alt).
}).