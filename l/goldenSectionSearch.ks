@lazyglobal off.
parameter lib.
lib:add({parameter a,b,e,f.
	local g is(sqrt(5)+1)*0.5. 
	until 0{
		local c is b-(b-a)/g.
		local d is a+(b-a)/g.
		if abs(c-d)<e break.
		if f(c)<f(d)set b to d.
		else set a to c.
	}
	return(a+b)*0.5.
}).