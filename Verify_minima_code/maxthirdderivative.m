% Input:
% W - A point returned by gradient descent
% V - the true target values obtaining 0 error
% r - the maximal distance to deviate from W in the approximation
%
% Output: a bound on the maximal third order derivative of a point inside
% the ball of radius r centered at W

function bound = maxthirdderivative(W, V, r)
    n = sym(size(W, 2));
    k = sym(size(V, 2));
    wmax = sym(max(sum(sym(W).^2,1).^0.5)) + sym(r);
    vmax = sym(max(sum(sym(V).^2,1).^0.5));
    wmin = sym(min(sum(sym(W).^2,1).^0.5)) - sym(r);
    bound = n*(sym(2)^sym(0.5)*(n-sym(1))*(wmax+wmin)+k*vmax)/(sym(pi)*wmin^sym(2));
end