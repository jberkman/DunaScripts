@lazyglobal off.
parameter lib.
lib:add({parameter l.
    print"$ etaToLAN.ks".
    return mod(900+l-longitude-body:rotationAngle,360)*body:rotationPeriod/360.
}).