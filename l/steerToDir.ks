@lazyglobal off.
parameter lib.
lib:add({
    print"$ steerToDir.ks".
    wait until vAng(steering:vector,facing:vector)<2 and vAng(steering:upVector,facing:upVector)<2.
}).