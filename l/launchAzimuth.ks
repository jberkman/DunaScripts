@lazyglobal off.
parameter lib.
lib:add({parameter i.return 180-arcsin(use("/l/clamp.ks")(cos(i)/cos(latitude),-1,1)).}).