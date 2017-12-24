function [Wbad,objVals] = run_findBadMinima(kV,kW,seed)
V = [eye(kV)]; %%%%%%%%%%%%%%% ;zeros(kW,kV)];
Tmax = 100; %%%%%%% 1000;
rng(seed);
[Wbad,objVals] = findBadMinima(kW,V,Tmax,false);
