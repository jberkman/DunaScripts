@lazyglobal off.
parameter lib.
lib:add({
    print "$ readLaunch.ks".
    if exists("/launch.json")return readJSON("/launch.json").
    return Lex("pr",0.1,"land",false,"lat",0,"lng",0).
}).