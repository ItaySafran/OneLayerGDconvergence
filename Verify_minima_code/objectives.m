% Input:
% W - A point returned by gradient descent
% V - the true target values obtaining 0 error
% r - the radius around W where the objective value may deviate
%
% Output:
% objValue - objective value obtained at point W
% dev - maximal deviation in objective value when deviating by at most distance r from W

function [objValue, dev] = objectives(W, V, r)
    objValue = objVal(W, V);
    n = sym(size(W, 2));
    k = sym(size(V, 2));
    wmax = sym(max(sum(sym(W).^2,1).^0.5)) + sym(r);
    vmax = sym(max(sum(sym(V).^2,1).^0.5));
    wmin = sym(min(sum(sym(W).^2,1).^0.5)) - sym(r);
    LH = sym(0.5) + n*(n-1)*(wmax/(sym(2)*sym(pi)*wmin)+sym(0.5))+n*k*vmax/sym(2)*sym(pi)*wmin;
    dev = sym(r) * (LH*sym(r) + froNorm(g(W, V)));
end