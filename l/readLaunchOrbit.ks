@lazyglobal off.
parameter lib.
lib:add({
    print"$ readLaunchOrbit.ks".
    local o is use("/l/readOrbit.ks")().
    local b is o["body"].
    if b<>body{
        set o to Lex("body",body,"apo",body:atm:height+10_000,"peri",body:atm:height+10_000,"inc",0,"lan",-1,"aop",-1).
        if b:hasBody and b:body=body{
            set o["inc"]to b:obt:inclination.
            set o["lan"]to b:obt:lan.
        }
    }
    set o["inc"]to max(o["inc"],abs(latitude)).
    return o.
}).