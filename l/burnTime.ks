@lazyglobal off.
parameter lib.
local t is use("/l/thrustVec.ks").
lib:add({return ship:mass*sqrt(nextNode:deltaV:sqrMagnitude/t():sqrMagnitude).}).