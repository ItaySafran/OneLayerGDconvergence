% Symbolically computes the objective at point W with target values V
function val = objVal(W, V)
    n = size(W, 2);
    k = size(V, 2);
    norms = [sum(sym(W).^2,1), sum(sym(V).^2,1)].^sym(0.5);
    norms = norms' * norms;
    cosines = ([sym(W), sym(V)]' * [sym(W), sym(V)])./norms;
    sines = (sym(ones(size(cosines)))-cosines.^2).^sym(0.5);
    thetas = acos(cosines);
    F = sym(1)/(sym(4) * sym(pi)) * norms .* (sines + ((sym(pi)*sym(ones(size(cosines))) - thetas) .* cosines));
    signs = [ones(n, 1); -ones(k, 1)];
    F = F .* (signs*signs');
    val = sum(sum(F));
end