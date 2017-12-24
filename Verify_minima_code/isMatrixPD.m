% Uses symbolic computations to determine whether the given matrix M is
% positive definite

% Outputs a lower bound for the smallest eigenvalue of M if it is guaranteed to be positive definite and -1 if
% the algorithm is inconclusive

function lambda = isMatrixPD(H)
    numH = double(vpa(H));
    eps1 = froNorm(eps(numH));
    [U, D] = eig(numH);
    UTU = sym(U)*sym(U');
    if isDiagDominant(UTU)
        E = sym(eye(size(numH, 1))) - UTU;
        A = sym(U)*sym(D)*sym(U');
        eps2 = froNorm(numH-A);
        B = min(sym(1) + froNorm(sym(eye(size(numH, 1))-sym(U))), froNorm(sym(U)));
        C = froNorm(E);
        sumBound = sym(1)/((sym(1)-C)^sym(0.5))-1;
        eps3 = B^2*(sym(2)*sym(D(1,1))*sumBound + sumBound^2);
        lambda = sym(D(1,1)) - eps1 - eps2 - eps3;
        if (symCompare(lambda,0)<=0)
            lambda = sym(-1);
        end
    else
        lambda = sym(-1);
    end
end