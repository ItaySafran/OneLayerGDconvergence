% Computes the Hessian of the objective function at point W with respect
% to target values V

function [hess] = Hessian(W, V)
    d = size(W, 1);
    n = size(W, 2);
    hess = sym(zeros(0,0));
    for i=1:n
        hess = blkdiag(hess, mainDiag(W, V, i));
    end
    for i=1:n
        for j=(i+1):n    
            hess(((d*(i-1)+1):(d*i)), ((d*(j-1)+1):(d*j))) = h2(W(:, i), W(:, j));
            hess(((d*(j-1)+1):(d*j)), ((d*(i-1)+1):(d*i))) = hess(((d*(i-1)+1):(d*i)), ((d*(j-1)+1):(d*j)));
        end
    end
end

function [ res ] = mainDiag(W, V, i)
    d = size(W, 1);
    n = size(W, 2);
    k = size(V, 2);
    res = 0.5*sym(eye(d));
    for j=1:n
        if (i~=j)
            res = res + h1(W(:, i),W(:, j));
        end
    end
    for j=1:k
        res = res - h1(W(:, i), V(:, j));
    end
end

function [ res ] = h1(w, v)
    wbar = sym(w)/norm(sym(w));
    vbar = sym(v)/norm(sym(v));
    sintheta = (sym(1)-sym(dot(sym(wbar), sym(vbar)))^sym(2))^sym(0.5);
    res = norm(sym(v))/(sym(2)*sym(pi)*sym(sintheta)*norm(sym(w)))*((1-dot(sym(wbar), vbar)^2)*(sym(eye(length(w)))-sym(wbar)*sym(wbar'))+(dot(sym(wbar),sym(vbar))*sym(wbar)-sym(vbar))*(dot(sym(wbar),sym(vbar))*sym(wbar)-sym(vbar))');
end

function [ res ] = h2(w, v)
    wbar = sym(w)/norm(sym(w));
    vbar = sym(v)/norm(sym(v));
    theta = acos(dot(sym(wbar),sym(vbar)));
    sintheta = (sym(1)-dot(sym(wbar), sym(vbar))^sym(2))^sym(0.5);
    res = sym(1)/(sym(2)*sym(pi))*(sym(eye(length(w)))*(sym(pi)-sym(theta)))+sym(1)/(sym(2)*sym(pi)*sym(sintheta))*((sym(wbar)+sym(vbar))*(sym(wbar)+sym(vbar))'-((sym(1)+dot(sym(wbar),sym(vbar)))*(sym(wbar)*sym(wbar)'+sym(vbar)*sym(vbar)')));
end