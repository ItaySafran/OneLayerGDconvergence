% Tries to find a permutation on the rows and columns such that ||perm(A)-B||_FRO is small, and
% returns ||perm(A)-B||_FRO

% Since the graph ismorphism problem can be reduced to the problem of
% determining whether two matrices are equal up to permutations, this
% algorithm instead tries to find a permutation based on heuristics, and if
% it fails it returns that the Frobenius difference is infinite.

% The resulting points returned by GD are very similar to the target
% values. That is, they are close to permutation matrices. The algorithm
% therefore rounds a given point to integer values, and then applies the
% resulting permutation matrix on the point to compare it with the other
% point, hopefully finding the correct way to permute A to B.
% If the rounding process does not result in a permutation matrix then Inf
% is returned

function froDiff = isPermutation(A, B)
    try
        n = size(A,2);
        d = size(A,1);
        indices = logical(round(A));
        if (n ~= d)
            i = find(~sum(double(indices),1));
            A = swapCols(A, i, n);
            indices = logical(round(A));
        end
        [~, I1] = sort(A(indices));
        P1 = A(:, I1);
        indices = logical(round(B));
        if (n ~= d)
            i = find(~sum(double(indices),1));
            B = swapCols(B, i, n);
            indices = logical(round(B));
        end
        [~, I2] = sort(B(indices));
        P2 = B(:, I2);
        P1 = round(abs(P1))^-1;
        P2 = round(abs(P2))^-1;
        assert(sum(abs(sum(P1,1) - ones(1, size(P1, 2)))) == 0)                %assert permutation matrices
        assert(sum(abs(sum(P1,2) - ones(size(P1, 1), 1))) == 0)                %assert permutation matrices
        assert(sum(abs(sum(P2,1) - ones(1, size(P2, 2)))) == 0)                %assert permutation matrices
        assert(sum(abs(sum(P2,2) - ones(size(P2, 1), 1))) == 0)                %assert permutation matrices
        if (n ~= d)
            assert(sum(abs(sort([I1; n]) - [1:(length(I1)+1)]')) == 0)         %assert valid permutation
            assert(sum(abs(sort([I2; n]) - [1:(length(I2)+1)]')) == 0)         %assert valid permutation
            permA = P1*A(:, [I1; n]);
            permB = P2*B(:, [I2; n]);
        else
            assert(sum(abs(sort(I1) - [1:length(I1)]')) == 0)                  %assert valid permutation
            assert(sum(abs(sort(I2) - [1:length(I2)]')) == 0)                  %assert valid permutation
            permA = P1*A(:, I1);
            permB = P2*B(:, I2);
        end
        froDiff = froNorm(sym(permA)-sym(permB));
    catch
        froDiff = Inf;
    end
end

function result = swapCols(A, i, j)
    I = 1:size(A,2);
    I(i) = j;
    I(j) = i;
    result = A(:, I);
end

