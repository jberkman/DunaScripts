@lazyglobal off.
parameter lib.
local cache is Lex().
lib:add({
	parameter p.
	if not cache:hasKey(p){
		//if not exists(p)copyPath("0:"+p,p).
		local lib is List().
        print(". "+p).
		runPath("0:"+p,lib).
		set cache[p]to lib[0].
	}
	return cache[p].
}).