@lazyglobal off.
parameter lib.
local wo is use("/l/writeOrbit.ks").
lib:add({
    parameter bdy,apo,per,inc,aop,lan.
    wo(Lexicon("body",bdy,"apo",apo,"peri",per,"inc",inc,"aop",aop,"lan",lan)).
}).