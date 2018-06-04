@lazyglobal off.
parameter lib.
lib:add({parameter stk,prv.
    print"$ scienceMenu.ks".
    local choice is 0.
    local mnu is stk:addVLayout().
    local bar is mnu:addHLayout().
    local btn is bar:addButton(" < ").
    set btn:onClick to{set choice to -1.}.
    set btn:style:hStretch to 0.
    bar:addSpacing(10).
    bar:addLabel("Science").
    mnu:addSpacing(10).

    local mods is ship:modulesNamed("ModuleScienceExperiment").
    local scr is mnu:addScrollbox().
    //set scr:style:height to 320.
    local chks is use("/l/map.ks")(mods,{parameter i.return scr:addCheckbox(i:part:name,true).}).

    function selected{
        local r is List().
        local i is 0.
        until i=mods:length{
            if chks[i]:pressed r:add(mods[i]).
            set i to i+1.
        }
        return r.
    }

    mnu:addSpacing(20).
    set mnu:addCheckbox("Select All",true):onToggle to{parameter on.
        for chk in chks set chk:pressed to on.
    }.

    mnu:addSpacing(20).
    set mnu:addButton("Record Science"):onClick to{set choice to 10.}.
    set mnu:addButton("Transmit Science"):onClick to{set choice to 20.}.

    mnu:addSpacing(20).
    set mnu:addButton("Run Scanners"):onClick to{set choice to 30.}.

    stk:showOnly(mnu).
    until choice<0{
        set choice to 0.
        wait until choice.
        if choice=10 use("/l/recordScience.ks")(selected()).
        else if choice=20 use("/l/xmitScience.ks")(selected()).
        else if choice=30 use("/l/scan.ks")().
    }
    stk:showOnly(prv).
    mnu:dispose().
}).
