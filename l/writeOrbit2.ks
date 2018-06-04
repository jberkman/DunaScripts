@lazyglobal off.
parameter lib.
lib:add({parameter bdy,apo,per,inc,aop,lan.
	print "$ writeOrbit2.ks".
	use("/l/writeOrbit.ks")(Lexicon("body",bdy,"apo",apo,"peri",per,"inc",inc,"aop",aop,"lan",lan)).
}).