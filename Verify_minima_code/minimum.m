% Input:
% W - A point returned by gradient descent
% V - the true target values obtaining 0 error
% maxFroDiff - the maximal difference in norm between the representative W
% and the rest of the matrices equivalent to W up to permutations of its
% rows and columns
%
% Output:
% r - what is the radius around W in which it is guaranteed to have a bad local
% minimum
% lambdaMin - the minimal eigenvalue for any matrix equivalent to W up to permutations of its
% rows and columns
% objValue - objective value obtained at point W
% dev - maximal deviation in objective value from the objective of W to the
% objective of the local minimum

%function [r, deviation] = minimum(W, V, val, radius, epsi)
function [r, lambdaMin, objValue, dev] = minimum(W, V, maxFroDiff)
    wmax = max(sum(sym(W).^2,1).^0.5);
    wmin = min(sum(sym(W).^2,1).^0.5);
    wmaxfraction = sym(10^-3);
    bound = maxthirdderivative(W, V, wmaxfraction*wmax);                   % wmaxfraction*wmax is the radius around W where the third order bound holds, which must eventually be larger than r
    lambdaMin = isMatrixPD(Hessian(W, V)) - maxthirdderivative(W, V, maxFroDiff) * maxFroDiff;
    if (symCompare(lambdaMin,0)>0)
        gnorm = froNorm(g(W, V));
        discriminant = sym(9)*lambdaMin^2-sym(25)*gnorm*bound;
        if (symCompare(discriminant,0)>=0)
            r = (sym(3)*lambdaMin-discriminant^0.5)/(sym(2)*bound);
            if (symCompare(r,wmaxfraction*wmax)<=0)
                if and((symCompare(sym(2)*r, minNeuronDist(W)) < 0), symCompare(wmin,r) > 0)
                    [objValue, dev] = objectives(W, V, r + maxFroDiff);
                else
                    % error -4: Returned ball enclosing minimum may contain
                    % non-differentiable points
                    lambdaMin = sym(-4);
                    r = sym(-4);
                    objValue = sym(-4);
                    dev = sym(-4);
                end
            else
                % error -3: Returned radius enclosing minimum larger than
                % what is required for third derivative bound to hold
                lambdaMin = sym(-3);
                r = sym(-3);
                objValue = sym(-3);
                dev = sym(-3);
            end
        else
            % error -2: Negative discriminant; gradient at point too large
            % and/or smallest eigenvalue too small to give a guarantee
            lambdaMin = sym(-2);
            r = sym(-2);
            objValue = sym(-2);
            dev = sym(-2);
        end
    else
        % error -1: Hessian cannot be verified as positive definite
        lambdaMin = sym(-1);
        r = sym(-1);
        objValue = sym(-1);
        dev = sym(-1);
    end
end

% returns the minimal Euclidean distance between two neurons (columns) of W
function dist = minNeuronDist(W)
    n = size(W,2);
    dist = sym(Inf);
    for i=1:n
        for j=i+1:n
            dist = min(dist, sum((sym(W(:,i))-sym(W(:,j))).^2).^0.5);
        end
    end
end