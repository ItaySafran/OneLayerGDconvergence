function [Wbad,objVals] = findBadMinima(k,V,Tmax,runTillFound)
% function [Wbad,n] = findBadMinima(k,V,Tmax)
% Given target weights V, number of neurons k, and maximal number of trials Tmax, search for bad local minimum to
% which gradient descent converges. Returns all bad local minima found as a
% tensor ({Wbad(:,:,i)}_i), and the vectors of bad objective values
% (objVals)
% - If runTillFound is true, then keeps trying till find a bad minimum, or
% Tmax trials is reached.
% - If runTillFound is false, then runs exactly Tmax trials.

%%%%%% Parameters %%%%%%
bad_minima_value_bound = 10^(-3); % Looks for points whose objective value is at least this
stepsize = 0.1;
gradnorm_target = 10^(-9); % Will stop once norm of gradient w.r.t. any neuron is less than this
%%%%%%%%%%%%%%%%%%%%%%%%

d = size(V,1);
n = 0;

objVals = [];
Wbad = [];

if runTillFound
    objective_value = 0;
    while (n<Tmax) && (objective_value<bad_minima_value_bound)
        W = randn(d,k)/sqrt(d); % Xavier initialization
        [W] = findMinimum(W,V,stepsize,gradnorm_target);
        objective_value = objval(W,V);
        n = n+1;
        fprintf('Attempt %d, value obtained: %f\n',n,objective_value);
    end
    if (objective_value>=bad_minima_value_bound)
        Wbad = W;
        objVals = objective_value;
    end;
else
    for t=1:Tmax 
        W = randn(d,k)/sqrt(d); % Xavier initialization
        [W] = findMinimum(W,V,stepsize,gradnorm_target);
        objective_value = objval(W,V);
        if objective_value>=bad_minima_value_bound
            n = n+1;
            Wbad(:,:,n) = W;
            objVals(n) = objective_value;
        end;
        fprintf('Attempt %d out of %d, value obtained: %f\n',t,Tmax,objective_value);
    end;
end;