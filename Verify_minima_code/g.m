% Computes the gradient of the objective function at point W with respect
% to target values V

function grad = g(W, V)
    grad = sym(0.5)*sym(W);
    d = size(W, 1);
    n = size(W, 2);
    k = size(V, 2);
    for i=1:n
        for j=1:n
            if i~=j
                grad(:, i) = grad(:, i) + g1(W(:, i), W(:, j));
            end
        end
        for j=1:k
            grad(:, i) = grad(:, i) - g1(W(:, i), V(:, j));
        end
    end
end

function grad = g1(w, v)
    wbar = sym(w)/norm(sym(w));
    vbar = sym(v)/norm(sym(v));
    theta = acos(dot(wbar,vbar));
    sintheta = (1-dot(wbar, vbar)^2)^0.5;
    grad = (sym(1)/(sym(2)*sym(pi))) * (sintheta*norm(sym(v))*wbar+(sym(pi)-theta)*sym(v));
end