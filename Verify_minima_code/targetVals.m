% Produces i unit target vectors of dimension d
function targetvalues = targetVals(d, i)
    targetvalues = eye(d);
    targetvalues = targetvalues(:, 1:i);
end