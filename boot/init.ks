@lazyglobal off.
parameter force is false.
if not exists("/l/use.ks")copyPath("0:l/use.ks","/l/use.ks").
local lib is List().
runPath("/l/use.ks",lib).
global use is lib[0].
use("/l/main.ks")(force).