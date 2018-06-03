@lazyglobal off.
parameter lib.
lib:add({parameter solve,nd,st.
    print"$ findNode.ks".
    local cn is use("/l/clearNodes.ks").
    local l2n is use("/l/listToNode.ks").
    local n2l is use("/l/nodeToList.ks").
    local x is l2n(solve(n2l(nd),st,{parameter x.cn().add l2n(x).wait 0. return nextNode.})).
    cn().
    return x.
}).