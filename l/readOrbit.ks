@lazyglobal off.
parameter lib.
lib:add({
    print "$ readOrbit.ks".
    if not exists("/orbit.json")return Lexicon("body",body,"apo",obt:apoapsis,"peri",obt:periapsis,"inc",obt:inclination,"aop",obt:argumentOfPeriapsis,"lan",obt:lan).
    local o is readJSON("/orbit.json").
    set o["body"]to Body(o["body"]).
    return o.
}).