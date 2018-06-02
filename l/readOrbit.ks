@lazyglobal off.
parameter lib.
lib:add({
    print "$ readOrbit.ks".
    if exists("/orbit.js")return readJSON("/orbit.js").
    return Lexicon("body",body,"apo",obt:apoapsis,"peri",obt:periapsis,"inc",obt:inclination,"aop",obt:argumentOfPeriapsis,"lan",obt:lan).
}).