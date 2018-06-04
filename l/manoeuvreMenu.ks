@lazyglobal off.
parameter lib.
lib:add({parameter stk,prv.
    print"$ manouvreMenu.ks".
    local choice is 0.
    local mnu is stk:addVLayout().
    local bar is mnu:addHLayout().
    local btn is bar:addButton(" < ").
    set btn:onClick to{set choice to -1.}.
    set btn:style:hStretch to 0.
    bar:addSpacing(10).
    bar:addLabel("Plan Manouvre").

    mnu:addSpacing(10).
    set mnu:addButton("Change Apoapsis"):onClick to{set choice to 10.}.
    set mnu:addButton("Change Periapsis"):onClick to{set choice to 20.}.
    set mnu:addButton("Fine-Tune Semi-Major Axis"):onClick to{set choice to 30.}.

    mnu:addSpacing(10).
    set mnu:addButton("Change Inclination"):onClick to{set choice to 40.}.
    set mnu:addButton("Change Arg. of Periapsis"):onClick to{set choice to 50.}.

    mnu:addSpacing(10).
    set mnu:addButton("Hohmann Transfer"):onClick to{set choice to 60.}.
    set mnu:addButton("Transfer Correction"):onClick to{set choice to 70.}.
    set mnu:addButton("Mid-Course Correction"):onClick to{set choice to 80.}.

    mnu:addSpacing(10).
    set mnu:addButton("Capture Correction"):onClick to{set choice to 90.}.
    set mnu:addButton("Capture Burn"):onClick to{set choice to 100.}.

    stk:showOnly(mnu).
    until choice<0{
        set choice to 0.
        wait until choice.
        else if choice=10 use("/l/changeApo.ks")().
        else if choice=20 use("/l/changePeri.ks")().
        else if choice=30 use("/l/fineTuneSMA.ks")().
        else if choice=40 use("/l/changeInc.ks")().
        else if choice=50 use("/l/changeAOP.ks")().
        else if choice=60 use("/l/hohmannXfer.ks")().
        else if choice=70 use("/l/xferCorrection.ks")().
        else if choice=80 use("/l/midCourseCorrection.ks")().
        else if choice=90 use("/l/captureCorrection.ks")().
        else if choice=100 use("/l/captureBurn.ks")().
    }
    stk:showOnly(prv).
    mnu:dispose().
}).
