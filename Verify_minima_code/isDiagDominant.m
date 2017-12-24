% Returns TRUE iff A is a diagonally dominant matrix
function result = isDiagDominant(A)
    A = abs(sym(A));
    A = -sym(A) + 2 * sym(diag(diag(A)));
    A = sum(sym(A));
    result = true;
    for i=1:length(A)
        result = and(result, symCompare(A(i),0)>0);
    end
end